import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
import { requireAdmin } from '../_auth.js';
dotenv.config();

export const prerender = false;

async function getConn(){
  return await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
}

export async function GET({ params }){
  const id = params.id;
  const conn = await getConn();
  const [rows] = await conn.execute('SELECT d.*, c.name as cliente, c.rif_ci as cliente_rif, c.phone as cliente_phone, c.address as cliente_address FROM documents d LEFT JOIN clients c ON d.cliente_id = c.id WHERE d.id = ?', [id]);
  if(rows.length === 0){ await conn.end(); return new Response(JSON.stringify({ ok:false, error:'No encontrado' }), { status:404 }); }
  const doc = rows[0];
  const [items] = await conn.execute('SELECT di.*, p.product_code FROM document_items di LEFT JOIN products p ON di.product_id = p.id WHERE di.document_id = ?', [id]);
  await conn.end();
  const ex = Number(doc.exchange_rate || 1.0);
  const subtotal_bsf = +(Number(doc.subtotal_usd || 0) * ex).toFixed(2);
  const tax_bsf = +(Number(doc.tax_usd || 0) * ex).toFixed(2);
  const total_bsf = +(Number(doc.total_usd || 0) * ex).toFixed(2);
  return new Response(JSON.stringify({ ok:true, data: { ...doc, items, subtotal_bsf, tax_bsf, total_bsf, bcv_rate: doc.bcv_rate || null } }), { status:200, headers: { 'Content-Type':'application/json' } });
}

export async function DELETE({ params, request }){
  const id = params.id;
  const auth = await requireAdmin(request);
  if(!auth.ok) return auth.response;

  const conn = await getConn();
  try{
    await conn.execute('DELETE FROM documents WHERE id = ?', [id]);
    await conn.end();
    return new Response(JSON.stringify({ ok:true }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }catch(err){
    await conn.end();
    return new Response(JSON.stringify({ ok:false, error: String(err) }), { status:500 });
  }
}
