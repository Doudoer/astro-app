import https from 'node:https';

export const prerender = false;

function fetchJson(url){
  return new Promise((resolve, reject)=>{
    https.get(url, res => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', ()=>{
        try{ const j = JSON.parse(data); resolve(j); }catch(err){ reject(err); }
      });
    }).on('error', err => reject(err));
  });
}

export async function GET(){
  const url = 'https://exchange.vcoud.com/coins/latest?type=bolivar';
  try{
    const j = await fetchJson(url);
    // attempt to extract a sensible price value
    let price = null;
    if(j == null) price = null;
    else if(typeof j.price === 'number' || typeof j.price === 'string') price = Number(j.price);
    else if(Array.isArray(j.data) && j.data.length > 0 && (j.data[0].price !== undefined)) price = Number(j.data[0].price);
    else if(j.data && (j.data.price !== undefined)) price = Number(j.data.price);
    else if(Array.isArray(j) && j.length>0 && j[0].price !== undefined) price = Number(j[0].price);
    // fallback: try to find first numeric value in object
    else {
      const flat = JSON.stringify(j);
      // no reliable fallback
      price = null;
    }
    return new Response(JSON.stringify({ ok:true, price: isNaN(price) ? null : price, raw: j }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }catch(err){
    return new Response(JSON.stringify({ ok:false, error: String(err) }), { status:500, headers:{ 'Content-Type':'application/json' } });
  }
}
