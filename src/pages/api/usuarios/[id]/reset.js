import { getConn, requireAdmin } from '../../_auth.js';
import bcrypt from 'bcryptjs';
import dotenv from 'dotenv';
dotenv.config();

export const prerender = false;

export async function POST({ request, params }){
  const auth = await requireAdmin(request);
  if(!auth.ok) return auth.response;
  const { id } = params || {};
  if(!id) return new Response(JSON.stringify({ ok:false, error:'id faltante' }), { status:400, headers:{ 'Content-Type':'application/json' } });
  const defaultPwd = process.env.DEFAULT_USER_PASSWORD || 'changeme123';
  const conn = await getConn();
  try{
    const hashed = await bcrypt.hash(defaultPwd, 10);
    await conn.execute('UPDATE usuarios SET password = ? WHERE id = ?', [hashed, id]);
    return new Response(JSON.stringify({ ok:true }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }finally{ await conn.end(); }
}
