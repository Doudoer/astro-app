-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-10-2025 a las 23:57:43
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mi_app_astro_db`
--
CREATE DATABASE IF NOT EXISTS `mi_app_astro_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `mi_app_astro_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rif_ci` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clients`
--

INSERT INTO `clients` (`id`, `name`, `rif_ci`, `phone`, `address`, `created_at`) VALUES
(1, 'Cliente Demo 1', 'J-12345678-9', '+58 412-1234567', 'Direccion 1', '2025-10-21 19:52:26'),
(2, 'Cliente Demo 2', 'V-98765432-1', '+58 412-7654321', 'Direccion 2', '2025-10-21 19:52:26'),
(3, 'DOUGLAS VILLALOBOS', 'J400489857', '+58 412-7307933', 'LOS MODINES', '2025-10-21 20:04:31'),
(5, 'IRWIN CANTOS', 'V17190299', '04246112097', 'LA FLORIDA', '2025-10-21 20:19:49'),
(6, 'ALEXANDRA RINCON', 'V-18822170', '(412)-5824512', 'LAS MARIAS', '2025-10-22 17:20:02'),
(7, 'FAVIO ANDRADE', 'V-33252154', '(412)-5848569', 'EL 4', '2025-10-22 18:26:47'),
(8, 'RODRIGUES', 'V-52455852524', '(652)-1651654', 'LA FLORESTA', '2025-10-22 18:27:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `counters`
--

CREATE TABLE `counters` (
  `name` varchar(50) NOT NULL,
  `value` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `counters`
--

INSERT INTO `counters` (`name`, `value`) VALUES
('CT', 17),
('ND', 7),
('product_code', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `doc_number` varchar(100) NOT NULL,
  `tipo` varchar(10) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `currency` varchar(10) NOT NULL DEFAULT 'USD',
  `exchange_rate` decimal(18,6) DEFAULT 1.000000,
  `subtotal_usd` decimal(18,2) NOT NULL DEFAULT 0.00,
  `tax_usd` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_usd` decimal(18,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `subtotal_bsf` decimal(18,2) DEFAULT NULL,
  `tax_bsf` decimal(18,2) DEFAULT NULL,
  `total_bsf` decimal(18,2) DEFAULT NULL,
  `bcv_rate` decimal(18,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documents`
--

INSERT INTO `documents` (`id`, `doc_number`, `tipo`, `cliente_id`, `currency`, `exchange_rate`, `subtotal_usd`, `tax_usd`, `total_usd`, `created_at`, `subtotal_bsf`, `tax_bsf`, `total_bsf`, `bcv_rate`) VALUES
(2, 'CT-2025-000001', 'CT', 3, 'VES', 192.200000, 25.00, 4.00, 29.00, '2025-10-21 20:13:04', NULL, NULL, NULL, NULL),
(4, 'CT-2025-000003', 'CT', NULL, 'VES', 200.500000, 21.00, 3.36, 24.36, '2025-10-21 21:23:24', 4210.50, 673.68, 4884.18, NULL),
(5, 'ND-2025-000002', 'ND', 5, 'VES', 207.890000, 4781.47, 765.04, 5546.51, '2025-10-21 21:34:48', 994019.80, 159044.17, 1153063.96, NULL),
(6, 'CT-2025-000004', 'CT', NULL, 'VES', 200.500000, 15.75, 2.52, 18.27, '2025-10-21 21:35:56', 3157.88, 505.26, 3663.13, 200.500000),
(7, 'CT-2025-000005', 'CT', NULL, 'VES', 200.500000, 15.75, 2.52, 18.27, '2025-10-21 21:39:00', 3157.88, 505.26, 3663.13, 200.500000),
(8, 'ND-2025-000003', 'ND', 3, 'VES', 207.890000, 51.00, 8.16, 59.16, '2025-10-21 21:40:21', 10602.39, 1696.38, 12298.77, 207.890000),
(9, 'ND-2025-000004', 'ND', 5, 'VES', 207.890000, 5.75, 0.92, 6.67, '2025-10-21 21:40:57', 1195.37, 191.26, 1386.63, NULL),
(10, 'CT-2025-000006', 'CT', NULL, 'VES', 250.750000, 20.00, 3.20, 23.20, '2025-10-21 21:45:14', 5015.00, 802.40, 5817.40, 250.750000),
(11, 'CT-2025-000007', 'CT', NULL, 'VES', 207.890000, 15.00, 2.40, 17.40, '2025-10-21 21:47:53', 3118.35, 498.94, 3617.29, 207.890000),
(12, 'CT-2025-000008', 'CT', NULL, 'USD', 1.000000, 24.69, 3.95, 28.64, '2025-10-21 21:54:51', 24.69, 3.95, 28.64, NULL),
(13, 'CT-2025-000009', 'CT', NULL, 'VES', 207.890000, 5.50, 0.88, 6.38, '2025-10-21 21:54:51', 1143.39, 182.94, 1326.34, 207.890000),
(14, 'ND-2025-000005', 'ND', 1, 'VES', 207.890000, 3600.00, 576.00, 4176.00, '2025-10-21 21:56:54', 748404.00, 119744.64, 868148.64, 207.890000),
(15, 'CT-2025-000010', 'CT', NULL, 'USD', 1.000000, 24.69, 3.95, 28.64, '2025-10-21 21:59:03', 24.69, 3.95, 28.64, NULL),
(16, 'CT-2025-000011', 'CT', NULL, 'VES', 207.890000, 5.50, 0.88, 6.38, '2025-10-21 21:59:03', 1143.39, 182.94, 1326.34, 207.890000),
(17, 'CT-2025-000012', 'CT', 5, 'USD', 1.000000, 1.00, 0.16, 1.16, '2025-10-21 21:59:34', 1.00, 0.16, 1.16, NULL),
(18, 'CT-2025-000013', 'CT', 5, 'VES', 207.890000, 1.00, 0.16, 1.16, '2025-10-21 21:59:45', 207.89, 33.26, 241.15, 207.890000),
(19, 'CT-2025-000014', 'CT', 3, 'VES', 210.280000, 205.50, 32.88, 238.38, '2025-10-22 15:55:03', 43212.54, 6914.01, 50126.55, 210.280000),
(20, 'ND-2025-000006', 'ND', 6, 'USD', 1.000000, 1.00, 0.00, 1.00, '2025-10-22 17:24:26', 1.00, 0.00, 1.00, NULL),
(21, 'ND-2025-000007', 'ND', 6, 'VES', 210.280000, 1.00, 0.16, 1.16, '2025-10-22 17:24:43', 210.28, 33.64, 243.92, 210.280000),
(22, 'CT-2025-000015', 'CT', 3, 'USD', 1.000000, 18.00, 0.00, 18.00, '2025-10-22 18:25:11', 18.00, 0.00, 18.00, NULL),
(23, 'CT-2025-000016', 'CT', 3, 'VES', 210.280000, 18.00, 2.88, 20.88, '2025-10-22 18:25:30', 3785.04, 605.61, 4390.65, 210.280000),
(24, 'CT-2025-000017', 'CT', 7, 'VES', 210.280000, 25.50, 4.08, 29.58, '2025-10-22 21:46:24', 5362.14, 857.94, 6220.08, 210.280000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `document_items`
--

CREATE TABLE `document_items` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` decimal(14,2) NOT NULL DEFAULT 1.00,
  `unit_price_usd` decimal(18,4) NOT NULL DEFAULT 0.0000,
  `discount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_usd` decimal(18,2) NOT NULL DEFAULT 0.00,
  `unit_price_bsf` decimal(18,4) DEFAULT NULL,
  `total_bsf` decimal(18,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `document_items`
--

INSERT INTO `document_items` (`id`, `document_id`, `product_id`, `description`, `quantity`, `unit_price_usd`, `discount`, `total_usd`, `unit_price_bsf`, `total_bsf`) VALUES
(2, 2, NULL, 'SDDFASDFAS', 1.00, 25.0000, 0.00, 25.00, NULL, NULL),
(4, 4, NULL, 'Producto prueba', 2.00, 10.5000, 0.00, 21.00, 2105.2500, 4210.50),
(5, 5, NULL, 'P-000001 - BRAGA VERDE', 1.00, 4781.4700, 0.00, 4781.47, 994019.7983, 994019.80),
(6, 6, NULL, 'Producto prueba BCV', 3.00, 5.2500, 0.00, 15.75, 1052.6250, 3157.88),
(7, 7, NULL, 'Producto prueba BCV', 3.00, 5.2500, 0.00, 15.75, 1052.6250, 3157.88),
(8, 8, NULL, 'P002 - Producto de ejemplo B', 2.00, 25.5000, 0.00, 51.00, 5301.1950, 10602.39),
(9, 9, NULL, 'P003 - Producto de ejemplo C', 1.00, 5.7500, 0.00, 5.75, 1195.3675, 1195.37),
(10, 10, NULL, 'Producto sin bcv', 1.00, 20.0000, 0.00, 20.00, 5015.0000, 5015.00),
(11, 11, NULL, 'Producto BCV flow', 2.00, 7.5000, 0.00, 15.00, 1559.1750, 3118.35),
(12, 12, NULL, 'Prod USD', 2.00, 12.3456, 0.00, 24.69, 12.3456, 24.69),
(13, 13, NULL, 'Prod BCV', 1.00, 5.5000, 0.00, 5.50, 1143.3950, 1143.39),
(14, 14, NULL, 'P004 - Braga Azul', 200.00, 18.0000, 0.00, 3600.00, 3742.0200, 748404.00),
(15, 15, NULL, 'Prod USD', 2.00, 12.3456, 0.00, 24.69, 12.3456, 24.69),
(16, 16, NULL, 'Prod BCV', 1.00, 5.5000, 0.00, 5.50, 1143.3950, 1143.39),
(17, 17, NULL, 'P-000004 - BRAGA', 1.00, 1.0000, 0.00, 1.00, 1.0000, 1.00),
(18, 18, NULL, 'P-000004 - BRAGA', 1.00, 1.0000, 0.00, 1.00, 207.8900, 207.89),
(19, 19, NULL, 'P002 - Producto de ejemplo B', 1.00, 25.5000, 0.00, 25.50, 5362.1400, 5362.14),
(20, 19, NULL, 'P004 - Braga Azul', 10.00, 18.0000, 0.00, 180.00, 3785.0400, 37850.40),
(21, 20, NULL, 'P-000004 - BRAGA', 1.00, 1.0000, 0.00, 1.00, 1.0000, 1.00),
(22, 21, NULL, 'P-000004 - BRAGA', 1.00, 1.0000, 0.00, 1.00, 210.2800, 210.28),
(23, 22, NULL, 'P004 - Braga Azul', 1.00, 18.0000, 0.00, 18.00, 18.0000, 18.00),
(24, 23, NULL, 'P004 - Braga Azul', 1.00, 18.0000, 0.00, 18.00, 3785.0400, 3785.04),
(25, 24, NULL, 'P002 - Producto de ejemplo B', 1.00, 25.5000, 0.00, 25.50, 5362.1400, 5362.14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `product_code` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price_usd` decimal(14,2) NOT NULL DEFAULT 0.00,
  `stock` decimal(14,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `product_code`, `description`, `price_usd`, `stock`, `created_at`) VALUES
(2, 'P002', 'Producto de ejemplo B', 25.50, 50.00, '2025-10-21 19:52:26'),
(3, 'P003', 'Producto de ejemplo C', 5.75, 200.00, '2025-10-21 19:52:26'),
(4, 'P004', 'Braga Azul', 18.00, 100.00, '2025-10-21 20:01:24'),
(6, 'P005', 'BRAGA ROJ', 18.00, 100.00, '2025-10-21 20:19:24'),
(7, 'P-000001', 'BRAGA VERDE', 23.00, 0.00, '2025-10-21 20:56:47'),
(8, 'P-000002', 'BRAGA VERDE D', 50.00, 0.00, '2025-10-21 20:58:17'),
(9, 'P-000003', 'OOOO', 1.00, 0.00, '2025-10-21 21:58:00'),
(10, 'P-000004', 'BRAGA', 1.00, 0.00, '2025-10-21 21:58:24'),
(11, 'P-000005', 'BRAGA VERDE', 10.00, 0.00, '2025-10-22 15:29:59'),
(12, 'P-000006', 'BRAGUITA', 1.00, 0.00, '2025-10-22 18:27:38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(128) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `usuario_id`, `created_at`, `expires_at`) VALUES
('05325fab31090568a727fbd974c551801a4740bd5f9fa2474363aa8b3361df234cb29d721ed5be537824c431b44c5298', 1, '2025-10-21 21:29:42', '2025-10-28 21:29:42'),
('05d90b9f953b32d0acb114003314d8ab6f3e0f6fffec74b092d011509795eb1eb3f403107323c366cc5cc95250b01c47', 1, '2025-10-21 19:00:25', '2025-10-28 19:00:25'),
('152c159587a87c14ab953be5a3a1ba74c5a4f26c392eb812b3dd8b0b2406f72831f07762a9301f3e05fbe84bb19970f0', 1, '2025-10-22 16:24:55', '2025-10-29 16:24:55'),
('1cce92388b5961c0a1660a88553ecac30bc119d9241a1e9a5c792234bf94f364b599a50cf26d82f1f74f0e20cb80def4', 1, '2025-10-22 15:44:34', '2025-10-29 15:44:34'),
('226c42a04fcec444141f145b33d11bb1b18f30dbf2bd2d7b3e871f4c3119681de5a159dd227a419152d4be1e2fa65af0', 1, '2025-10-21 19:11:15', '2025-10-28 19:11:15'),
('25da6a3c8880e6a1d83601a542313ac93600cffc7eaabc0ea5135abefb453c03bc5b3bf4afcf2387ed5f9b6d527f0f3d', 1, '2025-10-22 16:56:21', '2025-10-29 16:56:21'),
('357b6c3863c96238c696aca7d2b1b1d3d01b35dbd9a4c396ab18fd373e24a37358411fb23645dc65c8cc8d22739150cf', 1, '2025-10-21 16:46:48', '2025-10-28 16:46:48'),
('40f31f3c6bba13bf08e606516cbd53d1a7c11d9b95413336eb40ad4db9d48ade529f29413f4c80e34722aa97a1ef22f7', 1, '2025-10-22 16:12:06', '2025-10-29 16:12:06'),
('43c8ed736f574ad38670eb03452609f1ccec033938dc655d41261c055464d0913a7ec41fe8bfebb4b09b329dc0161fa6', 1, '2025-10-21 18:58:40', '2025-10-28 18:58:40'),
('4c510d95e8db1db5224da78a92aef21c2052ee7e8f71a89425984339ea6e88ae25ad48a9f35524b1585a98cd86bae313', 1, '2025-10-21 19:02:09', '2025-10-28 19:02:09'),
('56032b4cfc150a49a9040f16f6d163c7f7ac97f4bc300cf4d366dfc42d913deb399e32615833d539ef9465995ba886b6', 1, '2025-10-22 15:15:10', '2025-10-29 15:15:10'),
('5a6a4909d877d8263e0aa52fedcef4337afec0ec0170c456db5e988f241abe9340866438db3745d33c5711f1f159f998', 1, '2025-10-21 20:20:52', '2025-10-28 20:20:52'),
('6408a4565fb43e42c4a3867236c67902db6ebeb00da9fd5c9ef625043a626df9a67c684c4ee37ee28171dab6eb5bf09c', 1, '2025-10-21 19:00:15', '2025-10-28 19:00:15'),
('653bf4fa4a922cb7d4b09fb707cdc8b192d674d6bed5a8a81bb714c216389b491da35c036c327c7a46a08878b41f0ff2', 13, '2025-10-22 19:58:10', '2025-10-29 19:58:10'),
('684f9dde54ed163598bdac9fe932edab45a8ffc747d2f0187a5534342656d26d4ba1abd045f7d88a8065a42343fcbafb', 1, '2025-10-22 15:12:30', '2025-10-29 15:12:30'),
('72a9bf2b319e8f16b1f689c73f9a1b5abbcb97f85e0265e521b75af06c55d0a1620e3a74a0dc6b8a0d36a1a9764ad5d5', 1, '2025-10-21 17:07:35', '2025-10-28 17:07:35'),
('79beb5b581679c74ccbad47798241960f4fbc18b6927412b2fb0db871f835f7c06afca1ea79b27ac88d1b56da6d33032', 1, '2025-10-21 19:29:10', '2025-10-28 19:29:10'),
('80721679832e4594571a193048eb6f3303b12854ef560eb5740417f83f4c27f5ff54e515ebce6c89618453420c3efc62', 1, '2025-10-22 15:43:51', '2025-10-29 15:43:51'),
('b2c3157b99a052246d5d3f0b985bfe78a57125e7931ecc53dd779c3fa6b22eb5cf7630aed36ed087a1287e67043c05c5', 1, '2025-10-22 19:21:06', '2025-10-29 19:21:06'),
('b4c9b26d23be2b8329173e4690b3321a51e44b2fe942ff5f3e2f245f3889dfb61dee9eca6ae3107c2b4783fdccfc50f9', 1, '2025-10-21 19:31:06', '2025-10-28 19:31:06'),
('bbb4447bbbac05244b2773e11fbea1f7cb87d0d763678e2e50a4a39c4ea14eabeb399fed1d4b325bb05d0680b3b281aa', 1, '2025-10-22 15:43:18', '2025-10-29 15:43:18'),
('c89972e94f44119921ecb85568a220e70726b69706a8eb0e4ca471b0e2f8da4df155e3feef5b29371a397ba3063568f8', 1, '2025-10-22 15:53:13', '2025-10-29 15:53:13'),
('cd8fbc4a9c9e1e355a0d4183cc9c80ad54bd0f83e07838315247a2e4d4c2a05bb057fc95ab668790ab129e601f03e017', 1, '2025-10-21 19:21:03', '2025-10-28 19:21:03'),
('cf1a3447b75f0b649313808fef33304a1db95cb268b8b18c6505a47bd9bb94efd77f22bfe75a551dd5baa9e1341f6971', 1, '2025-10-22 14:45:20', '2025-10-29 14:45:20'),
('d30e3df4d6f39a15d2101329d38886aa4ec048701331679f143d04e54268730a19b4a833c31ebbb3a68b29ead1d51b93', 13, '2025-10-22 18:17:34', '2025-10-29 18:17:34'),
('dacf1fda686f66328ead7696e7af10b25e6462fae52148a877651ef6ccbce29c2ef05a3c80281ac40bbe555f874bc038', 1, '2025-10-22 18:41:06', '2025-10-29 18:41:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nombre` text NOT NULL,
  `apellido` text NOT NULL,
  `phone` int(25) NOT NULL,
  `creado_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(50) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `password`, `nombre`, `apellido`, `phone`, `creado_at`, `role`) VALUES
(1, 'admin', '$2b$10$gCTc3sd5FAlVdAXZSTg1FuPCK.3edlm15q2Rcrv3bcfH0zZnQNzA2', 'Douglas', 'Villalobos', 0, '2025-10-21 16:35:59', 'admin'),
(13, 'anabel', '$2b$10$rnH/PR0O6.Pzq3lussOiY.S.F5vSwbeaVzyYakeLsUQxuj.NwXW..', 'Anabel', 'Briceño', 0, '2025-10-22 17:09:39', 'user'),
(16, 'doudoer', '$2b$10$LwrwgdzWWYqQ0S3Daq0H0.kl/hVcIuYGCCmf82qnwJxF1vYq5nEp.', 'Douglas', 'Villalobos', 2147483647, '2025-10-22 19:25:43', 'admin');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `counters`
--
ALTER TABLE `counters`
  ADD PRIMARY KEY (`name`);

--
-- Indices de la tabla `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `doc_number` (`doc_number`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `document_items`
--
ALTER TABLE `document_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_code` (`product_code`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `document_items`
--
ALTER TABLE `document_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `document_items`
--
ALTER TABLE `document_items`
  ADD CONSTRAINT `document_items_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `document_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"mi_app_astro_db\",\"table\":\"usuarios\"},{\"db\":\"mi_app_astro_db\",\"table\":\"documents\"},{\"db\":\"mi_app_astro_db\",\"table\":\"clients\"},{\"db\":\"mi_app_astro_db\",\"table\":\"counters\"},{\"db\":\"mi_app_astro_db\",\"table\":\"sessions\"},{\"db\":\"mi_app_astro_db\",\"table\":\"products\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-10-22 19:25:49', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"es\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `rsy`
--
CREATE DATABASE IF NOT EXISTS `rsy` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `rsy`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `claims`
--

CREATE TABLE `claims` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `type` varchar(20) NOT NULL CHECK (`type` in ('cambio','reembolso')),
  `description` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clients`
--

CREATE TABLE `clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parts`
--

CREATE TABLE `parts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `brand` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `year` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `part_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(20) NOT NULL CHECK (`status` in ('buscando','listo','entregado','reembolsado')),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL CHECK (`role` in ('vendedor','dueno','admin')),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `claims`
--
ALTER TABLE `claims`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `parts`
--
ALTER TABLE `parts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `claims`
--
ALTER TABLE `claims`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parts`
--
ALTER TABLE `parts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
