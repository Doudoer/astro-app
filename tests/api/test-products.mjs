import fetch from './fetch.mjs';
import { makeAdminSession } from './auth-helpers.mjs';

(async ()=>{
  console.log('Running products API tests...');
  const base = 'http://localhost:3000/api/productos';
  const sid = await makeAdminSession();
  // create
  const payload = { description: 'Producto test', price_usd: 9.99 };
  let res = await fetch(base, { method:'POST', headers:{ 'Content-Type':'application/json', 'Cookie': 'sid=' + sid }, body: JSON.stringify(payload) });
  const j = await res.json();
  if(!j.ok) throw new Error('Create failed: '+ JSON.stringify(j));
  const id = j.id;
  console.log('  create OK id=', id, 'code=', j.product_code);
  // update
  res = await fetch(`${base}/${id}`, { method:'PUT', headers:{ 'Content-Type':'application/json', 'Cookie': 'sid=' + sid }, body: JSON.stringify({ product_code:j.product_code, description:'Producto test mod', price_usd: 11.0 }) });
  const j2 = await res.json(); if(!j2.ok) throw new Error('Update failed'); console.log('  update OK');
  // list
  res = await fetch(base); const list = await res.json(); if(!list.ok) throw new Error('List failed'); console.log('  list OK count=', list.data.length);
  // delete
  res = await fetch(`${base}/${id}`, { method:'DELETE', headers: { 'Cookie': 'sid=' + sid } }); const j3 = await res.json(); if(!j3.ok) throw new Error('Delete failed'); console.log('  delete OK');
  console.log('Products tests PASS');
})();
