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

export async function PUT({ params, request }){
  const auth = await requireAdmin(request);
  if(!auth.ok) return auth.response;
  const id = params.id;
  const body = await request.json();
  let { product_code, description, price_usd } = body;
  // normalize to uppercase fields
  if(product_code) product_code = String(product_code).toUpperCase();
  if(description) description = String(description).toUpperCase();
  const conn = await getConn();
  try{
  await conn.execute('UPDATE products SET product_code=?, description=?, price_usd=? WHERE id=?', [product_code, description, Number(price_usd), id]);
    await conn.end();
    return new Response(JSON.stringify({ ok:true }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }catch(err){ await conn.end(); return new Response(JSON.stringify({ ok:false, error: String(err) }), { status:500 }); }
}

export async function DELETE({ params, request }){
  const auth = await requireAdmin(request);
  if(!auth.ok) return auth.response;
  const id = params.id;
  const conn = await getConn();
  try{
    await conn.execute('DELETE FROM products WHERE id = ?', [id]);
    await conn.end();
    return new Response(JSON.stringify({ ok:true }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }catch(err){ await conn.end(); return new Response(JSON.stringify({ ok:false, error: String(err) }), { status:500 }); }
}
