import fetch from './fetch.mjs';
import { makeAdminSession } from './auth-helpers.mjs';
(async ()=>{
  console.log('Running clients API tests...');
  const base = 'http://localhost:3000/api/clientes';
  const sid = await makeAdminSession();
  const payload = { name:'Cliente Test', rif_ci:'J-00000000-0', phone:'+58 412 0000000', address:'Dirección test' };
  let res = await fetch(base, { method:'POST', headers:{ 'Content-Type':'application/json', 'Cookie': 'sid=' + sid }, body: JSON.stringify(payload) }); const j = await res.json(); if(!j.ok) throw new Error('Create client failed'); const id = j.id; console.log('  create OK id=', id);
  res = await fetch(`${base}/${id}`, { method:'PUT', headers:{ 'Content-Type':'application/json', 'Cookie': 'sid=' + sid }, body: JSON.stringify({ name:'Cliente Test Mod', rif_ci:'J-000', phone:'', address:'' }) }); const j2 = await res.json(); if(!j2.ok) throw new Error('Update client failed'); console.log('  update OK');
  res = await fetch(base); const list = await res.json(); if(!list.ok) throw new Error('List clients failed'); console.log('  list OK count=', list.data.length);
  res = await fetch(`${base}/${id}`, { method:'DELETE', headers: { 'Cookie': 'sid=' + sid } }); const j3 = await res.json(); if(!j3.ok) throw new Error('Delete client failed'); console.log('  delete OK');
  console.log('Clients tests PASS');
})();
