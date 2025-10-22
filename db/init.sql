CREATE DATABASE IF NOT EXISTS mi_app_astro_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mi_app_astro_db;

CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL DEFAULT 'user',
  nombre VARCHAR(255) DEFAULT NULL,
  apellido VARCHAR(255) DEFAULT NULL,
  telefono VARCHAR(50) DEFAULT NULL,
  creado_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sessions (
  id VARCHAR(128) PRIMARY KEY,
  usuario_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Insert a sample user: usuario 'admin' contraseña 'password' (hash in script)

-- Products table
CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_code VARCHAR(50) NOT NULL UNIQUE,
  description VARCHAR(255) NOT NULL,
  price_usd DECIMAL(14,2) NOT NULL DEFAULT 0.00,
  stock DECIMAL(14,2) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Clients table
CREATE TABLE IF NOT EXISTS clients (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  rif_ci VARCHAR(50),
  phone VARCHAR(50),
  address TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Documents table
CREATE TABLE IF NOT EXISTS documents (
  id INT AUTO_INCREMENT PRIMARY KEY,
  doc_number VARCHAR(100) NOT NULL UNIQUE,
  tipo VARCHAR(10) NOT NULL,
  cliente_id INT,
  currency VARCHAR(10) NOT NULL DEFAULT 'USD',
  exchange_rate DECIMAL(18,6) DEFAULT 1.0,
  bcv_rate DECIMAL(18,6) DEFAULT NULL,
  subtotal_usd DECIMAL(18,2) NOT NULL DEFAULT 0.00,
  tax_usd DECIMAL(18,2) NOT NULL DEFAULT 0.00,
  total_usd DECIMAL(18,2) NOT NULL DEFAULT 0.00,
  subtotal_bsf DECIMAL(18,2) DEFAULT NULL,
  tax_bsf DECIMAL(18,2) DEFAULT NULL,
  total_bsf DECIMAL(18,2) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cliente_id) REFERENCES clients(id) ON DELETE SET NULL
);

-- Document items (normalized)
CREATE TABLE IF NOT EXISTS document_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  document_id INT NOT NULL,
  product_id INT,
  description VARCHAR(255),
  quantity DECIMAL(14,2) NOT NULL DEFAULT 1,
  unit_price_usd DECIMAL(18,4) NOT NULL DEFAULT 0.00,
  discount DECIMAL(18,2) NOT NULL DEFAULT 0.00,
  total_usd DECIMAL(18,2) NOT NULL DEFAULT 0.00,
  unit_price_bsf DECIMAL(18,4) DEFAULT NULL,
  total_bsf DECIMAL(18,2) DEFAULT NULL,
  FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);

-- Counters table for sequential numbering
CREATE TABLE IF NOT EXISTS counters (
  name VARCHAR(50) PRIMARY KEY,
  value BIGINT NOT NULL DEFAULT 0
);

-- Optional: seed some example products and clients can be done from the init script runner