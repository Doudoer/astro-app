import { requireAuth } from './_auth.js';

export const prerender = false;

export async function GET({ request }){
  const auth = await requireAuth(request);
  if(!auth.ok) return auth.response;
  const s = auth.session;
  return new Response(JSON.stringify({ ok:true, usuario: s.usuario, role: s.role, nombre: s.nombre || null, apellido: s.apellido || null }), { status:200, headers:{ 'Content-Type':'application/json' } });
}
