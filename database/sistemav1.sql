
-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 07-08-2021 a las 03:01:11
-- Versión del servidor: 5.7.24
-- Versión de PHP: 7.4.7

drop database if exists sistemav1;
create database sistemav1;
use sistemav1;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistemav1`
--

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
(5, 'Grifería', 'Habilitado'),
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
(1, 'Jhon Cruzado', 1, '567890', 'Calle Junín #021', '999888778', 'jcruzado@gmail.com');

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
(1001, 'Ladrillo XYZ', 12, 8, 9.00, 11.00, '610db09f1677a.jpg', 'No', NULL, 1, 'Disponible', 1, 3);

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
  `user_agent` text,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('sXrEWZGLeQ8Azdp0Q58rUvIe3Jmhg5oAyyKMbdpZ', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36 Edg/92.0.902.67', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiM0Z1cXlFVGo4SFVpeUNpaGtYckw5UHhpUVEyVVlvcUpJVEc0RXczTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG0tcHJvZHVjdG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MztzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEwJERDMXRlSnllZUxJYnlRb3FEa2NZY09wZGtuTnNwd1lsLnMxdkZ0U0IwT3VrZWtNdElLOXNXIjtzOjIxOiJwYXNzd29yZF9oYXNoX3NhbmN0dW0iO3M6NjA6IiQyeSQxMCREQzF0ZUp5ZWVMSWJ5UW9xRGtjWWNPcGRrbk5zcHdZbC5zMXZGdFNCME91a2VrTXRJSzlzVyI7fQ==', 1628304571);

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
(9, 'Destornillador', 3, 'Habilitado');

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
(3, 'Waldir Sanchez', 'waldirc925@gmail.com', '$2y$10$DC1teJyeeLIbyQoqDkcYcOpdknNspwYl.s1vFtSB0OukekMtIK9sW', NULL, '2021-06-27 21:21:17', '2021-07-04 04:02:01', 1);

--
-- Índices para tablas volcadas
--

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
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `medida_id` (`medida_id`),
  ADD KEY `categoria_id` (`categoria_id`),
  ADD KEY `subcategoria_id` (`subcategoria_id`);

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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1002;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `id_subcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`documento`) REFERENCES `tipo_documento` (`id`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`medida_id`) REFERENCES `unidad_medida` (`id`),
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id_categoria`),
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategoria` (`id_subcategoria`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
