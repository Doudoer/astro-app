import { makeAdminSession } from '../tests/api/auth-helpers.mjs';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

(async ()=>{
  try{
    const sid = await makeAdminSession();
    console.log('Created admin sid=', sid);
    const payload = {
      tipo: 'CT',
      cliente_id: null,
      currency: 'VES',
      exchange_rate: 200.5, // example rate
      bcv_rate: 200.5,
      items: [ { product_id: null, description: 'Producto prueba BCV', quantity: 3, unit_price_usd: 5.25, discount: 0 } ]
    };
  const res = await fetch('http://localhost:3000/api/documentos', { method: 'POST', headers: { 'Content-Type': 'application/json', 'Cookie': 'sid=' + sid }, body: JSON.stringify(payload) });
    const j = await res.json();
    console.log('POST result:', j);
    if(!j.ok) return;
    // fetch inserted rows from DB
    const conn = await mysql.createConnection({ host: process.env.DB_HOST, user: process.env.DB_USER, password: process.env.DB_PASS, database: process.env.DB_NAME, port: process.env.DB_PORT||3306 });
    const [docs] = await conn.execute('SELECT * FROM documents WHERE id = ?', [j.id]);
    const [items] = await conn.execute('SELECT * FROM document_items WHERE document_id = ?', [j.id]);
    console.log('Inserted document:', docs[0]);
    console.log('Inserted items:', items);
    await conn.end();
  }catch(err){ console.error('Error', err); }
})();
