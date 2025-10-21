// Simple migration script to add BSF columns if they don't exist
// Usage: node scripts/migrate-add-bsf-columns.js

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
import fs from 'fs';

dotenv.config();

async function run(){
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
  });

  try{
    // Check columns in documents
    const [docCols] = await conn.execute("SHOW COLUMNS FROM documents LIKE 'subtotal_bsf' ");
    if(docCols.length === 0){
      console.log('Adding BSF columns to documents...');
      await conn.execute(`ALTER TABLE documents
        ADD COLUMN subtotal_bsf DECIMAL(18,2) DEFAULT NULL,
        ADD COLUMN tax_bsf DECIMAL(18,2) DEFAULT NULL,
        ADD COLUMN total_bsf DECIMAL(18,2) DEFAULT NULL`);
      console.log('Documents table updated');
    } else {
      console.log('Documents table already has BSF columns');
    }

    // Add bcv_rate column if missing
    const [bcvCol] = await conn.execute("SHOW COLUMNS FROM documents LIKE 'bcv_rate' ");
    if(bcvCol.length === 0){
      console.log('Adding bcv_rate column to documents...');
      await conn.execute(`ALTER TABLE documents ADD COLUMN bcv_rate DECIMAL(18,6) DEFAULT NULL`);
      console.log('bcv_rate column added');
    } else {
      console.log('bcv_rate column already exists');
    }

    // Check columns in document_items
    const [itemCols] = await conn.execute("SHOW COLUMNS FROM document_items LIKE 'unit_price_bsf' ");
    if(itemCols.length === 0){
      console.log('Adding BSF columns to document_items...');
      await conn.execute(`ALTER TABLE document_items
        ADD COLUMN unit_price_bsf DECIMAL(18,4) DEFAULT NULL,
        ADD COLUMN total_bsf DECIMAL(18,2) DEFAULT NULL`);
      console.log('document_items table updated');
    } else {
      console.log('document_items table already has BSF columns');
    }

    console.log('Migration complete');
  }catch(err){
    console.error('Migration error', err);
    process.exitCode = 1;
  }finally{
    await conn.end();
  }
}

run();
