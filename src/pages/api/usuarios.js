import { getConn, requireAdmin, unauthorizedResponse } from './_auth.js';
import bcrypt from 'bcryptjs';
import dotenv from 'dotenv';
dotenv.config();

export const prerender = false;

export async function GET({ request }){
  // List users (admin only)
  const auth = await requireAdmin(request);
  if(!auth.ok) return auth.response;
  const conn = await getConn();
  try{
     const [rows] = await conn.execute('SELECT id, usuario, role, nombre, apellido, phone FROM usuarios ORDER BY id DESC');
    return new Response(JSON.stringify({ ok:true, data: rows }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }finally{ await conn.end(); }
}

export async function POST({ request }){
  // Create new user (admin only)
  const auth = await requireAdmin(request);
  if(!auth.ok) return auth.response;
  const body = await request.json();
    // debug: log incoming body to help troubleshoot missing fields
    try{ console.log('[api/usuarios] incoming body:', JSON.stringify(body)); }catch(e){ console.log('[api/usuarios] incoming body (unserializable)'); }
    const { usuario, password, role, nombre, apellido, phone } = body || {};
  if(!usuario || !password) return new Response(JSON.stringify({ ok:false, error:'usuario y password son requeridos' }), { status:400, headers:{ 'Content-Type':'application/json' } });
  const conn = await getConn();
  try{
    const hashed = await bcrypt.hash(password, 10);
    try{
        const [res] = await conn.execute('INSERT INTO usuarios (usuario, password, role, nombre, apellido, phone) VALUES (?, ?, ?, ?, ?, ?)', [usuario, hashed, role || 'user', nombre || null, apellido || null, phone || null]);
      return new Response(JSON.stringify({ ok:true, id: res.insertId, usuario }), { status:201, headers:{ 'Content-Type':'application/json' } });
    }catch(err){
      if(err && err.code === 'ER_DUP_ENTRY') return new Response(JSON.stringify({ ok:false, error:'Usuario ya existe' }), { status:409, headers:{ 'Content-Type':'application/json' } });
      return new Response(JSON.stringify({ ok:false, error: err.message || 'Error al crear usuario' }), { status:500, headers:{ 'Content-Type':'application/json' } });
    }
  }finally{ await conn.end(); }
}
