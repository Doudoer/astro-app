import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

export async function makeAdminSession(){
  const conn = await mysql.createConnection({ host: process.env.DB_HOST||'localhost', user: process.env.DB_USER||'root', password: process.env.DB_PASS||'', database: process.env.DB_NAME||'mi_app_astro_db', port: process.env.DB_PORT||3306 });
  // create admin user
  const username = 'test_admin_' + Date.now();
  let userId;
  try{
    const [u] = await conn.execute('INSERT INTO usuarios (usuario, password, role) VALUES (?, ?, ?) ', [username, 'x', 'admin']);
    userId = u.insertId;
  }catch(err){
    if(err && err.code === 'ER_DUP_ENTRY'){
      const [rows] = await conn.execute('SELECT id FROM usuarios WHERE usuario = ?', [username]);
      userId = rows[0].id;
    } else { await conn.end(); throw err; }
  }
  const sid = 'admin-sid-' + Date.now() + '-' + Math.floor(Math.random()*1000);
  const expires = new Date(Date.now() + 24*3600*1000).toISOString().slice(0,19).replace('T',' ');
  await conn.execute('INSERT INTO sessions (id, usuario_id, expires_at) VALUES (?, ?, ?)', [sid, userId, expires]);
  await conn.end();
  return sid;
}
