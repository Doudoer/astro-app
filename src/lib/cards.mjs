export function productCard(p){
  return `
    <div style="display:flex;justify-content:space-between;align-items:center"><div style="font-weight:700">${escapeHtml(p.product_code)}</div><div style="font-size:14px;color:var(--muted)">${Number(p.price_usd).toFixed(2)}</div></div>
    <div style="color:var(--muted);margin-top:6px">${escapeHtml(p.description)}</div>
    <div style="display:flex;gap:8px;justify-content:flex-end;margin-top:8px">
  <button class="inline-flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 rounded-md shadow-sm editProd" data-id="${p.id}" data-code="${escapeAttr(p.product_code)}" data-desc="${escapeAttr(p.description)}" data-price="${Number(p.price_usd).toFixed(2)}"> <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5"><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04a1 1 0 0 0 0-1.41l-2.34-2.34a1 1 0 0 0-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z" fill="currentColor"/></svg>Editar</button>
  <button class="inline-flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 rounded-md shadow-sm delProd" data-id="${p.id}"> <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5"><path d="M6 7h12M9 7V5a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2M10 11v6M14 11v6" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/></svg>Eliminar</button>
    </div>`;
}

export function clientCard(c){
  return `
    <div style="display:flex;justify-content:space-between;align-items:center"><div style="font-weight:700">${escapeHtml(c.name)}</div><div style="font-size:13px;color:var(--muted)">#${c.id}</div></div>
    <div style="color:var(--muted);margin-top:6px">${escapeHtml(c.rif_ci||'')}</div>
  <div style="display:flex;justify-content:space-between;align-items:center;margin-top:8px"><div style="color:var(--muted)">${escapeHtml(c.phone||'')}</div><div style="display:flex;gap:8px"><button class="inline-flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 rounded-md shadow-sm editClient" data-id="${c.id}"> <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5"><path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04a1 1 0 0 0 0-1.41l-2.34-2.34a1 1 0 0 0-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z" fill="currentColor"/></svg>Editar</button><button class="inline-flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 rounded-md shadow-sm delClient" data-id="${c.id}"> <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5"><path d="M6 7h12M9 7V5a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2M10 11v6M14 11v6" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/></svg>Eliminar</button></div></div>`;
}

export function docCard(d){
  const bcvBadge = d.bcv_rate ? `<span class=\"bcv-badge\" data-bcv-rate=\"${d.bcv_rate}\" data-bcv-date=\"${d.created_at}\" style=\"background:#fde68a;color:#92400e;padding:4px 8px;border-radius:999px;font-size:12px;cursor:default\">BCV</span>` : '';
  const usdBadge = (d.currency && d.currency.toUpperCase() === 'USD') ? `<span class=\"usd-badge\" style=\"background:#bbf7d0;color:#064e3b;padding:4px 8px;border-radius:999px;font-size:12px\">USD</span>` : '';
  const topRow = `<div style=\"display:flex;align-items:center;justify-content:space-between;gap:8px\"><div style=\"display:flex;align-items:center;gap:8px\"><div style=\"font-weight:700\">${escapeHtml(d.doc_number)}</div>${usdBadge}${bcvBadge}</div><div style=\"font-size:13px;color:var(--muted)\">${escapeHtml(d.tipo)}</div></div>`;
  const middle = `<div style=\"color:var(--muted);font-size:14px\">${escapeHtml(d.cliente||'')}</div>`;
  const bottom = `<div style=\"display:flex;align-items:center;justify-content:space-between;gap:8px\"><div style=\"font-weight:700\">${Number(d.total_usd).toFixed(2)}</div><div style=\"font-size:13px;color:var(--muted)\">${new Date(d.created_at).toLocaleString()}</div></div>`;
    const btn = `<div style="display:flex;justify-content:flex-end"><button class="inline-flex items-center gap-2 px-3 py-1 text-sm text-gray-700 bg-white border border-gray-200 hover:bg-gray-50 rounded-md shadow-sm viewDoc" data-id="${d.id}"> <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5"><path d="M1.5 12S4.5 5 12 5s10.5 7 10.5 7-3 7-10.5 7S1.5 12 1.5 12z" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/><circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/></svg>Ver</button></div>`;
  return topRow + middle + bottom + btn;
}

// small helpers to avoid XSS when inserting text
function escapeHtml(str){ if(str==null) return ''; return String(str).replace(/[&<>"']/g, function(s){ return ({'&':'&amp;','<':'&lt;','>':'&gt;', '"':'&quot;',"'":'&#39;'}[s]); }); }
function escapeAttr(str){ return escapeHtml(str).replace(/"/g, '&quot;'); }
