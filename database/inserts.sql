use sistemav1;

insert into empresa(nombre,ruc,telefono,direccion)
values('Distribuciones Olano S.A.C.','20103365628','987654332','Exequiel Gonzales Caceda 1151, Chepén 13871');

insert into rol(rol)
values('Administrador'),('Vendedor'),('Tesorero');

insert into usuario(nombre,email,password,created_at,updated_at,rol_id)
values
('Waldir Sanchez','waldirc925@gmail.com','$2y$10$DC1teJyeeLIbyQoqDkcYcOpdknNspwYl.s1vFtSB0OukekMtIK9sW','2021-06-27 16:21:17','2021-07-03 23:02:01', 1),
('Jhon Cruzado', 'jhonpaulcruzadodelacruz@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2021-06-27 16:21:17','2021-07-03 23:02:01', 1);

/* drop table detalle_venta;
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
values('Juan Robles Gonzales', 1, '27678960','Av. Las Anemonas 1232 San Juan de Lurigancho','986556444','jrobles@gmail.com');

insert into proveedor(raz_social,documento,nrodocumento,direccion,contacto,telefono,email)
values('SUPPLIER S.A', 2, '5383558485','Calle Piérola,4325,Of. 3043','Jorge Carranza Perez','976226442','jcarranza@gmail.com');

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
('CEMENTO PACASMAYO TIPO I',0,10,0,25.50,'Si',1,1,4,'cemento-pacasmayo-tipo-i.jpg','zona A, pasillo 1, nivel 4'),
('Ladrillo Para Techo 15x30x30',0,10,0,28.50,'No',1,1,4,'Ladrillo-Para-Techo-15x30x30.jpg','Almacén 2, zona L'),
('Ladrillo Pandereta Rayada',0,10,0,27.50,'No',1,1,4,'Ladrillo-Pandereta-Rayada.jpg','Almacén 2, zona L1'),
('Ladrillo King Kong 18h 24x12x9',0,10,0,26.50,'No',1,1,4,'Ladrillo-King-Kong-18h-24x12x9.jpg','Almacén 2, zona L2'),
('Ladrillo Techo 08x30x30',0,10,0,25.50,'No',1,1,1,'Ladrillo-Techo-08x30x30.jpg','Almacén 2, zona L3'),
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












