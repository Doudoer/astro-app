export function productCard(p){
  return `
    <div style="display:flex;justify-content:space-between;align-items:center"><div style="font-weight:700">${escapeHtml(p.product_code)}</div><div style="font-size:14px;color:var(--muted)">${Number(p.price_usd).toFixed(2)}</div></div>
    <div style="color:var(--muted);margin-top:6px">${escapeHtml(p.description)}</div>
    <div style="display:flex;gap:8px;justify-content:flex-end;margin-top:8px">
      <button class="editProd btn-success" data-id="${p.id}" data-code="${escapeAttr(p.product_code)}" data-desc="${escapeAttr(p.description)}" data-price="${Number(p.price_usd).toFixed(2)}">Editar</button>
      <button class="delProd btn-danger" data-id="${p.id}">Eliminar</button>
    </div>`;
}

export function clientCard(c){
  return `
    <div style="display:flex;justify-content:space-between;align-items:center"><div style="font-weight:700">${escapeHtml(c.name)}</div><div style="font-size:13px;color:var(--muted)">#${c.id}</div></div>
    <div style="color:var(--muted);margin-top:6px">${escapeHtml(c.rif_ci||'')}</div>
    <div style="display:flex;justify-content:space-between;align-items:center;margin-top:8px"><div style="color:var(--muted)">${escapeHtml(c.phone||'')}</div><div style="display:flex;gap:8px"><button class="editClient btn-success" data-id="${c.id}">Editar</button><button class="delClient btn-danger" data-id="${c.id}">Eliminar</button></div></div>`;
}

export function docCard(d){
  const bcvBadge = d.bcv_rate ? `<span class=\"bcv-badge\" data-bcv-rate=\"${d.bcv_rate}\" data-bcv-date=\"${d.created_at}\" style=\"background:#fde68a;color:#92400e;padding:4px 8px;border-radius:999px;font-size:12px;cursor:default\">BCV</span>` : '';
  const usdBadge = (d.currency && d.currency.toUpperCase() === 'USD') ? `<span class=\"usd-badge\" style=\"background:#bbf7d0;color:#064e3b;padding:4px 8px;border-radius:999px;font-size:12px\">USD</span>` : '';
  const topRow = `<div style=\"display:flex;align-items:center;justify-content:space-between;gap:8px\"><div style=\"display:flex;align-items:center;gap:8px\"><div style=\"font-weight:700\">${escapeHtml(d.doc_number)}</div>${usdBadge}${bcvBadge}</div><div style=\"font-size:13px;color:var(--muted)\">${escapeHtml(d.tipo)}</div></div>`;
  const middle = `<div style=\"color:var(--muted);font-size:14px\">${escapeHtml(d.cliente||'')}</div>`;
  const bottom = `<div style=\"display:flex;align-items:center;justify-content:space-between;gap:8px\"><div style=\"font-weight:700\">${Number(d.total_usd).toFixed(2)}</div><div style=\"font-size:13px;color:var(--muted)\">${new Date(d.created_at).toLocaleString()}</div></div>`;
  const btn = `<div style=\"display:flex;justify-content:flex-end\"><button class=\"viewDoc btn-success\" data-id=\"${d.id}\" style=\"padding:6px 10px;font-size:13px\">Ver</button></div>`;
  return topRow + middle + bottom + btn;
}

// small helpers to avoid XSS when inserting text
function escapeHtml(str){ if(str==null) return ''; return String(str).replace(/[&<>"']/g, function(s){ return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[s]); }); }
function escapeAttr(str){ return escapeHtml(str).replace(/"/g, '&quot;'); }
