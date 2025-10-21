import fetch from './fetch.mjs';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

async function makeSessionForUser(username, role='user'){
  const conn = await mysql.createConnection({ host: process.env.DB_HOST||'localhost', user: process.env.DB_USER||'root', password: process.env.DB_PASS||'', database: process.env.DB_NAME||'mi_app_astro_db', port: process.env.DB_PORT||3306 });
  // create user
  const [u] = await conn.execute('INSERT INTO usuarios (usuario, password, role) VALUES (?, ?, ?) ', [username, 'x', role]);
  const userId = u.insertId;
  const sid = 'test-sid-' + Date.now() + '-' + Math.floor(Math.random()*1000);
  const expires = new Date(Date.now() + 24*3600*1000).toISOString().slice(0,19).replace('T',' ');
  await conn.execute('INSERT INTO sessions (id, usuario_id, expires_at) VALUES (?, ?, ?)', [sid, userId, expires]);
  await conn.end();
  return sid;
}

(async ()=>{
  console.log('Running auth tests...');
  const baseP = 'http://localhost:3000/api/productos';

  // unauthenticated POST should be 401
  let res = await fetch(baseP, { method:'POST', headers:{ 'Content-Type':'application/json' }, body: JSON.stringify({ product_code:'A', description:'a' }) });
  if(res.status !== 401) throw new Error('Expected 401 for unauthenticated POST products, got '+res.status);
  console.log('  unauthenticated POST -> 401 OK');

  // create a non-admin user/session and attempt POST with sid cookie -> 403
  const sid = await makeSessionForUser('test_user_' + Date.now(), 'user');
  res = await fetch(baseP, { method:'POST', headers:{ 'Content-Type':'application/json', 'Cookie': 'sid=' + sid }, body: JSON.stringify({ product_code:'A2', description:'a2' }) });
  if(res.status !== 403) throw new Error('Expected 403 for non-admin POST products, got '+res.status);
  console.log('  non-admin POST -> 403 OK');

  console.log('Auth tests PASS');
})();
