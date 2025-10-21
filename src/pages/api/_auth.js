import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

export async function getConn(){
  return await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
}

function parseCookies(cookieHeader){
  if(!cookieHeader) return {};
  return Object.fromEntries(cookieHeader.split(';').map(c=>c.trim()).map(p=>p.split('=')));
}

export async function getSession(request){
  const cookies = parseCookies(request.headers.get('cookie'));
  const sid = cookies.sid;
  if(!sid) return null;
  const conn = await getConn();
  try{
    const [rows] = await conn.execute('SELECT s.id, s.expires_at, u.usuario, u.role FROM sessions s JOIN usuarios u ON s.usuario_id = u.id WHERE s.id = ?', [sid]);
    if(rows.length === 0) return null;
    const s = rows[0];
    if(s.expires_at && new Date(s.expires_at) < new Date()) return null;
    return { id: s.id, usuario: s.usuario, role: s.role };
  } finally { await conn.end(); }
}

export function unauthorizedResponse(code=401, message='No autenticado'){
  return new Response(JSON.stringify({ ok:false, error: message }), { status: code, headers:{ 'Content-Type':'application/json' } });
}

export async function requireAdmin(request){
  const session = await getSession(request);
  if(!session) return { ok:false, response: unauthorizedResponse(401, 'No autenticado') };
  if(session.role !== 'admin') return { ok:false, response: unauthorizedResponse(403, 'No autorizado') };
  return { ok:true, session };
}

export async function requireAuth(request){
  const session = await getSession(request);
  if(!session) return { ok:false, response: unauthorizedResponse(401, 'No autenticado') };
  return { ok:true, session };
}
