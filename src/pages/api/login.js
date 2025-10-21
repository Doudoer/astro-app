import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
import { randomBytes } from 'crypto';
import bcrypt from 'bcryptjs';

export const prerender = false;

dotenv.config();

export async function POST({ request }){
  const body = await request.json();
  const { usuario, password } = body;

  if(!usuario || !password) return new Response(JSON.stringify({ ok:false, error:'Faltan credenciales' }), { status:400 });

  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });

  const [rows] = await conn.execute('SELECT * FROM usuarios WHERE usuario = ?', [usuario]);
  await conn.end();

  if(rows.length === 0) return new Response(JSON.stringify({ ok:false, error:'Usuario no encontrado' }), { status:401 });

  const user = rows[0];
  const match = await bcrypt.compare(password, user.password);
  if(!match) return new Response(JSON.stringify({ ok:false, error:'Credenciales inválidas' }), { status:401 });

  // create a session id and store it
  const sessionId = randomBytes(48).toString('hex');
  const conn2 = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
  const expires = new Date(Date.now() + 1000*60*60*24*7); // 7 days
  await conn2.execute('INSERT INTO sessions (id, usuario_id, expires_at) VALUES (?, ?, ?)', [sessionId, user.id, expires]);
  await conn2.end();

  const cookie = `sid=${sessionId}; HttpOnly; Path=/; Max-Age=${7*24*60*60}`;
  return new Response(JSON.stringify({ ok:true, usuario: user.usuario, role: user.role }), { status:200, headers: { 'Set-Cookie': cookie, 'Content-Type':'application/json' } });
}
