drop database if exists sistemav1;
create database sistemav1;
use sistemav1;

create table empresa(
id int auto_increment primary key not null,
nombre varchar(40) not null,
ruc char(11) not null,
telefono char(15) not null,
direccion varchar(80) not null
);

create table sessions(
id varchar(191) primary key not null,
user_id bigint unsigned null,
ip_address varchar(45) null,
user_agent text null,
payload text not null,
last_activity int not null
);

create table rol(
id_rol int auto_increment primary key not null,
rol varchar(20));

create table usuario(
id int auto_increment primary key not null,
nombre varchar(191) not null,
email varchar(191) not null,
password varchar(191) not null,
profile_photo_path varchar(100) default null,
created_at timestamp,
updated_at timestamp,
rol_id int not null,
estado enum('Habilitado','Deshabilitado') default 'Habilitado',
foreign key (rol_id) references rol(id_rol));


create table unidad_medida(
id int auto_increment primary key not null,
medida varchar(20) not null);

create table tipo_documento(
id int auto_increment primary key not null,
tipo char(30) not null);



create table categoria(
id_categoria int auto_increment primary key not null,
categoria varchar(40) not null,
estado enum('Habilitado', 'Deshabilitado') default 'Habilitado' not null);

create table subcategoria(
id_subcategoria int auto_increment primary key not null,
subcategoria varchar(40) not null,
categoria_id int not null,
estado enum('Habilitado', 'Deshabilitado') default 'Habilitado' not null,
foreign key(categoria_id) references categoria(id_categoria) 
ON DELETE CASCADE ON UPDATE CASCADE);

create table producto(
id_producto int auto_increment primary key not null,
producto varchar(200) not null,
ubicacion varchar(100) not null,
stock int not null,
stock_minimo int not null,
precio_compra float(12,2) not null,
precio_venta float(12,2) not null,
foto varchar(2048) null,
vence enum('Si', 'No') not null,
medida_id int not null,
estado enum('Habilitado', 'Deshabilitado') default 'Habilitado' not null,
categoria_id int,
subcategoria_id int,
foreign key(medida_id) references unidad_medida(id) 
ON DELETE CASCADE ON UPDATE CASCADE,
foreign key(categoria_id) references categoria(id_categoria) 
ON DELETE CASCADE ON UPDATE CASCADE,
foreign key(subcategoria_id) references subcategoria(id_subcategoria) 
ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE producto AUTO_INCREMENT = 1000;

create table proveedor(
id_proveedor int auto_increment primary key not null,
raz_social varchar(40) not null,
documento int not null,
nrodocumento char(15) not null,
direccion varchar(100) not null,
contacto varchar(80) not null,
telefono char(15) not null,
email varchar(100) null,
foreign key(documento) references tipo_documento(id) 
ON DELETE CASCADE ON UPDATE CASCADE);

create table cliente(
id_cliente bigint auto_increment primary key not null,
nombre varchar(80) not null,
documento int not null,
nrodocumento char(15) not null,
direccion varchar(100) not null,
telefono char(15) not null,
email varchar(80) null,
foreign key(documento) references tipo_documento(id) 
ON DELETE CASCADE ON UPDATE CASCADE);

create table venta(
id_venta bigint auto_increment primary key not null,
cliente_id bigint not null,
subtotal float(12,2) not null,
igv float(12,2) not null,
total float(12,2) not null,
fecha datetime not null,
foreign key(cliente_id) references cliente(id_cliente) 
ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE venta AUTO_INCREMENT = 1000;

create table detalle_venta(
id_detalle bigint auto_increment primary key not null,
venta_id bigint not null,
producto_id int not null,
precio float(8,2) not null,
cantidad float(8,2) not null,
descuento float(8,2) not null,
foreign key(producto_id) references producto(id_producto) 
ON DELETE CASCADE ON UPDATE CASCADE,
foreign key(venta_id) references venta(id_venta) 
ON DELETE CASCADE ON UPDATE CASCADE);

create table compra(
id_compra bigint auto_increment primary key not null,
proveedor_id int not null,
subtotal float(12,2) not null,
igv float(12,2) not null,
total float(12,2) not null,
fecha datetime not null,
foreign key(proveedor_id) references proveedor(id_proveedor) 
ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE compra AUTO_INCREMENT = 1000;

create table detalle_compra(
id_detalle bigint auto_increment primary key not null,
compra_id bigint not null,
producto_id int not null,
precio float(8,2) not null,
cantidad float(8,2) not null,
descuento float(8,2) not null,
foreign key(producto_id) references producto(id_producto) 
ON DELETE CASCADE ON UPDATE CASCADE,
foreign key(compra_id) references compra(id_compra) 
ON DELETE CASCADE ON UPDATE CASCADE);

create table kardex(
id_kardex bigint auto_increment primary key not null,
fecha date not null,
producto_id int not null,
operacion enum('Compra', 'Venta') not null,
descripcion varchar(40) null,
nrodocumento bigint not null,
valor_unitario float(8,2) not null,
cantidad float(8,2) not null,
valor float(8,2) not null,
stock_total float(12,2) not null,
valor_total float(12,2) not null,
foreign key(producto_id) references producto(id_producto) 
ON DELETE CASCADE ON UPDATE CASCADE);




