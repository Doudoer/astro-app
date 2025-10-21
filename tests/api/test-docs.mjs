import fetch from './fetch.mjs';
import { makeAdminSession } from './auth-helpers.mjs';
(async ()=>{
  console.log('Running documents API tests...');
  const base = 'http://localhost:3000/api/documentos';
  const sid = await makeAdminSession();
  const payload = { tipo:'CT', cliente_id: null, currency:'USD', exchange_rate:1.0, items: [{ product_id:null, description:'Linea test', quantity:1, unit_price_usd:5.0, discount:0 }] };
  let res = await fetch(base, { method:'POST', headers:{ 'Content-Type':'application/json', 'Cookie': 'sid=' + sid }, body: JSON.stringify(payload) }); const j = await res.json(); if(!j.ok) throw new Error('Create doc failed: '+JSON.stringify(j)); console.log('  create OK', j.doc_number);
  // list
  res = await fetch(base); const list = await res.json(); if(!list.ok) throw new Error('List docs failed'); console.log('  list OK count=', list.data.length);
  // detail
  const id = j.id;
  res = await fetch(`${base}/${id}`); const d = await res.json(); if(!d.ok) throw new Error('Detail failed'); console.log('  detail OK id=', id);
  // delete
  res = await fetch(`${base}/${id}`, { method:'DELETE', headers: { 'Cookie': 'sid=' + sid } }); const j2 = await res.json(); if(!j2.ok) throw new Error('Delete doc failed'); console.log('  delete OK');
  console.log('Documents tests PASS');
})();
