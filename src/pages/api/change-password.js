import { getConn, requireAuth, unauthorizedResponse } from './_auth.js';
import bcrypt from 'bcryptjs';
import dotenv from 'dotenv';
dotenv.config();

export const prerender = false;

export async function POST({ request }){
  const auth = await requireAuth(request);
  if(!auth.ok) return auth.response;
  const session = auth.session;
  const body = await request.json();
  const { currentPassword, newPassword } = body || {};
  if(!currentPassword || !newPassword) return new Response(JSON.stringify({ ok:false, error:'Faltan campos' }), { status:400, headers:{ 'Content-Type':'application/json' } });
  const conn = await getConn();
  try{
    const [rows] = await conn.execute('SELECT id, password FROM usuarios WHERE usuario = ?', [session.usuario]);
    if(rows.length === 0) return new Response(JSON.stringify({ ok:false, error:'Usuario no encontrado' }), { status:404, headers:{ 'Content-Type':'application/json' } });
    const user = rows[0];
    const match = await bcrypt.compare(currentPassword, user.password);
    if(!match) return new Response(JSON.stringify({ ok:false, error:'Contraseña actual incorrecta' }), { status:401, headers:{ 'Content-Type':'application/json' } });
    const hashed = await bcrypt.hash(newPassword, 10);
    await conn.execute('UPDATE usuarios SET password = ? WHERE id = ?', [hashed, user.id]);
    return new Response(JSON.stringify({ ok:true }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }finally{ await conn.end(); }
}
