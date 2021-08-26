-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-08-2021 a las 18:19:06
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.8

DROP DATABASE IF EXISTS SVOlanoSAC;
CREATE DATABASE SVOlanoSAC;
USE SVOlanoSAC;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `svolanosac`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Actualizar` ()  begin
	UPDATE caja set saldo = (SELECT  sum(c.monto) FROM caja c WHERE c.id_caja <= caja.id_caja);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productos_mas_vendidos` ()  BEGIN
	SELECT YEAR(fecha) as año, p.producto, SUM(cantidad) as importe
    FROM venta v inner join detalle_venta d on d.venta_id = v.id_venta
    inner join producto p on p.id_producto = d.producto_id
    WHERE YEAR(fecha) = DATE_FORMAT(Now(),'%Y') GROUP BY año,p.producto ORDER BY importe DESC LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ventas_x_mes` ()  BEGIN
	SELECT YEAR(fecha) as año,MONTH(fecha) as mes,CAST(SUM(total) AS DECIMAL(12,2)) as total
    FROM venta WHERE YEAR(fecha) = DATE_FORMAT(Now(),'%Y') GROUP BY mes,año ORDER BY mes asc;
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
  `monto` decimal(10,2) NOT NULL,
  `saldo` decimal(10,2) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `estado` tinyint(1) NOT NULL,
  `estadoMovimiento` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `categoria` varchar(40) NOT NULL,
  `estado` enum('Habilitado','Deshabilitado') NOT NULL DEFAULT 'Habilitado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `categoria`, `estado`) VALUES
(1, 'Construcción', 'Habilitado'),
(2, 'Pisos y Cerámicos', 'Habilitado'),
(3, 'Tuberías y accesorios', 'Habilitado'),
(4, 'Ferretería general', 'Habilitado'),
(5, 'Galvanizados', 'Habilitado'),
(6, 'Grifería', 'Habilitado'),
(7, 'Herramientas eléctricas', 'Habilitado'),
(8, 'Limpieza y aseo', 'Habilitado'),
(9, 'Pinturas y solvente', 'Habilitado'),
(10, 'Iluminación', 'Habilitado');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `documento`, `nrodocumento`, `direccion`, `telefono`, `email`) VALUES
(1, 'Juan Robles Gonzales', 1, '27678960', 'Av. Las Anemonas 1232 San Juan de Lurigancho', '986556444', 'jrobles@gmail.com'),
(2, 'Waldir Sanchez', 1, '12345678', 'Universidad Cesar Vallejo ', '987654321', 'waldir@gmail.com'),
(3, 'Betsi Mendoza', 1, '99999999', 'Trujillo', '21212121', 'betsi@gmail.com'),
(4, 'Isac Miñano', 1, '89868575', 'Guadalupe', '65656565', 'isac@gmail.com'),
(5, 'Jhon Cruzado', 1, '45654568', 'Chepén', '45654654', 'jhon@gmail.com'),
(6, 'BANCO BBVA PERU', 2, '20100130204', 'AV. REP DE PANAMA NRO. 3055 URB. EL PALOMAR LIMA LIMA SAN ISIDRO', '4562145', 'bbva@peru.com'),
(7, 'BANCO DE COMERCIO', 2, '20509507199', 'AV. CANAVAL Y MOREYRA NRO. 452 LIMA LIMA SAN ISIDRO', '85658214', 'bcomercio@gmail.com'),
(8, 'ROSA ERMILA BAUTISTA SILVA', 1, '19249305', 'SAN PEDRO', '12345678', 'rosa@gmail.com'),
(11, 'BANCO DE COMERCIO', 2, '20509507199', 'AV. CANAVAL Y MOREYRA NRO. 452 LIMA LIMA SAN ISIDRO', '796542', 'comercio@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id_compra` bigint(20) NOT NULL,
  `proveedor_id` int(11) NOT NULL,
  `subtotal` float(12,2) NOT NULL,
  `igv` float(12,2) NOT NULL,
  `total` float(12,2) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id_detalle` bigint(20) NOT NULL,
  `compra_id` bigint(20) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `precio` float(8,2) NOT NULL,
  `cantidad` float(8,2) NOT NULL,
  `descuento` float(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Disparadores `detalle_compra`
--
DELIMITER $$
CREATE TRIGGER `kardex_ingreso` AFTER INSERT ON `detalle_compra` FOR EACH ROW BEGIN
	DECLARE cantidad BIGINT;
    DECLARE valor_promedio FLOAT(8,2);
    DECLARE v_total FLOAT(12,2);
    DECLARE cantidad_total FLOAT(12,2);
    SET cantidad = (SELECT COUNT(*) FROM kardex WHERE producto_id = NEW.producto_id);
    IF cantidad = 0 THEN
		UPDATE producto SET precio_compra = NEW.precio, precio_venta = ROUND(NEW.precio/(1-0.25),1),stock = (stock + NEW.cantidad) WHERE id_producto = NEW.producto_id;

		INSERT INTO kardex(fecha,producto_id,operacion,nrodocumento,valor_unitario,cantidad,valor,stock_total,valor_total)
		VALUES(CURDATE(),NEW.producto_id,'Compra',NEW.compra_id,NEW.precio,NEW.cantidad,NEW.precio,NEW.cantidad,(NEW.precio * NEW.cantidad));
    ELSE
		SET v_total = (SELECT valor_total FROM kardex WHERE producto_id = NEW.producto_id ORDER BY id_kardex DESC LIMIT 1);
        SET v_total = (v_total + (NEW.precio * NEW.cantidad));
        SET valor_promedio = (SELECT valor_unitario FROM kardex WHERE producto_id = NEW.producto_id ORDER BY id_kardex DESC LIMIT 1);
        SET valor_promedio = ROUND((CAST(valor_promedio AS DECIMAL(8,2)) + CAST(NEW.precio AS DECIMAL(8,2))) / 2,1);
        SET cantidad_total = (SELECT stock_total FROM kardex WHERE producto_id = NEW.producto_id ORDER BY id_kardex DESC LIMIT 1);
        SET cantidad_total = (cantidad_total + NEW.cantidad);
        UPDATE producto SET precio_compra = valor_promedio, precio_venta = ROUND(valor_promedio/(1-0.25),1),stock = (stock + NEW.cantidad) WHERE id_producto = NEW.producto_id;

		INSERT INTO kardex(fecha,producto_id,operacion,nrodocumento,valor_unitario,cantidad,valor,stock_total,valor_total)
		VALUES(CURDATE(),NEW.producto_id,'Compra',NEW.compra_id,valor_promedio,NEW.cantidad,NEW.precio,cantidad_total,v_total);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id_detalle` bigint(20) NOT NULL,
  `venta_id` bigint(20) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `precio` float(8,2) NOT NULL,
  `cantidad` float(8,2) NOT NULL,
  `descuento` float(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `kardex_egreso` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
	DECLARE cantidad BIGINT;
    DECLARE valor_promedio FLOAT(8,2);
    DECLARE v_total FLOAT(12,2);
    DECLARE cantidad_total FLOAT(12,2);

    SET cantidad = (SELECT COUNT(*) FROM kardex WHERE producto_id = NEW.producto_id AND operacion = 'Compra');
    UPDATE producto SET stock = (stock - NEW.cantidad) WHERE id_producto = NEW.producto_id;
    SET valor_promedio = (SELECT precio_compra FROM producto WHERE id_producto = NEW.producto_id);
    SET cantidad_total = (SELECT stock FROM producto WHERE id_producto = NEW.producto_id);

    IF cantidad = 0 THEN
		SET v_total = (SELECT precio_compra * stock FROM producto WHERE id_producto = NEW.producto_id);
		INSERT INTO kardex(fecha,producto_id,operacion,nrodocumento,valor_unitario,cantidad,valor,stock_total,valor_total)
		VALUES(CURDATE(),NEW.producto_id,'Venta',NEW.venta_id,valor_promedio,NEW.cantidad,valor_promedio,cantidad_total,v_total);
    ELSE
		SET v_total = (SELECT valor_total FROM kardex WHERE producto_id = NEW.producto_id ORDER BY id_kardex DESC LIMIT 1);
        SET v_total = (v_total - (CAST(valor_promedio AS DECIMAL(8,2)) * NEW.cantidad));
        SET cantidad_total = (cantidad_total - NEW.cantidad);
		INSERT INTO kardex(fecha,producto_id,operacion,nrodocumento,valor_unitario,cantidad,valor,stock_total,valor_total)
		VALUES(CURDATE(),NEW.producto_id,'Venta',NEW.venta_id,valor_promedio,NEW.cantidad,valor_promedio,cantidad_total,v_total);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `ruc` char(11) NOT NULL,
  `telefono` char(15) NOT NULL,
  `direccion` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id`, `nombre`, `ruc`, `telefono`, `direccion`) VALUES
(1, 'Distribuciones Olano S.A.C.', '20103365628', '987654332', 'Exequiel Gonzales Caceda 1151, Chepén 13871');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex`
--

CREATE TABLE `kardex` (
  `id_kardex` bigint(20) NOT NULL,
  `fecha` date NOT NULL,
  `producto_id` int(11) NOT NULL,
  `operacion` enum('Compra','Venta') NOT NULL,
  `descripcion` varchar(40) DEFAULT NULL,
  `nrodocumento` bigint(20) NOT NULL,
  `valor_unitario` float(8,2) NOT NULL,
  `cantidad` float(8,2) NOT NULL,
  `valor` float(8,2) NOT NULL,
  `stock_total` float(12,2) NOT NULL,
  `valor_total` float(12,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `producto` varchar(200) NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `stock_minimo` int(11) NOT NULL,
  `precio_compra` float(12,2) NOT NULL,
  `precio_venta` float(12,2) NOT NULL,
  `foto` varchar(2048) DEFAULT NULL,
  `vence` enum('Si','No') NOT NULL,
  `medida_id` int(11) NOT NULL,
  `estado` enum('Habilitado','Deshabilitado') NOT NULL DEFAULT 'Habilitado',
  `categoria_id` int(11) DEFAULT NULL,
  `subcategoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `producto`, `ubicacion`, `stock`, `stock_minimo`, `precio_compra`, `precio_venta`, `foto`, `vence`, `medida_id`, `estado`, `categoria_id`, `subcategoria_id`) VALUES
(1000, 'CEMENTO PACASMAYO TICOEXTRAF', 'zona A, pasillo 1, nivel 1', 0, 10, 0.00, 46.70, 'cemento-pacasmayo-antisalitre-tipo-ms.jpg', 'Si', 1, 'Habilitado', 1, 1),
(1001, 'CEMENTO PACASMAYO MS ANTISALIT', 'zona A, pasillo 1, nivel 2', 0, 10, 0.00, 46.70, 'cemento-pacasmayo-extrafuerte-tipo-ico.jpg', 'Si', 1, 'Habilitado', 1, 1),
(1002, 'CEMENTO PACASMAYO PORTLAND TIPO V', 'zona A, pasillo 1, nivel 3', 0, 10, 0.00, 40.00, 'cemento-pacasmayo-portland-tipo-v.jpg', 'Si', 1, 'Habilitado', 1, 1),
(1003, 'CEMENTO PACASMAYO TIPO I', 'zona A, pasillo 1, nivel 4', 0, 10, 0.00, 25.50, 'cemento-pacasmayo-tipo-i.jpg', 'Si', 1, 'Habilitado', 1, 4),
(1004, 'Ladrillo Para Techo 15x30x30', 'Almacén 2, zona L', 0, 10, 0.00, 28.50, 'Ladrillo-Para-Techo-15x30x30.jpg', 'No', 1, 'Habilitado', 1, 4),
(1005, 'Ladrillo Pandereta Rayada', 'Almacén 2, zona L1', 0, 10, 0.00, 27.50, 'Ladrillo-Pandereta-Rayada.jpg', 'No', 1, 'Habilitado', 1, 4),
(1006, 'Ladrillo King Kong 18h 24x12x9', 'Almacén 2, zona L2', 0, 10, 0.00, 26.50, 'Ladrillo-King-Kong-18h-24x12x9.jpg', 'No', 1, 'Habilitado', 1, 4),
(1007, 'Ladrillo Techo 08x30x30', 'Almacén 2, zona L3', 0, 10, 0.00, 25.50, 'Ladrillo-Techo-08x30x30.jpg', 'No', 1, 'Habilitado', 1, 1),
(1008, 'P60x60 Porcelanato Español Olimpia Blanco', 'zona B, pasillo 1, nivel 1', 0, 10, 0.00, 15.00, 'P60x60-Porcelanato-Español-Olimpia-Blanco.jpg', 'No', 1, 'Habilitado', 2, 2),
(1009, 'P60x60 Porcelanato Vitrif. Madera Shg-66a1101q', 'zona B, pasillo 1, nivel 2', 0, 10, 0.00, 15.00, 'P60x60-Porcelanato-Vitrif-Madera Shg-66a1101q.jpg', 'No', 1, 'Habilitado', 2, 2),
(1010, 'P60x60 Porc. Vitrif. Agatha Geo Nogal Fstb2s006', 'zona B, pasillo 1, nivel 3', 0, 10, 0.00, 15.00, 'P60x60-Porc-Vitrif-Agatha-Geo-Nogal-Fstb2s006.jpg', 'No', 1, 'Habilitado', 2, 2),
(1011, 'P60x60 Porc. Vitrif. Agatha Caramel Fstb13h230', 'zona B, pasillo 1, nivel 4', 0, 10, 0.00, 15.00, 'P60x60-Porc-Vitrif-Agatha-Caramel-Fstb13h230.jpg', 'No', 1, 'Habilitado', 2, 2),
(1012, 'Pintura Latex Satinado Violeta Africana', 'zona B, pasillo 2, nivel 1', 0, 10, 0.00, 28.50, 'Pintura-Latex-Satinado-Violeta-Africana.jpg', 'Si', 1, 'Habilitado', 9, 11),
(1013, 'Pintura Latex Satinado Violeta Activa', 'zona B, pasillo 2, nivel 2', 0, 10, 0.00, 27.50, 'Pintura-Latex-Satinado-Violeta-Activa.jpg', 'Si', 1, 'Habilitado', 9, 11),
(1014, 'Pintura Latex Satinado Turqueza', 'zona B, pasillo 2, nivel 3', 0, 10, 0.00, 26.50, 'Pintura-Latex-Satinado-Turqueza.jpg', 'Si', 1, 'Habilitado', 9, 11),
(1015, 'Pintura Latex Satinado Sunset Gl', 'zona B, pasillo 2, nivel 4', 0, 10, 0.00, 25.50, 'Pintura-Latex-Satinado-Sunset-Gl.jpg', 'Si', 1, 'Habilitado', 9, 11),
(1016, 'Foco Globo Led E27 – 18w Luz Blanca', 'zona B, pasillo 3, nivel 1', 0, 10, 0.00, 26.50, 'Foco-Globo-Led-E27–18w-Luz-Blanca.jpg', 'No', 1, 'Habilitado', 10, 12),
(1017, 'Foco Led 8.5w E27 Luz Calida', 'zona B, pasillo 3, nivel 2', 0, 10, 0.00, 25.50, 'Foco-Led-8.5w-E27-Luz-Calida.jpg', 'No', 1, 'Habilitado', 10, 12);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `raz_social`, `documento`, `nrodocumento`, `direccion`, `contacto`, `telefono`, `email`) VALUES
(1, 'SUPPLIER S.A', 2, '5383558485', 'Calle Piérola,4325,Of. 3043', 'Jorge Carranza Perez', '976226442', 'jcarranza@gmail.com'),
(4, 'TIENDAS DEL MEJORAMIENTO DEL HOGAR S.A.', 2, '20112273922', 'AV. ANGAMOS ESTE NRO. 1805 INT. 2 LIMA LIMA SURQUILLO', 'Juan Espinoza Lopez', '985641238', 'jespinoza@gmail.com'),
(5, 'GAMBOA IMPORT Y EXPORT S.A.', 2, '20255255666', 'AV. ARGENTINA NRO. 1910 LIMA LIMA LIMA', 'Betsi Mendoza Bautista', '12345678', 'betsi@gmail.com'),
(6, 'BANCO DE LA NACION', 2, '20100030595', 'AV. JAVIER PRADO ESTE NRO. 2499 URB. SAN BORJA LIMA LIMA SAN BORJA', 'Isac Miñano Corro', '121211', 'iminano@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `rol` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('ZcLwDZoYUtczMMtztjfzzlUQTIJ5MzpBwf2KdtPf', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiY3lCenkyQjV3ajBucnF6OWVhMXBXdTFqdDhxcjRyTmt0NU9TQ1RqUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jYWphIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEwJDkySVhVTnBrak8wck9RNWJ5TWkuWWU0b0tvRWEzUm85bGxDLy5vZy9hdDIudWhlV0cvaWdpIjtzOjIxOiJwYXNzd29yZF9oYXNoX3NhbmN0dW0iO3M6NjA6IiQyeSQxMCQ5MklYVU5wa2pPMHJPUTVieU1pLlllNG9Lb0VhM1JvOWxsQy8ub2cvYXQyLnVoZVdHL2lnaSI7fQ==', 1629994697);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategoria`
--

CREATE TABLE `subcategoria` (
  `id_subcategoria` int(11) NOT NULL,
  `subcategoria` varchar(40) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `estado` enum('Habilitado','Deshabilitado') NOT NULL DEFAULT 'Habilitado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `subcategoria`
--

INSERT INTO `subcategoria` (`id_subcategoria`, `subcategoria`, `categoria_id`, `estado`) VALUES
(1, 'Cemento', 1, 'Habilitado'),
(2, 'Porcelanato', 2, 'Habilitado'),
(3, 'Fierro de construcción', 1, 'Habilitado'),
(4, 'Ladrillo', 1, 'Habilitado'),
(5, 'Yeso', 1, 'Habilitado'),
(6, 'Alicates', 3, 'Habilitado'),
(7, 'Cerraduras', 3, 'Habilitado'),
(8, 'Cable', 3, 'Habilitado'),
(9, 'Clavos', 3, 'Habilitado'),
(10, 'Destornillador', 3, 'Habilitado'),
(11, 'Latex', 9, 'Habilitado'),
(12, 'Focos', 10, 'Habilitado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `id` int(11) NOT NULL,
  `tipo` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `profile_photo_path` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rol_id` int(11) NOT NULL,
  `estado` enum('Habilitado','Deshabilitado') DEFAULT 'Habilitado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `profile_photo_path`, `created_at`, `updated_at`, `rol_id`, `estado`) VALUES
(1, 'Waldir Sanchez', 'waldirc925@gmail.com', '$2y$10$DC1teJyeeLIbyQoqDkcYcOpdknNspwYl.s1vFtSB0OukekMtIK9sW', NULL, '2021-06-27 21:21:17', '2021-07-04 04:02:01', 1, 'Habilitado'),
(2, 'Jhon Cruzado', 'jhonpaulcruzadodelacruz@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2021-06-27 21:21:17', '2021-07-04 04:02:01', 1, 'Habilitado');

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
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `proveedor_id` (`proveedor_id`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `producto_id` (`producto_id`),
  ADD KEY `compra_id` (`compra_id`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `fk_producto_id` (`producto_id`),
  ADD KEY `fk_venta_id` (`venta_id`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `kardex`
--
ALTER TABLE `kardex`
  ADD PRIMARY KEY (`id_kardex`),
  ADD KEY `producto_id` (`producto_id`);

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
  MODIFY `id_caja` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `id_compra` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1005;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id_detalle` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id_detalle` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `kardex`
--
ALTER TABLE `kardex`
  MODIFY `id_kardex` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1018;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `id_subcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id_venta` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`documento`) REFERENCES `tipo_documento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`compra_id`) REFERENCES `compra` (`id_compra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_detalle` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_detalle2` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`),
  ADD CONSTRAINT `fk_venta_id` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id_venta`);

--
-- Filtros para la tabla `kardex`
--
ALTER TABLE `kardex`
  ADD CONSTRAINT `kardex_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`medida_id`) REFERENCES `unidad_medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategoria` (`id_subcategoria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`documento`) REFERENCES `tipo_documento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD CONSTRAINT `subcategoria_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id_rol`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_id_venta` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
