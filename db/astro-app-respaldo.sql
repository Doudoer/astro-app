-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-10-2025 a las 23:42:53
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
(9, 'ND-2025-000004', 'ND', 5, 'VES', 207.890000, 5.75, 0.92, 6.67, '2025-10-21 21:40:57', 1195.37, 191.26, 1386.63, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `doc_number` (`doc_number`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
