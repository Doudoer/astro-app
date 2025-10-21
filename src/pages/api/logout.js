import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

export const prerender = false;
dotenv.config();

function parseCookies(cookieHeader){
  if(!cookieHeader) return {};
  return Object.fromEntries(cookieHeader.split(';').map(c=>c.trim()).map(p=>p.split('=')));
}

export async function POST({ request }){
  const cookies = parseCookies(request.headers.get('cookie'));
  const sid = cookies.sid;
  if(!sid) return new Response(JSON.stringify({ ok:true }), { status:200 });

  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
  await conn.execute('DELETE FROM sessions WHERE id = ?', [sid]);
  await conn.end();
  const cookie = `sid=; HttpOnly; Path=/; Max-Age=0`;
  return new Response(JSON.stringify({ ok:true }), { status:200, headers: { 'Set-Cookie': cookie, 'Content-Type':'application/json' } });
}
