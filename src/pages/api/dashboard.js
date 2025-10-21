import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

export const prerender = false;

async function getConn(){
  return await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
}

export async function GET(){
  const conn = await getConn();
  try{
    const [[{ productsCount }]] = await conn.execute("SELECT COUNT(*) as productsCount FROM products");
    const [[{ clientsCount }]] = await conn.execute("SELECT COUNT(*) as clientsCount FROM clients");
    // pending quotes: we assume tipo='CT' indicates quote (if your app uses a different flag, adapt)
    const [[{ pendingQuotesCount }]] = await conn.execute("SELECT COUNT(*) as pendingQuotesCount FROM documents WHERE tipo = 'CT' AND total_usd = 0");
    // total sales: sum of total_usd where tipo = 'ND' (Notas de Entrega)
    const [[{ totalSalesUsd }]] = await conn.execute("SELECT COALESCE(SUM(total_usd),0) as totalSalesUsd FROM documents WHERE tipo = 'ND'");
    await conn.end();
    return new Response(JSON.stringify({ ok:true, data: { productsCount, clientsCount, pendingQuotesCount, totalSalesUsd: Number(totalSalesUsd) } }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }catch(err){
    await conn.end();
    return new Response(JSON.stringify({ ok:false, error: String(err) }), { status:500, headers:{ 'Content-Type':'application/json' } });
  }
}
