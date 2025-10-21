import { makeAdminSession } from '../tests/api/auth-helpers.mjs';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

(async ()=>{
  try{
    // fetch BCV
    const r = await fetch('http://localhost:3000/api/bcv');
    const j = await r.json();
    console.log('BCV fetch result:', j);
    if(!j.ok) return console.error('BCV fetch failed');
    const bcv = Number(j.price);

    const sid = await makeAdminSession();
    console.log('Created admin sid=', sid);
    const payload = {
      tipo: 'CT',
      cliente_id: null,
      currency: 'VES',
      exchange_rate: bcv,
      bcv_rate: bcv,
      items: [ { product_id: null, description: 'Producto BCV flow', quantity: 2, unit_price_usd: 7.5, discount: 0 } ]
    };
    const res = await fetch('http://localhost:3000/api/documentos', { method: 'POST', headers: { 'Content-Type': 'application/json', 'Cookie': 'sid=' + sid }, body: JSON.stringify(payload) });
    const postRes = await res.json();
    console.log('POST result:', postRes);
    if(!postRes.ok) return;
    // verify in DB
    const conn = await mysql.createConnection({ host: process.env.DB_HOST, user: process.env.DB_USER, password: process.env.DB_PASS, database: process.env.DB_NAME, port: process.env.DB_PORT||3306 });
    const [docs] = await conn.execute('SELECT bcv_rate, exchange_rate FROM documents WHERE id = ?', [postRes.id]);
    console.log('Stored doc rates:', docs[0]);
    await conn.end();
  }catch(err){ console.error('Error', err); }
})();
