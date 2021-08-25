-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-08-2021 a las 00:09:46
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.8

DROP DATABASE IF EXISTS sistemaVentas;
CREATE DATABASE sistemaVentas;
USE sistemaVentas;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistemaventas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Actualizar` ()  begin
	UPDATE caja set saldo = (SELECT  sum(c.monto) FROM caja c WHERE c.id_caja <= caja.id_caja);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja`
--

CREATE TABLE `caja` (
  `id_caja` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `tipoMovimiento` int(1) NOT NULL,
  `monto` decimal(10,0) NOT NULL,
  `saldo` decimal(10,0) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `estado` tinyint(1) NOT NULL,
  `estadoMovimiento` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `caja`
--

INSERT INTO `caja` (`id_caja`, `descripcion`, `tipoMovimiento`, `monto`, `saldo`, `fecha`, `estado`, `estadoMovimiento`) VALUES
(1, 'Apertura de Caja', 1, '100', '100', '2021-08-24 16:34:07', 1, 1),
(2, 'Venta', 1, '110', '210', '2021-08-24 16:38:25', 1, 1),
(3, 'GO', 1, '40', '250', '2021-08-24 17:02:50', 1, 1),
(4, 'Internet', 0, '-50', '200', '2021-08-24 17:02:56', 1, 1),
(5, 'Inversion Trading', 1, '500', '700', '2021-08-24 17:03:11', 1, 1),
(6, 'Agua', 0, '-40', '660', '2021-08-24 17:03:25', 1, 1),
(7, 'Luz', 0, '-50', '610', '2021-08-24 17:03:38', 1, 1),
(8, 'Inversion', 1, '400', '1010', '2021-08-24 17:06:12', 1, 1),
(9, 'Cita waldir con nadie', 0, '0', '1010', '2021-08-24 17:06:20', 1, 0),
(10, 'Venta', 1, '71', '1081', '2021-08-24 17:21:35', 1, 1),
(11, 'Isac', 1, '500', '1581', '2021-08-24 17:31:47', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `categoria` varchar(40) NOT NULL,
  `estado` enum('Habilitado','Deshabilitado') NOT NULL DEFAULT 'Habilitado'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `categoria`, `estado`) VALUES
(1, 'Construcción', 'Habilitado'),
(2, 'Tuberías y accesorios', 'Habilitado'),
(3, 'Ferretería general', 'Habilitado'),
(4, 'Galvanizados', 'Habilitado'),
(6, 'Herramientas eléctricas', 'Habilitado'),
(7, 'Limpieza y aseo', 'Habilitado'),
(8, 'Pinturas y solvente', 'Habilitado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` bigint(20) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `documento` int(11) NOT NULL,
  `nrodocumento` char(15) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` char(15) NOT NULL,
  `email` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `documento`, `nrodocumento`, `direccion`, `telefono`, `email`) VALUES
(1, 'Waldir Sanchez', 1, '12345678', 'Universidad Cesar Vallejo ', '987654321', 'waldir@gmail.com'),
(2, 'Betsi Mendoza', 1, '99999999', 'Trujillo', '21212121', 'betsi@gmail.com'),
(3, 'Isac Miñano', 1, '89868575', 'Guadalupe', '65656565', 'isac@gmail.com'),
(4, 'Jhon Cruzado', 1, '45654568', 'Chepén', '45654654', 'jhon@gmail.com'),
(6, 'BANCO BBVA PERU', 2, '20100130204', 'AV. REP DE PANAMA NRO. 3055 URB. EL PALOMAR LIMA LIMA SAN ISIDRO', '4562145', 'bbva@peru.com'),
(7, 'BANCO DE COMERCIO', 2, '20509507199', 'AV. CANAVAL Y MOREYRA NRO. 452 LIMA LIMA SAN ISIDRO', '85658214', 'bcomercio@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id_detalle` bigint(20) NOT NULL,
  `venta_id` bigint(20) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` float(5,2) NOT NULL,
  `precio` float(5,2) NOT NULL,
  `descuento` float(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id_detalle`, `venta_id`, `producto_id`, `cantidad`, `precio`, `descuento`) VALUES
(2, 8, 1003, 10.00, 40.00, 5.00),
(3, 8, 1001, 5.00, 11.00, 4.00),
(4, 9, 1000, 5.00, 15.00, 4.00),
(5, 9, 1001, 4.00, 11.00, 5.00),
(6, 10, 1000, 5.00, 15.00, 4.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `producto` varchar(200) NOT NULL,
  `stock` int(11) NOT NULL,
  `stock_minimo` int(11) NOT NULL,
  `precio_compra` float(12,2) NOT NULL,
  `precio_venta` float(12,2) NOT NULL,
  `foto` varchar(2048) DEFAULT NULL,
  `vence` enum('Si','No') NOT NULL,
  `fecha_vence` date DEFAULT NULL,
  `medida_id` int(11) NOT NULL,
  `estado` enum('Disponible','Stock mínimo','Agotado','Vencido') NOT NULL DEFAULT 'Disponible',
  `categoria_id` int(11) DEFAULT NULL,
  `subcategoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `producto`, `stock`, `stock_minimo`, `precio_compra`, `precio_venta`, `foto`, `vence`, `fecha_vence`, `medida_id`, `estado`, `categoria_id`, `subcategoria_id`) VALUES
(1000, 'PORCELANATO 60X60 PORC RF CEMENTO CONCRETO MARRON EXTRA', 15, 8, 14.50, 15.00, 'producto.png', 'Si', '2021-11-17', 1, 'Disponible', 1, 1),
(1001, 'Ladrillo XYZ', 12, 8, 9.00, 11.00, '61117ccef3742.jpg', 'No', NULL, 1, 'Disponible', 1, 3),
(1002, 'Tuberias', 40, 5, 5.00, 8.00, '611d83f541a14.jpg', 'No', NULL, 1, 'Disponible', 2, 10),
(1003, 'Cemento Sol', 200, 50, 35.00, 40.00, '611d84664f922.jpg', 'Si', '2022-02-26', 1, 'Disponible', 1, 1),
(1004, 'Tanque elevado ', 10, 2, 800.00, 1000.00, '611d850dd0de2.jpg', 'No', NULL, 1, 'Disponible', 2, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `raz_social` varchar(40) NOT NULL,
  `documento` int(11) NOT NULL,
  `nrodocumento` char(15) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `contacto` varchar(80) NOT NULL,
  `telefono` char(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `raz_social`, `documento`, `nrodocumento`, `direccion`, `contacto`, `telefono`, `email`) VALUES
(1, 'Proveedor 1', 2, '123456789', 'Calle San Juan #273', 'Jorge Lopez', '988666777', 'jlopez@gmail.com'),
(2, 'Proveedor 2', 1, '75106474', 'Chepen', 'Juan Segura', '123456789', 'jsegura@gmail.com'),
(3, 'Proveedor 3', 1, '12121212', 'Calle las flores #456', 'Julio Espinoza', '45689564', 'julio@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `rol` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `rol`) VALUES
(1, 'Administrador'),
(2, 'Vendedor'),
(3, 'Tesorero');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('xenAYsGbWD8Y1yecHTebkaqFiCIQjz5KYJkObhmT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVk12cVFDN2hUVFRYNE9tNDg4NjJHeU5wN3RvOU5UbkZ5NWhYZk1GTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1629845833);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategoria`
--

CREATE TABLE `subcategoria` (
  `id_subcategoria` int(11) NOT NULL,
  `subcategoria` varchar(40) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `estado` enum('Habilitado','Deshabilitado') NOT NULL DEFAULT 'Habilitado'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `subcategoria`
--

INSERT INTO `subcategoria` (`id_subcategoria`, `subcategoria`, `categoria_id`, `estado`) VALUES
(1, 'Cemento', 1, 'Habilitado'),
(2, 'Fierro de construcción', 1, 'Habilitado'),
(3, 'Ladrillo', 1, 'Habilitado'),
(4, 'Yeso', 1, 'Habilitado'),
(5, 'Alicates', 3, 'Habilitado'),
(6, 'Cerraduras', 3, 'Habilitado'),
(7, 'Cable', 3, 'Habilitado'),
(8, 'Clavos', 3, 'Habilitado'),
(9, 'Destornillador', 3, 'Habilitado'),
(10, 'Tubo 1/2\" (Eurotubo)', 2, 'Habilitado'),
(11, 'Tanques Rotoplas', 2, 'Habilitado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `id` int(11) NOT NULL,
  `tipo` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`id`, `tipo`) VALUES
(1, 'DNI'),
(2, 'RUC'),
(3, 'CARNÉ EXTRANJERÍA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_medida`
--

CREATE TABLE `unidad_medida` (
  `id` int(11) NOT NULL,
  `medida` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `unidad_medida`
--

INSERT INTO `unidad_medida` (`id`, `medida`) VALUES
(1, 'Unidad'),
(2, 'Galon'),
(3, 'Pliego'),
(4, 'Rollo'),
(5, 'Metro'),
(6, 'Kilogramo'),
(7, 'Sobre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombre` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rol_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `profile_photo_path`, `created_at`, `updated_at`, `rol_id`) VALUES
(3, 'Waldir Sanchez', 'waldirc925@gmail.com', '$2y$10$DC1teJyeeLIbyQoqDkcYcOpdknNspwYl.s1vFtSB0OukekMtIK9sW', NULL, '2021-06-27 21:21:17', '2021-07-04 04:02:01', 1),
(5, 'Jhon Cruzado', 'jhonpaulcruzadodelacruz@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_venta` bigint(20) NOT NULL,
  `cliente_id` bigint(20) NOT NULL,
  `subtotal` float(12,2) NOT NULL,
  `igv` float(12,2) NOT NULL,
  `total` float(12,2) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id_venta`, `cliente_id`, `subtotal`, `igv`, `total`, `fecha`) VALUES
(8, 2, 365.72, 80.28, 446.00, '2021-08-18 18:48:23'),
(9, 2, 90.20, 19.80, 110.00, '2021-08-24 16:38:25'),
(10, 6, 58.22, 12.78, 71.00, '2021-08-24 17:21:35');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `caja`
--
ALTER TABLE `caja`
  ADD PRIMARY KEY (`id_caja`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `documento` (`documento`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `fk_id_detalle` (`venta_id`),
  ADD KEY `fk_id_detalle2` (`producto_id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `medida_id` (`medida_id`),
  ADD KEY `categoria_id` (`categoria_id`),
  ADD KEY `subcategoria_id` (`subcategoria_id`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`),
  ADD KEY `documento` (`documento`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD PRIMARY KEY (`id_subcategoria`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `fk_id_venta` (`cliente_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `caja`
--
ALTER TABLE `caja`
  MODIFY `id_caja` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id_detalle` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1005;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `id_subcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id_venta` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`documento`) REFERENCES `tipo_documento` (`id`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_id_detalle` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_detalle2` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`),
  ADD CONSTRAINT `fk_venta_id` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id_venta`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`medida_id`) REFERENCES `unidad_medida` (`id`),
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id_categoria`),
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategoria` (`id_subcategoria`);

--
-- Filtros para la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`documento`) REFERENCES `tipo_documento` (`id`);

--
-- Filtros para la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD CONSTRAINT `subcategoria_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id_categoria`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id_rol`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_id_venta` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
