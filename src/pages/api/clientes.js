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
  const [rows] = await conn.execute('SELECT id, name, rif_ci, phone, address FROM clients ORDER BY name ASC');
  await conn.end();
  return new Response(JSON.stringify({ ok:true, data: rows }), { status:200, headers: { 'Content-Type':'application/json' } });
}

export async function POST({ request }){
  const auth = await requireAdmin(request);
  if(!auth.ok) return auth.response;
  const body = await request.json();
  let { name, rif_ci, phone, address } = body;
  if(!name) return new Response(JSON.stringify({ ok:false, error:'Falta nombre' }), { status:400 });
  // normalize to uppercase
  name = String(name||'').toUpperCase();
  rif_ci = rif_ci ? String(rif_ci).toUpperCase() : null;
  phone = phone ? String(phone).toUpperCase() : null;
  address = address ? String(address).toUpperCase() : null;
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
  try{
  const [res] = await conn.execute('INSERT INTO clients (name, rif_ci, phone, address) VALUES (?, ?, ?, ?)', [name, rif_ci, phone, address]);
    await conn.end();
    return new Response(JSON.stringify({ ok:true, id: res.insertId }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }catch(err){ await conn.end(); return new Response(JSON.stringify({ ok:false, error: String(err) }), { status:500 }); }
}
