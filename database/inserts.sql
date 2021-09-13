use SVOlanoSAC;

insert into empresa(nombre,ruc,margen,telefono,direccion)
values('Distribuciones Olano S.A.C.','20103365628',25,'987654332','Exequiel Gonzales Caceda 1151, Chepén 13871');
/*
insert into rol(rol)
values('Administrador'),('Vendedor'),('Contador');
*/
insert into rol(rol)
values('Jefe de Línea'),('Encargado de almacén'),('Vendedor');

INSERT INTO usuario (id, nombre, email, password, profile_photo_path, created_at, updated_at, rol_id, estado) VALUES
(1, 'Waldir Sanchez', 'waldir@olano.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2021-06-27 21:21:17', '2021-07-04 04:02:01', 3, 'Habilitado'),
(2, 'Jhon Cruzado', 'jhon@olano.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2021-06-27 21:21:17', '2021-07-04 04:02:01', 1, 'Habilitado'),
(3, 'Isac Miñano', 'isac@olano.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2021-06-27 21:21:17', '2021-07-04 04:02:01', 1, 'Habilitado'),
(4, 'Betsi Mendoza', 'betsi@olano.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2021-09-09 21:45:26', '2021-09-09 21:45:26', 3, 'Habilitado'),
(5, 'Cesar Perez', 'cesar@olano.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '2021-09-09 22:29:37', '2021-09-09 22:29:37', 3, 'Habilitado');

/*
drop table detalle_venta;
drop table venta;
drop table detalle_compra;
drop table compra;
drop table kardex;
drop table producto;
drop table subcategoria;
drop table categoria;
drop table cliente;
drop table proveedor;
drop table unidad_medida;
drop table tipo_documento;
*/

insert into tipo_documento(tipo)
values('DNI'),('RUC'),('CARNÉ EXTRANJERÍA');

insert into unidad_medida(medida)
values('Unidad'),('Galon'),('Pliego'),('Rollo'),('Metro'),('Kilogramo'),('Sobre');

/***********/

insert into cliente(nombre,documento,nrodocumento,direccion,telefono,email)
values
/*('Cliente General', 1, '11100111','Default','000000000','default@gmail.com'),*/
('Juan Robles Gonzales', 1, '27678960','Av. Las Anemonas 1232 San Juan de Lurigancho','986556444','jrobles@gmail.com'),
('Sidney M. Chandler', 1, '20172950','Carretera Cádiz-Málaga, 36','986556444','sidneymchandler@gmail.com'),
('Rafael G. Madden', 1, '24608140','Rúa do Paseo, 59','952156147','rafaelgmadden@gmail.com'),
('Daren B. Gould', 1, '25618250','Avenida Cervantes, 86','986556444','darenbgould@gmail.com'),
('James P. Morgan', 1, '26628360','Rua da Rapina, 74','986556444','jamespmorgan@gmail.com');

insert into proveedor(raz_social,documento,nrodocumento,direccion,contacto,telefono,email)
values
('SUPPLIER S.A', 2, '5383558485','Calle Piérola,4325,Of. 3043','Jorge Calle Perez','976226442','jcalle@gmail.com'),
('SUPPLIER ABC S.A', 2, '5274558225','Calle Libertad,1131,Of. 2013','Pedro Perez Gonzales','976226442','pperez@gmail.com'),
('SUPPLIER DEF S.A', 2, '5480551475','Calle Ambiente,2072,Of. 4023','Gonzalo Carranza Lopez','976226442','gcarranza@gmail.com'),
('SUPPLIER GHI S.A', 2, '5581552465','Calle San Juan,3183,Of. 6033','Hernán Rodas Rodriguez','976226442','hrodas@gmail.com'),
('SUPPLIER JKL S.A', 2, '5682553455','Calle Arequipa,1294,Of. 7043','Ernesto Soto Román','976226442','esoto@gmail.com');

insert into categoria(categoria)
values
('Construcción'),('Pisos y Cerámicos'),('Tuberías y accesorios'),('Ferretería general'),('Galvanizados'),('Grifería'),
('Herramientas eléctricas'),('Limpieza y aseo'),('Pinturas y solvente'),('Iluminación');

insert into subcategoria(subcategoria, categoria_id)
values('Cemento',1),('Porcelanato',2),('Fierro de construcción',1),('Ladrillo',1),('Yeso',1),
('Alicates',3),('Cerraduras',3),('Cable',3),('Clavos',3),('Destornillador',3),('Latex', 9),('Focos', 10);

insert into producto(producto,stock,stock_minimo,precio_compra,precio_venta,vence,medida_id,categoria_id,subcategoria_id,foto,ubicacion)
values
('CEMENTO PACASMAYO TICOEXTRAF',0,10,0,28.50,'Si',1,1,1,'cemento-pacasmayo-antisalitre-tipo-ms.jpg','zona A, pasillo 1, nivel 1'),
('CEMENTO PACASMAYO MS ANTISALIT',0,10,0,27.50,'Si',1,1,1,'cemento-pacasmayo-extrafuerte-tipo-ico.jpg', 'zona A, pasillo 1, nivel 2'),
('CEMENTO PACASMAYO PORTLAND TIPO V',0,10,0,26.50,'Si',1,1,1,'cemento-pacasmayo-portland-tipo-v.jpg','zona A, pasillo 1, nivel 3'),
('CEMENTO PACASMAYO TIPO I',0,10,0,25.50,'Si',1,1,1,'cemento-pacasmayo-tipo-i.jpg','zona A, pasillo 1, nivel 4'),
('Ladrillo Para Techo 15x30x30',0,10,0,28.50,'No',1,1,4,'Ladrillo-Para-Techo-15x30x30.jpg','Almacén 2, zona L'),
('Ladrillo Pandereta Rayada',0,10,0,27.50,'No',1,1,4,'Ladrillo-Pandereta-Rayada.jpg','Almacén 2, zona L1'),
('Ladrillo King Kong 18h 24x12x9',0,10,0,26.50,'No',1,1,4,'Ladrillo-King-Kong-18h-24x12x9.jpg','Almacén 2, zona L2'),
('Ladrillo Techo 08x30x30',0,10,0,25.50,'No',1,1,4,'Ladrillo-Techo-08x30x30.jpg','Almacén 2, zona L3'),
('P60x60 Porcelanato Español Olimpia Blanco',0,10,0,15,'No',1,2,2,'P60x60-Porcelanato-Español-Olimpia-Blanco.jpg','zona B, pasillo 1, nivel 1'),
('P60x60 Porcelanato Vitrif. Madera Shg-66a1101q',0,10,0,15,'No',1,2,2,'P60x60-Porcelanato-Vitrif-Madera Shg-66a1101q.jpg','zona B, pasillo 1, nivel 2'),
('P60x60 Porc. Vitrif. Agatha Geo Nogal Fstb2s006',0,10,0,15,'No',1,2,2,'P60x60-Porc-Vitrif-Agatha-Geo-Nogal-Fstb2s006.jpg','zona B, pasillo 1, nivel 3'),
('P60x60 Porc. Vitrif. Agatha Caramel Fstb13h230',0,10,0,15,'No',1,2,2,'P60x60-Porc-Vitrif-Agatha-Caramel-Fstb13h230.jpg','zona B, pasillo 1, nivel 4'),
('Pintura Latex Satinado Violeta Africana',0,10,0,28.50,'Si',1,9,11,'Pintura-Latex-Satinado-Violeta-Africana.jpg','zona B, pasillo 2, nivel 1'),
('Pintura Latex Satinado Violeta Activa',0,10,0,27.50,'Si',1,9,11,'Pintura-Latex-Satinado-Violeta-Activa.jpg','zona B, pasillo 2, nivel 2'),
('Pintura Latex Satinado Turqueza',0,10,0,26.50,'Si',1,9,11,'Pintura-Latex-Satinado-Turqueza.jpg','zona B, pasillo 2, nivel 3'),
('Pintura Latex Satinado Sunset Gl',0,10,0,25.50,'Si',1,9,11,'Pintura-Latex-Satinado-Sunset-Gl.jpg','zona B, pasillo 2, nivel 4'),
('Foco Globo Led E27 – 18w Luz Blanca',0,10,0,26.50,'No',1,10,12,'Foco-Globo-Led-E27–18w-Luz-Blanca.jpg','zona B, pasillo 3, nivel 1'),
('Foco Led 8.5w E27 Luz Calida',0,10,0,25.50,'No',1,10,12,'Foco-Led-8.5w-E27-Luz-Calida.jpg','zona B, pasillo 3, nivel 2');

INSERT INTO `compra` (`id_compra`, `proveedor_id`, `subtotal`, `igv`, `total`, `fecha`) VALUES
(1000, 1, 5674.40, 1245.60, 6920.00, '2021-01-02 09:19:33'),
(1001, 2, 6396.00, 1404.00, 7800.00, '2021-01-02 09:24:08'),
(1002, 3, 6002.40, 1317.60, 7320.00, '2021-01-02 09:28:09'),
(1003, 4, 2681.40, 588.60, 3270.00, '2021-01-02 09:31:41'),
(1004, 5, 478.88, 105.12, 584.00, '2021-01-02 09:32:59');

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


INSERT INTO caja (id_caja, descripcion, tipoMovimiento, monto, saldo, fecha, estado, estadoMovimiento) VALUES
(1, 'Apertura de Caja', 1, 5000.00, 5000.00, '2021-09-11 00:03:22', 1, 1),
(2, 'Deposito Juan', 1, 500.00, 5500.00, '2021-09-11 00:12:17', 1, 1),
(3, 'Pagar Internet', 0, -100.00, 5400.00, '2021-09-11 00:12:30', 1, 1);
