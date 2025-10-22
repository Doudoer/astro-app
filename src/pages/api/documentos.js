import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
import { requireAuth } from './_auth.js';
dotenv.config();

export const prerender = false;

async function getConnection(){
  return await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
}

export async function GET(){
  const conn = await getConnection();
  const [rows] = await conn.execute('SELECT d.id, d.doc_number, d.tipo, d.currency, d.total_usd, d.created_at, d.bcv_rate, c.name as cliente FROM documents d LEFT JOIN clients c ON d.cliente_id = c.id ORDER BY d.created_at DESC LIMIT 200');
  await conn.end();
  return new Response(JSON.stringify({ ok:true, data: rows }), { status:200, headers: { 'Content-Type':'application/json' } });
}

// Expected body: { tipo: 'CT'|'ND', cliente_id, currency, exchange_rate, items: [{product_id, description, quantity, unit_price_usd, discount}] }
export async function POST({ request }){
  // allow any authenticated user (role 'user' or 'admin') to create documents
  const auth = await requireAuth(request);
  if(!auth.ok) return auth.response;
  const body = await request.json();
  const { tipo='CT', cliente_id=null, currency='USD', exchange_rate=1.0, bcv_rate=null, items=[] } = body;
  // If currency is VES, ensure we persist a bcv_rate: prefer explicit bcv_rate, otherwise use exchange_rate
  let bcv_rate_to_store = bcv_rate == null ? null : bcv_rate;
  if((currency||'').toUpperCase() === 'VES'){
    if(bcv_rate_to_store == null){
      // fallback to exchange_rate when BCV is not explicitly provided
      bcv_rate_to_store = exchange_rate;
    }
  } else {
    // For non-VES currencies we don't store BCV rate
    bcv_rate_to_store = null;
  }
  if(!Array.isArray(items) || items.length === 0) return new Response(JSON.stringify({ ok:false, error:'Items vacíos' }), { status:400 });

  const conn = await getConnection();
  try{
    await conn.beginTransaction();
    // get and increment counter atomically
    const [cRows] = await conn.execute('SELECT value FROM counters WHERE name = ? FOR UPDATE', [tipo]);
    let next = 1;
    if(cRows.length === 0){
      await conn.execute('INSERT INTO counters (name, value) VALUES (?, ?)', [tipo, 1]);
      next = 1;
    } else {
      next = cRows[0].value + 1;
      await conn.execute('UPDATE counters SET value = ? WHERE name = ?', [next, tipo]);
    }

    const year = new Date().getFullYear();
    const docNumber = `${tipo}-${year}-${String(next).padStart(6,'0')}`;

    // calculate totals
    let subtotal = 0;
    for(const it of items){
      const q = Number(it.quantity || 0);
      const up = Number(it.unit_price_usd || 0);
      const disc = Number(it.discount || 0);
      const lineTotal = q * up - disc;
      subtotal += lineTotal;
    }
    // Do NOT apply IVA when document is in USD
    let tax = 0;
    if(((currency||'').toUpperCase()) !== 'USD'){
      tax = +(subtotal * 0.16).toFixed(2);
    }
    const total = +(subtotal + tax).toFixed(2);

    // use stored BCV rate when available for Bs.F conversions, otherwise use exchange_rate
    const rateForBsf = (bcv_rate_to_store != null) ? Number(bcv_rate_to_store) : Number(exchange_rate || 1);
    const subtotal_bsf = +(subtotal * rateForBsf).toFixed(2);
    const tax_bsf = +(tax * rateForBsf).toFixed(2);
    const total_bsf = +(total * rateForBsf).toFixed(2);
  const [res] = await conn.execute('INSERT INTO documents (doc_number, tipo, cliente_id, currency, exchange_rate, bcv_rate, subtotal_usd, tax_usd, total_usd, subtotal_bsf, tax_bsf, total_bsf) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [docNumber, tipo, cliente_id, currency, exchange_rate, bcv_rate_to_store, subtotal.toFixed(2), tax.toFixed(2), total.toFixed(2), subtotal_bsf, tax_bsf, total_bsf]);
    const docId = res.insertId;

    // insert items
    for(const it of items){
      const q = Number(it.quantity || 0);
      const up = Number(it.unit_price_usd || 0);
      const disc = Number(it.discount || 0);
  const lineTotal = +(q * up - disc).toFixed(2);
  const unit_bsf = +(up * rateForBsf).toFixed(4);
  const total_bsf_line = +(lineTotal * rateForBsf).toFixed(2);
  await conn.execute('INSERT INTO document_items (document_id, product_id, description, quantity, unit_price_usd, discount, total_usd, unit_price_bsf, total_bsf) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', [docId, it.product_id || null, it.description || null, q, up, disc, lineTotal, unit_bsf, total_bsf_line]);
    }

    await conn.commit();
    await conn.end();
  return new Response(JSON.stringify({ ok:true, doc_number: docNumber, id: docId, subtotal_bsf, tax_bsf, total_bsf, bcv_rate: bcv_rate_to_store }), { status:200, headers: { 'Content-Type':'application/json' } });
  } catch(err){
    await conn.rollback();
    await conn.end();
    console.error(err);
    return new Response(JSON.stringify({ ok:false, error: String(err) }), { status:500 });
  }
}
