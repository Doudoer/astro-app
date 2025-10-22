import fetch from './fetch.mjs';
import { makeAdminSession } from './auth-helpers.mjs';
import dotenv from 'dotenv';
dotenv.config();

(async ()=>{
  console.log('Running users tests...');
  const base = 'http://localhost:3000/api/usuarios';
  const sid = await makeAdminSession();

  // invalid phone should return 400
  let res = await fetch(base, { method:'POST', headers:{ 'Content-Type':'application/json', 'Cookie':'sid='+sid }, body: JSON.stringify({ usuario:'tuser_'+Date.now(), password:'x', phone:'(412)-1234' }) });
  if(res.status !== 400) throw new Error('Expected 400 for invalid phone, got '+res.status);
  console.log('  invalid phone -> 400 OK');

  // valid create should return 201
  const username = 'tuserok_'+Date.now();
  res = await fetch(base, { method:'POST', headers:{ 'Content-Type':'application/json', 'Cookie':'sid='+sid }, body: JSON.stringify({ usuario:username, password:'x', phone:'(412)-1234567', nombre:'Test', apellido:'User' }) });
  if(res.status !== 201) {
    const txt = await res.text();
    throw new Error('Expected 201 for create user, got '+res.status+' - '+txt);
  }
  const j = await res.json();
  if(!j.ok) throw new Error('API reported error creating user: '+JSON.stringify(j));
  console.log('  create user -> 201 OK');

  console.log('Users tests PASS');
})();
