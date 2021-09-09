use sistemav1;

insert into empresa(nombre,ruc,telefono,direccion)
values('Distribuciones Olano S.A.C.','20103365628','987654332','Exequiel Gonzales Caceda 1151, Chepén 13871');

insert into rol(rol)
values('Administrador'),('Vendedor'),('Tesorero');

insert into usuario(nombre,email,password,created_at,updated_at,rol_id)
values
('Waldir Sanchez','waldirc925@gmail.com','$2y$10$DC1teJyeeLIbyQoqDkcYcOpdknNspwYl.s1vFtSB0OukekMtIK9sW','2021-06-27 16:21:17','2021-07-03 23:02:01', 1),
('Jhon Cruzado', 'jhonpaulcruzadodelacruz@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2021-06-27 16:21:17','2021-07-03 23:02:01', 1);

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

