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
  // total amount of quotes (tipo='CT') and total amount of notes (tipo='ND')
  const [[{ totalQuotesUsd }]] = await conn.execute("SELECT COALESCE(SUM(total_usd),0) as totalQuotesUsd FROM documents WHERE tipo = 'CT'");
  const [[{ totalNotesUsd }]] = await conn.execute("SELECT COALESCE(SUM(total_usd),0) as totalNotesUsd FROM documents WHERE tipo = 'ND'");
  // counts of documents by type
  const [[{ quotesCount }]] = await conn.execute("SELECT COUNT(*) as quotesCount FROM documents WHERE tipo = 'CT'");
  const [[{ notesCount }]] = await conn.execute("SELECT COUNT(*) as notesCount FROM documents WHERE tipo = 'ND'");
  // total ventas (USD) based on notas de entrega (ND)
  const [[{ totalVentasUsd }]] = await conn.execute("SELECT COALESCE(SUM(total_usd),0) as totalVentasUsd FROM documents WHERE tipo = 'ND'");
  // monthly totals for the last 12 months (based on created_at) for tipo 'ND'
  const months = [];
  const now = new Date();
  for(let i=11;i>=0;i--){
    const d = new Date(now.getFullYear(), now.getMonth() - i, 1);
    const y = d.getFullYear();
    const m = String(d.getMonth()+1).padStart(2,'0');
    const start = `${y}-${m}-01 00:00:00`;
    // compute last day of month
    const lastDay = new Date(y, parseInt(m,10), 0).getDate();
    const end = `${y}-${m}-${String(lastDay).padStart(2,'0')} 23:59:59`;
    const [[{ monthTotal }]] = await conn.execute("SELECT COALESCE(SUM(total_usd),0) as monthTotal FROM documents WHERE tipo = 'ND' AND created_at BETWEEN ? AND ?", [start, end]);
    months.push({ year: y, month: parseInt(m,10), total_usd: Number(monthTotal) });
  }
  // top buyers for the current month (tipo 'ND') - top 5 by total_usd
  const currentYear = now.getFullYear();
  const currentMonth = String(now.getMonth()+1).padStart(2,'0');
  const currentStart = `${currentYear}-${currentMonth}-01 00:00:00`;
  const currentLastDay = new Date(currentYear, parseInt(currentMonth,10), 0).getDate();
  const currentEnd = `${currentYear}-${currentMonth}-${String(currentLastDay).padStart(2,'0')} 23:59:59`;
  const [buyersRows] = await conn.execute(
    `SELECT c.id as client_id, c.name as client_name, c.rif_ci as client_rif, COALESCE(SUM(d.total_usd),0) as total_usd, COUNT(*) as invoices_count
     FROM documents d
     LEFT JOIN clients c ON c.id = d.cliente_id
     WHERE d.tipo = 'ND' AND d.created_at BETWEEN ? AND ?
     GROUP BY c.id, c.name, c.rif_ci
     ORDER BY total_usd DESC
     LIMIT 5`, [currentStart, currentEnd]
  );
  // total sales for current month (based on created_at) for tipo 'ND'
  const year = now.getFullYear();
  const month = String(now.getMonth()+1).padStart(2,'0');
  const monthStart = `${year}-${month}-01 00:00:00`;
  const lastDayCur = new Date(year, parseInt(month,10), 0).getDate();
  const monthEnd = `${year}-${month}-${String(lastDayCur).padStart(2,'0')} 23:59:59`;
  const [[{ monthlySalesUsd }]] = await conn.execute("SELECT COALESCE(SUM(total_usd),0) as monthlySalesUsd FROM documents WHERE tipo = 'ND' AND created_at BETWEEN ? AND ?", [monthStart, monthEnd]);
  await conn.end();
  return new Response(JSON.stringify({ ok:true, data: { productsCount, clientsCount, totalQuotesUsd: Number(totalQuotesUsd), totalNotesUsd: Number(totalNotesUsd), monthlySalesUsd: Number(monthlySalesUsd), quotesCount: Number(quotesCount), notesCount: Number(notesCount), totalVentasUsd: Number(totalVentasUsd), monthlyTotals: months, topBuyersThisMonth: buyersRows } }), { status:200, headers:{ 'Content-Type':'application/json' } });
  }catch(err){
    await conn.end();
    return new Response(JSON.stringify({ ok:false, error: String(err) }), { status:500, headers:{ 'Content-Type':'application/json' } });
  }
}
