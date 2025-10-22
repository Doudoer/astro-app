import fs from 'fs';
import mysql from 'mysql2/promise';
import bcrypt from 'bcryptjs';
import dotenv from 'dotenv';

dotenv.config();

const sql = fs.readFileSync(new URL('../db/init.sql', import.meta.url), 'utf8');

async function main(){
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT || 3306,
    multipleStatements: true,
  });

  await conn.query(sql);
  // ensure 'role' column exists on usuarios
  const [colRows] = await conn.query("SHOW COLUMNS FROM mi_app_astro_db.usuarios LIKE 'role'");
  if(colRows.length === 0){
    console.log("Añadiendo columna 'role' a usuarios...");
    await conn.query("ALTER TABLE mi_app_astro_db.usuarios ADD COLUMN role VARCHAR(50) NOT NULL DEFAULT 'user'");
  }

  // ensure nombre, apellido, phone columns exist on usuarios
  const [nombreCol] = await conn.query("SHOW COLUMNS FROM mi_app_astro_db.usuarios LIKE 'nombre'");
  if(nombreCol.length === 0){
    console.log("Añadiendo columna 'nombre' a usuarios...");
    await conn.query("ALTER TABLE mi_app_astro_db.usuarios ADD COLUMN nombre VARCHAR(255) DEFAULT NULL");
  }
  const [apellidoCol] = await conn.query("SHOW COLUMNS FROM mi_app_astro_db.usuarios LIKE 'apellido'");
  if(apellidoCol.length === 0){
    console.log("Añadiendo columna 'apellido' a usuarios...");
    await conn.query("ALTER TABLE mi_app_astro_db.usuarios ADD COLUMN apellido VARCHAR(255) DEFAULT NULL");
  }
  const [phoneCol] = await conn.query("SHOW COLUMNS FROM mi_app_astro_db.usuarios LIKE 'phone'");
  if(phoneCol.length === 0){
    console.log("Añadiendo columna 'phone' a usuarios...");
    await conn.query("ALTER TABLE mi_app_astro_db.usuarios ADD COLUMN phone VARCHAR(50) DEFAULT NULL");
  }

  // ensure sessions table exists (in case init.sql was older)
  await conn.query(`CREATE TABLE IF NOT EXISTS sessions (
    id VARCHAR(128) PRIMARY KEY,
    usuario_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
  )`);

  // create or ensure default admin user with role admin
  const [rows] = await conn.query("SELECT * FROM mi_app_astro_db.usuarios WHERE usuario = 'admin'");
  if(rows.length === 0){
    const hashed = await bcrypt.hash('password', 10);
    await conn.query('INSERT INTO mi_app_astro_db.usuarios (usuario, password, role) VALUES (?, ?, ?)', ['admin', hashed, 'admin']);
    console.log('Usuario admin creado con contraseña: password');
  } else {
    // ensure role is admin
    if(rows[0].role !== 'admin'){
      await conn.query("UPDATE mi_app_astro_db.usuarios SET role = 'admin' WHERE usuario = 'admin'");
      console.log('Usuario admin actualizado con role=admin');
    } else {
      console.log('Usuario admin ya existe');
    }
  }

  // seed counters for document numbering
  await conn.query("INSERT IGNORE INTO mi_app_astro_db.counters (name, value) VALUES ('CT', 0), ('ND', 0)");

  // seed example products and clients if empty
  const [pRows] = await conn.query('SELECT COUNT(*) as c FROM mi_app_astro_db.products');
  if(pRows[0].c === 0){
    await conn.query("INSERT INTO mi_app_astro_db.products (product_code, description, price_usd, stock) VALUES ?", [
      [
        ['P001','Producto de ejemplo A', 10.00, 100],
        ['P002','Producto de ejemplo B', 25.50, 50],
        ['P003','Producto de ejemplo C', 5.75, 200]
      ]
    ]);
    console.log('Productos de ejemplo insertados');
  }

  const [cRows] = await conn.query('SELECT COUNT(*) as c FROM mi_app_astro_db.clients');
  if(cRows[0].c === 0){
    await conn.query("INSERT INTO mi_app_astro_db.clients (name, rif_ci, phone, address) VALUES ?", [
      [
        ['Cliente Demo 1','J-12345678-9','+58 412-1234567','Direccion 1'],
        ['Cliente Demo 2','V-98765432-1','+58 412-7654321','Direccion 2']
      ]
    ]);
    console.log('Clientes de ejemplo insertados');
  }

  await conn.end();
}

main().catch(err=>{console.error(err); process.exit(1)});
