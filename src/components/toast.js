export function showToast(message, type = 'info', timeout = 3000){
  let root = document.getElementById('toast-root');
  if(!root){ root = document.createElement('div'); root.id = 'toast-root'; root.style.position='fixed'; root.style.right='18px'; root.style.top='18px'; root.style.zIndex='9999'; document.body.appendChild(root); }
  const el = document.createElement('div');
  el.className = 'toast ' + type;
  el.textContent = message;
  el.style.marginTop = '8px';
  el.style.padding = '10px 14px';
  el.style.borderRadius = '8px';
  el.style.color = '#fff';
  el.style.boxShadow = '0 8px 24px rgba(2,6,23,0.12)';
  el.style.opacity = '0';
  el.style.transition = 'opacity 220ms, transform 220ms';
  el.style.transform = 'translateY(-6px)';
  if(type === 'success'){ el.style.background = '#10b981'; }
  else if(type === 'error'){ el.style.background = '#ef4444'; }
  else if(type === 'warning'){ el.style.background = '#f59e0b'; }
  else { el.style.background = '#2563eb'; }
  root.appendChild(el);
  requestAnimationFrame(()=>{ el.style.opacity = '1'; el.style.transform = 'translateY(0)'; });
  setTimeout(()=>{ el.style.opacity='0'; el.style.transform='translateY(-6px)'; setTimeout(()=> el.remove(), 260); }, timeout);
  return el;
}
