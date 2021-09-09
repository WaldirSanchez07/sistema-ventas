-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 09-09-2021 a las 20:33:43
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

DELIMITER $$
--
-- Procedimientos
--
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `documento`, `nrodocumento`, `direccion`, `telefono`, `email`) VALUES
(1, 'Juan Robles Gonzales', 1, '27678960', 'Av. Las Anemonas 1232 San Juan de Lurigancho', '986556444', 'jrobles@gmail.com'),
(2, 'Sidney M. Chandler', 1, '20172950', 'Carretera Cádiz-Málaga, 36', '986556444', 'sidneymchandler@gmail.com'),
(3, 'Rafael G. Madden', 1, '24608140', 'Rúa do Paseo, 59', '952156147', 'rafaelgmadden@gmail.com'),
(4, 'Daren B. Gould', 1, '25618250', 'Avenida Cervantes, 86', '986556444', 'darenbgould@gmail.com'),
(5, 'James P. Morgan', 1, '26628360', 'Rua da Rapina, 74', '986556444', 'jamespmorgan@gmail.com');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`id_compra`, `proveedor_id`, `subtotal`, `igv`, `total`, `fecha`) VALUES
(1000, 1, 5674.40, 1245.60, 6920.00, '2021-01-02 09:19:33'),
(1001, 2, 6396.00, 1404.00, 7800.00, '2021-01-02 09:24:08'),
(1002, 3, 6002.40, 1317.60, 7320.00, '2021-01-02 09:28:09'),
(1003, 4, 2681.40, 588.60, 3270.00, '2021-01-02 09:31:41'),
(1004, 5, 478.88, 105.12, 584.00, '2021-01-02 09:32:59');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`id_detalle`, `compra_id`, `producto_id`, `precio`, `cantidad`, `descuento`) VALUES
(1, 1000, 1000, 17.00, 100.00, 0.00),
(2, 1000, 1001, 17.20, 100.00, 0.00),
(3, 1000, 1002, 17.40, 100.00, 0.00),
(4, 1000, 1003, 17.60, 100.00, 0.00),
(5, 1001, 1004, 1.80, 1000.00, 0.00),
(6, 1001, 1005, 1.90, 1000.00, 0.00),
(7, 1001, 1006, 2.00, 1000.00, 0.00),
(8, 1001, 1007, 2.10, 1000.00, 0.00),
(9, 1002, 1008, 9.00, 200.00, 0.00),
(10, 1002, 1009, 9.10, 200.00, 0.00),
(11, 1002, 1010, 9.20, 200.00, 0.00),
(12, 1002, 1011, 9.30, 200.00, 0.00),
(13, 1003, 1012, 16.20, 50.00, 0.00),
(14, 1003, 1013, 16.30, 50.00, 0.00),
(15, 1003, 1014, 16.40, 50.00, 0.00),
(16, 1003, 1015, 16.50, 50.00, 0.00),
(17, 1004, 1016, 7.20, 40.00, 0.00),
(18, 1004, 1017, 7.40, 40.00, 0.00);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id_detalle`, `venta_id`, `producto_id`, `precio`, `cantidad`, `descuento`) VALUES
(1, 1000, 1000, 22.70, 5.00, 0.00),
(2, 1001, 1000, 22.70, 7.00, 0.00),
(3, 1002, 1000, 22.70, 10.00, 0.00),
(4, 1002, 1004, 2.40, 150.00, 0.00),
(5, 1003, 1016, 9.60, 5.00, 0.00),
(6, 1004, 1017, 9.90, 4.00, 0.00),
(7, 1005, 1012, 21.60, 5.00, 0.00),
(8, 1006, 1013, 21.70, 10.00, 0.00),
(9, 1007, 1014, 21.90, 12.00, 0.00),
(10, 1008, 1009, 12.10, 20.00, 0.00),
(11, 1008, 1002, 23.20, 5.00, 0.00),
(12, 1009, 1016, 9.60, 5.00, 0.00),
(13, 1010, 1016, 9.60, 7.00, 0.00),
(14, 1011, 1010, 12.30, 50.00, 0.00),
(15, 1012, 1016, 9.60, 3.00, 0.00),
(16, 1013, 1012, 21.60, 10.00, 0.00),
(17, 1014, 1014, 21.90, 8.00, 0.00),
(18, 1015, 1004, 2.40, 50.00, 0.00),
(19, 1015, 1005, 2.50, 200.00, 0.00),
(20, 1016, 1008, 12.00, 10.00, 0.00),
(21, 1017, 1009, 12.10, 20.00, 0.00),
(22, 1018, 1010, 12.30, 30.00, 0.00),
(23, 1019, 1012, 21.60, 5.00, 0.00),
(24, 1020, 1014, 21.90, 5.00, 0.00),
(25, 1021, 1000, 22.70, 8.00, 0.00),
(26, 1021, 1002, 23.20, 5.00, 0.00),
(27, 1022, 1004, 2.40, 50.00, 0.00),
(28, 1023, 1008, 12.00, 30.00, 0.00),
(29, 1024, 1000, 22.70, 5.00, 0.00),
(30, 1024, 1005, 2.50, 50.00, 0.00),
(31, 1025, 1000, 22.70, 5.00, 0.00),
(32, 1026, 1002, 23.20, 10.00, 0.00),
(33, 1027, 1004, 2.40, 50.00, 0.00),
(34, 1028, 1008, 12.00, 10.00, 0.00),
(35, 1029, 1005, 2.50, 50.00, 0.00),
(36, 1030, 1000, 22.70, 5.00, 0.00),
(37, 1031, 1005, 2.50, 100.00, 0.00),
(38, 1032, 1008, 12.00, 20.00, 0.00),
(39, 1033, 1012, 21.60, 5.00, 0.00),
(40, 1033, 1014, 21.90, 5.00, 0.00),
(41, 1034, 1016, 9.60, 5.00, 0.00),
(42, 1034, 1017, 9.90, 6.00, 0.00),
(43, 1035, 1012, 21.60, 5.00, 0.00),
(44, 1036, 1009, 12.10, 10.00, 0.00),
(45, 1037, 1001, 22.90, 30.00, 0.00),
(46, 1037, 1003, 23.50, 20.00, 0.00),
(47, 1038, 1004, 2.40, 50.00, 0.00),
(48, 1038, 1006, 2.70, 100.00, 0.00),
(49, 1038, 1007, 2.80, 150.00, 0.00),
(50, 1039, 1002, 23.20, 10.00, 0.00),
(51, 1039, 1006, 2.70, 100.00, 0.00),
(52, 1040, 1007, 2.80, 150.00, 0.00),
(53, 1041, 1006, 2.70, 200.00, 0.00),
(54, 1041, 1007, 2.80, 200.00, 0.00),
(55, 1042, 1009, 12.10, 30.00, 0.00),
(56, 1042, 1010, 12.30, 20.00, 0.00),
(57, 1042, 1011, 12.40, 20.00, 0.00),
(58, 1043, 1013, 21.70, 15.00, 0.00),
(59, 1044, 1017, 9.90, 7.00, 0.00),
(60, 1044, 1015, 22.00, 10.00, 0.00),
(61, 1044, 1000, 22.70, 5.00, 0.00),
(62, 1044, 1003, 23.50, 5.00, 0.00),
(63, 1045, 1006, 2.70, 300.00, 0.00),
(64, 1045, 1004, 2.40, 250.00, 0.00),
(65, 1046, 1000, 22.70, 20.00, 0.00),
(66, 1046, 1003, 23.50, 15.00, 0.00),
(67, 1046, 1006, 2.70, 100.00, 0.00),
(68, 1047, 1016, 9.60, 5.00, 0.00),
(69, 1048, 1017, 9.90, 8.00, 0.00),
(70, 1049, 1000, 22.70, 2.00, 0.00);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `valor_total` float(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `kardex`
--

INSERT INTO `kardex` (`id_kardex`, `fecha`, `producto_id`, `operacion`, `descripcion`, `nrodocumento`, `valor_unitario`, `cantidad`, `valor`, `stock_total`, `valor_total`) VALUES
(1, '2021-08-31', 1000, 'Compra', NULL, 1000, 17.00, 100.00, 17.00, 100.00, 1700.00),
(2, '2021-08-31', 1001, 'Compra', NULL, 1000, 17.20, 100.00, 17.20, 100.00, 1720.00),
(3, '2021-08-31', 1002, 'Compra', NULL, 1000, 17.40, 100.00, 17.40, 100.00, 1740.00),
(4, '2021-08-31', 1003, 'Compra', NULL, 1000, 17.60, 100.00, 17.60, 100.00, 1760.00),
(5, '2021-08-31', 1004, 'Compra', NULL, 1001, 1.80, 1000.00, 1.80, 1000.00, 1800.00),
(6, '2021-08-31', 1005, 'Compra', NULL, 1001, 1.90, 1000.00, 1.90, 1000.00, 1900.00),
(7, '2021-08-31', 1006, 'Compra', NULL, 1001, 2.00, 1000.00, 2.00, 1000.00, 2000.00),
(8, '2021-08-31', 1007, 'Compra', NULL, 1001, 2.10, 1000.00, 2.10, 1000.00, 2100.00),
(9, '2021-08-31', 1008, 'Compra', NULL, 1002, 9.00, 200.00, 9.00, 200.00, 1800.00),
(10, '2021-08-31', 1009, 'Compra', NULL, 1002, 9.10, 200.00, 9.10, 200.00, 1820.00),
(11, '2021-08-31', 1010, 'Compra', NULL, 1002, 9.20, 200.00, 9.20, 200.00, 1840.00),
(12, '2021-08-31', 1011, 'Compra', NULL, 1002, 9.30, 200.00, 9.30, 200.00, 1860.00),
(13, '2021-08-31', 1012, 'Compra', NULL, 1003, 16.20, 50.00, 16.20, 50.00, 810.00),
(14, '2021-08-31', 1013, 'Compra', NULL, 1003, 16.30, 50.00, 16.30, 50.00, 815.00),
(15, '2021-08-31', 1014, 'Compra', NULL, 1003, 16.40, 50.00, 16.40, 50.00, 820.00),
(16, '2021-08-31', 1015, 'Compra', NULL, 1003, 16.50, 50.00, 16.50, 50.00, 825.00),
(17, '2021-08-31', 1016, 'Compra', NULL, 1004, 7.20, 40.00, 7.20, 40.00, 288.00),
(18, '2021-08-31', 1017, 'Compra', NULL, 1004, 7.40, 40.00, 7.40, 40.00, 296.00),
(19, '2021-08-31', 1000, 'Venta', NULL, 1000, 17.00, 5.00, 17.00, 90.00, 1615.00),
(20, '2021-08-31', 1000, 'Venta', NULL, 1001, 17.00, 7.00, 17.00, 81.00, 1496.00),
(21, '2021-08-31', 1000, 'Venta', NULL, 1002, 17.00, 10.00, 17.00, 68.00, 1326.00),
(22, '2021-08-31', 1004, 'Venta', NULL, 1002, 1.80, 150.00, 1.80, 700.00, 1530.00),
(23, '2021-08-31', 1016, 'Venta', NULL, 1003, 7.20, 5.00, 7.20, 30.00, 252.00),
(24, '2021-08-31', 1017, 'Venta', NULL, 1004, 7.40, 4.00, 7.40, 32.00, 266.40),
(25, '2021-08-31', 1012, 'Venta', NULL, 1005, 16.20, 5.00, 16.20, 40.00, 729.00),
(26, '2021-08-31', 1013, 'Venta', NULL, 1006, 16.30, 10.00, 16.30, 30.00, 652.00),
(27, '2021-08-31', 1014, 'Venta', NULL, 1007, 16.40, 12.00, 16.40, 26.00, 623.20),
(28, '2021-08-31', 1009, 'Venta', NULL, 1008, 9.10, 20.00, 9.10, 160.00, 1638.00),
(29, '2021-08-31', 1002, 'Venta', NULL, 1008, 17.40, 5.00, 17.40, 90.00, 1653.00),
(30, '2021-08-31', 1016, 'Venta', NULL, 1009, 7.20, 5.00, 7.20, 25.00, 216.00),
(31, '2021-08-31', 1016, 'Venta', NULL, 1010, 7.20, 7.00, 7.20, 16.00, 165.60),
(32, '2021-08-31', 1010, 'Venta', NULL, 1011, 9.20, 50.00, 9.20, 100.00, 1380.00),
(33, '2021-08-31', 1016, 'Venta', NULL, 1012, 7.20, 3.00, 7.20, 17.00, 144.00),
(34, '2021-08-31', 1012, 'Venta', NULL, 1013, 16.20, 10.00, 16.20, 25.00, 567.00),
(35, '2021-08-31', 1014, 'Venta', NULL, 1014, 16.40, 8.00, 16.40, 22.00, 492.00),
(36, '2021-08-31', 1004, 'Venta', NULL, 1015, 1.80, 50.00, 1.80, 750.00, 1440.00),
(37, '2021-08-31', 1005, 'Venta', NULL, 1015, 1.90, 200.00, 1.90, 600.00, 1520.00),
(38, '2021-08-31', 1008, 'Venta', NULL, 1016, 9.00, 10.00, 9.00, 180.00, 1710.00),
(39, '2021-08-31', 1009, 'Venta', NULL, 1017, 9.10, 20.00, 9.10, 140.00, 1456.00),
(40, '2021-08-31', 1010, 'Venta', NULL, 1018, 9.20, 30.00, 9.20, 90.00, 1104.00),
(41, '2021-08-31', 1012, 'Venta', NULL, 1019, 16.20, 5.00, 16.20, 25.00, 486.00),
(42, '2021-08-31', 1014, 'Venta', NULL, 1020, 16.40, 5.00, 16.40, 20.00, 410.00),
(43, '2021-08-31', 1000, 'Venta', NULL, 1021, 17.00, 8.00, 17.00, 62.00, 1190.00),
(44, '2021-08-31', 1002, 'Venta', NULL, 1021, 17.40, 5.00, 17.40, 85.00, 1566.00),
(45, '2021-08-31', 1004, 'Venta', NULL, 1022, 1.80, 50.00, 1.80, 700.00, 1350.00),
(46, '2021-08-31', 1008, 'Venta', NULL, 1023, 9.00, 30.00, 9.00, 130.00, 1440.00),
(47, '2021-08-31', 1000, 'Venta', NULL, 1024, 17.00, 5.00, 17.00, 60.00, 1105.00),
(48, '2021-08-31', 1005, 'Venta', NULL, 1024, 1.90, 50.00, 1.90, 700.00, 1425.00),
(49, '2021-08-31', 1000, 'Venta', NULL, 1025, 17.00, 5.00, 17.00, 55.00, 1020.00),
(50, '2021-08-31', 1002, 'Venta', NULL, 1026, 17.40, 10.00, 17.40, 70.00, 1392.00),
(51, '2021-08-31', 1004, 'Venta', NULL, 1027, 1.80, 50.00, 1.80, 650.00, 1260.00),
(52, '2021-08-31', 1008, 'Venta', NULL, 1028, 9.00, 10.00, 9.00, 140.00, 1350.00),
(53, '2021-08-31', 1005, 'Venta', NULL, 1029, 1.90, 50.00, 1.90, 650.00, 1330.00),
(54, '2021-08-31', 1000, 'Venta', NULL, 1030, 17.00, 5.00, 17.00, 50.00, 935.00),
(55, '2021-08-31', 1005, 'Venta', NULL, 1031, 1.90, 100.00, 1.90, 500.00, 1140.00),
(56, '2021-08-31', 1008, 'Venta', NULL, 1032, 9.00, 20.00, 9.00, 110.00, 1170.00),
(57, '2021-08-31', 1012, 'Venta', NULL, 1033, 16.20, 5.00, 16.20, 20.00, 405.00),
(58, '2021-08-31', 1014, 'Venta', NULL, 1033, 16.40, 5.00, 16.40, 15.00, 328.00),
(59, '2021-08-31', 1016, 'Venta', NULL, 1034, 7.20, 5.00, 7.20, 10.00, 108.00),
(60, '2021-08-31', 1017, 'Venta', NULL, 1034, 7.40, 6.00, 7.40, 24.00, 222.00),
(61, '2021-08-31', 1012, 'Venta', NULL, 1035, 16.20, 5.00, 16.20, 15.00, 324.00),
(62, '2021-08-31', 1009, 'Venta', NULL, 1036, 9.10, 10.00, 9.10, 140.00, 1365.00),
(63, '2021-08-31', 1001, 'Venta', NULL, 1037, 17.20, 30.00, 17.20, 40.00, 1204.00),
(64, '2021-08-31', 1003, 'Venta', NULL, 1037, 17.60, 20.00, 17.60, 60.00, 1408.00),
(65, '2021-08-31', 1004, 'Venta', NULL, 1038, 1.80, 50.00, 1.80, 600.00, 1170.00),
(66, '2021-08-31', 1006, 'Venta', NULL, 1038, 2.00, 100.00, 2.00, 800.00, 1800.00),
(67, '2021-08-31', 1007, 'Venta', NULL, 1038, 2.10, 150.00, 2.10, 700.00, 1785.00),
(68, '2021-08-31', 1002, 'Venta', NULL, 1039, 17.40, 10.00, 17.40, 60.00, 1218.00),
(69, '2021-08-31', 1006, 'Venta', NULL, 1039, 2.00, 100.00, 2.00, 700.00, 1600.00),
(70, '2021-08-31', 1007, 'Venta', NULL, 1040, 2.10, 150.00, 2.10, 550.00, 1470.00),
(71, '2021-08-31', 1006, 'Venta', NULL, 1041, 2.00, 200.00, 2.00, 400.00, 1200.00),
(72, '2021-08-31', 1007, 'Venta', NULL, 1041, 2.10, 200.00, 2.10, 300.00, 1050.00),
(73, '2021-08-31', 1009, 'Venta', NULL, 1042, 9.10, 30.00, 9.10, 90.00, 1092.00),
(74, '2021-08-31', 1010, 'Venta', NULL, 1042, 9.20, 20.00, 9.20, 80.00, 920.00),
(75, '2021-08-31', 1011, 'Venta', NULL, 1042, 9.30, 20.00, 9.30, 160.00, 1674.00),
(76, '2021-08-31', 1013, 'Venta', NULL, 1043, 16.30, 15.00, 16.30, 10.00, 407.50),
(77, '2021-08-31', 1017, 'Venta', NULL, 1044, 7.40, 7.00, 7.40, 16.00, 170.20),
(78, '2021-08-31', 1015, 'Venta', NULL, 1044, 16.50, 10.00, 16.50, 30.00, 660.00),
(79, '2021-08-31', 1000, 'Venta', NULL, 1044, 17.00, 5.00, 17.00, 45.00, 850.00),
(80, '2021-08-31', 1003, 'Venta', NULL, 1044, 17.60, 5.00, 17.60, 70.00, 1320.00),
(81, '2021-08-31', 1006, 'Venta', NULL, 1045, 2.00, 300.00, 2.00, 0.00, 600.00),
(82, '2021-08-31', 1004, 'Venta', NULL, 1045, 1.80, 250.00, 1.80, 150.00, 720.00),
(83, '2021-08-31', 1000, 'Venta', NULL, 1046, 17.00, 20.00, 17.00, 10.00, 510.00),
(84, '2021-08-31', 1003, 'Venta', NULL, 1046, 17.60, 15.00, 17.60, 45.00, 1056.00),
(85, '2021-08-31', 1006, 'Venta', NULL, 1046, 2.00, 100.00, 2.00, 100.00, 400.00),
(86, '2021-08-31', 1016, 'Venta', NULL, 1047, 7.20, 5.00, 7.20, 5.00, 72.00),
(87, '2021-08-31', 1017, 'Venta', NULL, 1048, 7.40, 8.00, 7.40, 7.00, 111.00),
(88, '2021-09-08', 1000, 'Venta', NULL, 1049, 17.00, 2.00, 17.00, 26.00, 476.00);

-- --------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `producto`, `ubicacion`, `stock`, `stock_minimo`, `precio_compra`, `precio_venta`, `foto`, `vence`, `medida_id`, `estado`, `categoria_id`, `subcategoria_id`) VALUES
(1000, 'CEMENTO PACASMAYO TICOEXTRAF', 'zona A, pasillo 1, nivel 1', 28, 10, 17.00, 22.70, 'cemento-pacasmayo-antisalitre-tipo-ms.jpg', 'Si', 1, 'Habilitado', 1, 1),
(1001, 'CEMENTO PACASMAYO MS ANTISALIT', 'zona A, pasillo 1, nivel 2', 70, 10, 17.20, 22.90, 'cemento-pacasmayo-extrafuerte-tipo-ico.jpg', 'Si', 1, 'Habilitado', 1, 1),
(1002, 'CEMENTO PACASMAYO PORTLAND TIPO V', 'zona A, pasillo 1, nivel 3', 70, 10, 17.40, 23.20, 'cemento-pacasmayo-portland-tipo-v.jpg', 'Si', 1, 'Habilitado', 1, 1),
(1003, 'CEMENTO PACASMAYO TIPO I', 'zona A, pasillo 1, nivel 4', 60, 10, 17.60, 23.50, 'cemento-pacasmayo-tipo-i.jpg', 'Si', 1, 'Habilitado', 1, 1),
(1004, 'Ladrillo Para Techo 15x30x30', 'Almacén 2, zona L', 400, 10, 1.80, 2.40, 'Ladrillo-Para-Techo-15x30x30.jpg', 'No', 1, 'Habilitado', 1, 4),
(1005, 'Ladrillo Pandereta Rayada', 'Almacén 2, zona L1', 600, 10, 1.90, 2.50, 'Ladrillo-Pandereta-Rayada.jpg', 'No', 1, 'Habilitado', 1, 4),
(1006, 'Ladrillo King Kong 18h 24x12x9', 'Almacén 2, zona L2', 200, 10, 2.00, 2.70, 'Ladrillo-King-Kong-18h-24x12x9.jpg', 'No', 1, 'Habilitado', 1, 4),
(1007, 'Ladrillo Techo 08x30x30', 'Almacén 2, zona L3', 500, 10, 2.10, 2.80, 'Ladrillo-Techo-08x30x30.jpg', 'No', 1, 'Habilitado', 1, 4),
(1008, 'P60x60 Porcelanato Español Olimpia Blanco', 'zona B, pasillo 1, nivel 1', 130, 10, 9.00, 12.00, 'P60x60-Porcelanato-Español-Olimpia-Blanco.jpg', 'No', 1, 'Habilitado', 2, 2),
(1009, 'P60x60 Porcelanato Vitrif. Madera Shg-66a1101q', 'zona B, pasillo 1, nivel 2', 120, 10, 9.10, 12.10, 'P60x60-Porcelanato-Vitrif-Madera Shg-66a1101q.jpg', 'No', 1, 'Habilitado', 2, 2),
(1010, 'P60x60 Porc. Vitrif. Agatha Geo Nogal Fstb2s006', 'zona B, pasillo 1, nivel 3', 100, 10, 9.20, 12.30, 'P60x60-Porc-Vitrif-Agatha-Geo-Nogal-Fstb2s006.jpg', 'No', 1, 'Habilitado', 2, 2),
(1011, 'P60x60 Porc. Vitrif. Agatha Caramel Fstb13h230', 'zona B, pasillo 1, nivel 4', 180, 10, 9.30, 12.40, 'P60x60-Porc-Vitrif-Agatha-Caramel-Fstb13h230.jpg', 'No', 1, 'Habilitado', 2, 2),
(1012, 'Pintura Latex Satinado Violeta Africana', 'zona B, pasillo 2, nivel 1', 20, 10, 16.20, 21.60, 'Pintura-Latex-Satinado-Violeta-Africana.jpg', 'Si', 1, 'Habilitado', 9, 11),
(1013, 'Pintura Latex Satinado Violeta Activa', 'zona B, pasillo 2, nivel 2', 25, 10, 16.30, 21.70, 'Pintura-Latex-Satinado-Violeta-Activa.jpg', 'Si', 1, 'Habilitado', 9, 11),
(1014, 'Pintura Latex Satinado Turqueza', 'zona B, pasillo 2, nivel 3', 20, 10, 16.40, 21.90, 'Pintura-Latex-Satinado-Turqueza.jpg', 'Si', 1, 'Habilitado', 9, 11),
(1015, 'Pintura Latex Satinado Sunset Gl', 'zona B, pasillo 2, nivel 4', 40, 10, 16.50, 22.00, 'Pintura-Latex-Satinado-Sunset-Gl.jpg', 'Si', 1, 'Habilitado', 9, 11),
(1016, 'Foco Globo Led E27 – 18w Luz Blanca', 'zona B, pasillo 3, nivel 1', 10, 10, 7.20, 9.60, 'Foco-Globo-Led-E27–18w-Luz-Blanca.jpg', 'No', 1, 'Habilitado', 10, 12),
(1017, 'Foco Led 8.5w E27 Luz Calida', 'zona B, pasillo 3, nivel 2', 15, 10, 7.40, 9.90, 'Foco-Led-8.5w-E27-Luz-Calida.jpg', 'No', 1, 'Habilitado', 10, 12);

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
(1, 'SUPPLIER S.A', 2, '5383558485', 'Calle Piérola,4325,Of. 3043', 'Jorge Calle Perez', '976226442', 'jcalle@gmail.com'),
(2, 'SUPPLIER ABC S.A', 2, '5274558225', 'Calle Libertad,1131,Of. 2013', 'Pedro Perez Gonzales', '976226442', 'pperez@gmail.com'),
(3, 'SUPPLIER DEF S.A', 2, '5480551475', 'Calle Ambiente,2072,Of. 4023', 'Gonzalo Carranza Lopez', '976226442', 'gcarranza@gmail.com'),
(4, 'SUPPLIER GHI S.A', 2, '5581552465', 'Calle San Juan,3183,Of. 6033', 'Hernán Rodas Rodriguez', '976226442', 'hrodas@gmail.com'),
(5, 'SUPPLIER JKL S.A', 2, '5682553455', 'Calle Arequipa,1294,Of. 7043', 'Ernesto Soto Román', '976226442', 'esoto@gmail.com');

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
('UvEHyElP0nJN6jqGlrAFGsy41n4Sy8TX8pLZJoDH', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidGlBWGZoSjdnaHJRdkpKd0RhMGdGb1RaV0ZtdTQ3MWx0SlVuS0M0USI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1631219368);

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
  `estado` enum('Habilitado','Deshabilitado') NOT NULL DEFAULT 'Habilitado',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rol_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `profile_photo_path`, `estado`, `created_at`, `updated_at`, `rol_id`) VALUES
(3, 'Waldir Sanchez', 'waldirc925@gmail.com', '$2y$10$DC1teJyeeLIbyQoqDkcYcOpdknNspwYl.s1vFtSB0OukekMtIK9sW', NULL, 'Habilitado', '2021-06-27 21:21:17', '2021-07-04 04:02:01', 1),
(6, 'Carlos Sanchez', 'waldir@gmail.com', '$2y$10$SZoE37e1rXHP6dPZhyp55Ob6opueR.tKoHDKNLrLw6OiLe7svNEqq', NULL, 'Habilitado', '2021-09-08 14:34:41', '2021-09-08 14:34:41', 2),
(7, 'Jhon Cruzado', 'jhon@gmail.com', '$2y$10$u/Rw62bL0zvRcHW.9lDNoeaqd8Y8eG.Uj4qPychLQiw83OSldMSk.', NULL, 'Habilitado', '2021-09-09 20:26:04', '2021-09-09 20:27:20', 3);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id_venta`, `cliente_id`, `subtotal`, `igv`, `total`, `fecha`) VALUES
(1000, 1, 93.07, 20.43, 113.50, '2021-06-01 10:05:59'),
(1001, 2, 130.30, 28.60, 158.90, '2021-06-01 10:11:19'),
(1002, 3, 481.34, 105.66, 587.00, '2021-06-01 10:12:28'),
(1003, 4, 39.36, 8.64, 48.00, '2021-06-01 10:13:17'),
(1004, 5, 32.47, 7.13, 39.60, '2021-06-02 10:13:43'),
(1005, 1, 88.56, 19.44, 108.00, '2021-06-02 10:14:15'),
(1006, 2, 177.94, 39.06, 217.00, '2021-06-02 10:14:44'),
(1007, 3, 215.50, 47.30, 262.80, '2021-06-02 10:15:27'),
(1008, 5, 293.56, 64.44, 358.00, '2021-06-03 10:16:37'),
(1009, 4, 39.36, 8.64, 48.00, '2021-06-03 10:17:44'),
(1010, 2, 55.10, 12.10, 67.20, '2021-06-03 10:18:12'),
(1011, 4, 504.30, 110.70, 615.00, '2021-06-04 10:21:01'),
(1012, 1, 23.62, 5.18, 28.80, '2021-06-04 10:21:44'),
(1013, 3, 177.12, 38.88, 216.00, '2021-06-04 10:22:45'),
(1014, 5, 143.66, 31.54, 175.20, '2021-06-04 10:23:17'),
(1015, 2, 508.40, 111.60, 620.00, '2021-06-04 10:25:02'),
(1016, 1, 98.40, 21.60, 120.00, '2021-06-05 10:25:34'),
(1017, 2, 198.44, 43.56, 242.00, '2021-06-05 10:26:22'),
(1018, 3, 302.58, 66.42, 369.00, '2021-06-05 10:26:50'),
(1019, 4, 88.56, 19.44, 108.00, '2021-06-08 10:27:21'),
(1020, 5, 89.79, 19.71, 109.50, '2021-06-08 10:27:51'),
(1021, 1, 244.03, 53.57, 297.60, '2021-06-08 10:30:41'),
(1022, 2, 98.40, 21.60, 120.00, '2021-06-09 10:31:17'),
(1023, 3, 295.20, 64.80, 360.00, '2021-07-01 10:32:31'),
(1024, 4, 195.57, 42.93, 238.50, '2021-07-01 10:33:27'),
(1025, 1, 93.07, 20.43, 113.50, '2021-07-01 10:46:34'),
(1026, 2, 190.24, 41.76, 232.00, '2021-07-02 10:47:03'),
(1027, 3, 98.40, 21.60, 120.00, '2021-07-02 10:47:33'),
(1028, 4, 98.40, 21.60, 120.00, '2021-07-02 10:47:59'),
(1029, 5, 102.50, 22.50, 125.00, '2021-07-02 10:48:25'),
(1030, 3, 93.07, 20.43, 113.50, '2021-07-03 10:55:25'),
(1031, 4, 205.00, 45.00, 250.00, '2021-07-03 10:55:53'),
(1032, 5, 196.80, 43.20, 240.00, '2021-07-03 10:56:27'),
(1033, 1, 178.35, 39.15, 217.50, '2021-07-05 10:57:55'),
(1034, 2, 88.07, 19.33, 107.40, '2021-07-05 10:58:32'),
(1035, 4, 88.56, 19.44, 108.00, '2021-07-05 10:59:57'),
(1036, 5, 99.22, 21.78, 121.00, '2021-07-05 11:00:31'),
(1037, 1, 948.74, 208.26, 1157.00, '2021-07-06 11:25:06'),
(1038, 2, 664.20, 145.80, 810.00, '2021-07-06 11:26:24'),
(1039, 3, 411.64, 90.36, 502.00, '2021-07-06 11:27:45'),
(1040, 4, 344.40, 75.60, 420.00, '2021-07-06 11:28:10'),
(1041, 5, 902.00, 198.00, 1100.00, '2021-08-31 11:30:41'),
(1042, 1, 702.74, 154.26, 857.00, '2021-08-31 11:32:16'),
(1043, 2, 266.91, 58.59, 325.50, '2021-08-31 11:33:07'),
(1044, 3, 426.65, 93.65, 520.30, '2021-08-31 11:34:50'),
(1045, 1, 1156.20, 253.80, 1410.00, '2021-08-31 11:36:12'),
(1046, 4, 882.73, 193.77, 1076.50, '2021-08-31 11:37:21'),
(1047, 2, 39.36, 8.64, 48.00, '2021-08-31 11:38:09'),
(1048, 3, 64.94, 14.26, 79.20, '2021-08-31 11:38:59'),
(1049, 1, 37.23, 8.17, 45.40, '2021-09-08 11:13:55');

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
  ADD KEY `producto_id` (`producto_id`),
  ADD KEY `venta_id` (`venta_id`);

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
  ADD KEY `cliente_id` (`cliente_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `id_compra` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1005;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id_detalle` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id_detalle` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `kardex`
--
ALTER TABLE `kardex`
  MODIFY `id_kardex` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1018;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id_venta` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1050;

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
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
