import { makeAdminSession } from '../tests/api/auth-helpers.mjs';
import dotenv from 'dotenv';
dotenv.config();

async function post(url, payload, sid){
  const res = await fetch(url, { method:'POST', headers:{ 'Content-Type':'application/json', 'Cookie':'sid='+sid }, body: JSON.stringify(payload) });
  return await res.json();
}

(async ()=>{
  try{
    const sid = await makeAdminSession();
    console.log('admin sid:', sid);
    // 1) USD document
    const usdPayload = { tipo:'CT', cliente_id: null, currency: 'USD', exchange_rate: 1.0, items: [ { product_id: null, description: 'Prod USD', quantity: 2, unit_price_usd: 12.3456, discount: 0 } ] };
    const r1 = await post('http://localhost:3000/api/documentos', usdPayload, sid);
    console.log('USD POST:', r1);

    // 2) BCV document: fetch rate then post
    const bcvFetch = await fetch('http://localhost:3000/api/bcv');
    const bj = await bcvFetch.json();
    const rate = bj.ok ? Number(bj.price) : 200.5;
    const bcvPayload = { tipo:'CT', cliente_id: null, currency: 'VES', exchange_rate: rate, bcv_rate: rate, items: [ { product_id: null, description: 'Prod BCV', quantity: 1, unit_price_usd: 5.5, discount: 0 } ] };
    const r2 = await post('http://localhost:3000/api/documentos', bcvPayload, sid);
    console.log('BCV POST:', r2);

    // fetch the two documents
    if(r1.ok) console.log('USD doc stored:', await (await fetch(`http://localhost:3000/api/documentos/${r1.id}`)).json());
    if(r2.ok) console.log('BCV doc stored:', await (await fetch(`http://localhost:3000/api/documentos/${r2.id}`)).json());
  }catch(err){ console.error(err); }
})();
