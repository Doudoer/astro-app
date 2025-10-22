import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
import { requireAdmin } from './_auth.js';
dotenv.config();

export const prerender = false;

export async function GET(){
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
  const [rows] = await conn.execute('SELECT id, product_code, description, price_usd FROM products ORDER BY id ASC');
  await conn.end();
  return new Response(JSON.stringify({ ok:true, data: rows }), { status:200, headers: { 'Content-Type':'application/json' } });
}

export async function POST({ request }){
  // only admins may create products
  const auth = await requireAdmin(request);
  if(!auth.ok) return auth.response;
  const body = await request.json();
  let { description, price_usd=0 } = body;
  if(!description) return new Response(JSON.stringify({ ok:false, error:'Faltan campos' }), { status:400 });
  // normalize to uppercase
  description = String(description||'').toUpperCase();

  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
  try{
    // generate a unique product code using counters table
    await conn.beginTransaction();
    const [rows] = await conn.execute('SELECT value FROM counters WHERE name = ? FOR UPDATE', ['product_code']);
    let next = 1;
    if(rows && rows.length > 0){ next = Number(rows[0].value) + 1; await conn.execute('UPDATE counters SET value = ? WHERE name = ?', [next, 'product_code']); }
    else { next = 1; await conn.execute('INSERT INTO counters (name, value) VALUES (?, ?)', ['product_code', next]); }
    const product_code = `P-${String(next).padStart(6,'0')}`;
    const [res] = await conn.execute('INSERT INTO products (product_code, description, price_usd) VALUES (?, ?, ?)', [product_code, description, Number(price_usd)]);
    await conn.commit();
    await conn.end();
    return new Response(JSON.stringify({ ok:true, id: res.insertId, product_code }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }catch(err){ try{ await conn.rollback(); }catch(e){} await conn.end(); return new Response(JSON.stringify({ ok:false, error: String(err) }), { status:500 }); }
}
