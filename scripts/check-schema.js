import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

async function main(){
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });
  const [cols] = await conn.query("SHOW COLUMNS FROM usuarios");
  console.log('Columns for usuarios:');
  cols.forEach(c=> console.log(c.Field, c.Type));
  await conn.end();
}

main().catch(err=>{console.error(err); process.exit(1)});
