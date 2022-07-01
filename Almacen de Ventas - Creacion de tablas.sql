drop database almacen_ventas;
create database almacen_ventas;
use almacen_ventas;

create table almacenes(
	almacen_id int not null primary key auto_increment,
    almacen varchar(100)
);

create table tipo_programacion(
	tp_id int not null primary key auto_increment,
    tipo varchar(100)
);

create table cargos(
	cargo_id int not null primary key auto_increment,
    cargo varchar(50)
);

create table categoria_telefono(
	ct_id int not null primary key auto_increment,
    categoria varchar(50)
);

create table telefonos(
	telefono_id int not null primary key auto_increment,
    telefono char(9) unique,
    ct_id int,
    foreign key (ct_id) references categoria_telefono(ct_id)
);

create table if not exists usuarios(
	cod_empleado char(25) not null primary key,
	contrasenia char(20) not null,
	nombre_empleado varchar(70) not null,
	apellido_empleado varchar(70) not null,
	dni_empleado char(8) unique,
	cargo_id int,
	foreign key (cargo_id) references cargos(cargo_id),
	telefono_id int,
	foreign key (telefono_id) references telefonos(telefono_id)
);

create table solicitud_herramientas(
	sh_id  int  primary key auto_increment,
    herramientas text
);


create table if not exists categoria_productos(
	id_catProducto int not null primary key auto_increment,
	nombre_cat varchar(50)
);

create table if not exists productos(
	codigo_producto char(20) not null primary key,
	nombre varchar(100),
	stock int,
	precio double default 0,
	descripcion text,
	id_catProducto int,
	foreign key (id_catProducto) references categoria_productos(id_catProducto)
);

create table programacion_actividades(
	pa_id int not null primary key auto_increment,
    fecha datetime,
    codigo_producto char(20),
    foreign key (codigo_producto) references productos(codigo_producto),
    cantidad_productos int default 0,
    tipo_actividad int,
    foreign key (tipo_actividad) references tipo_programacion(tp_id),
    encargado char(25),
    foreign key (encargado) references usuarios(cod_empleado),
    herramientas_proporcionadas int,
    foreign key (herramientas_proporcionadas) references solicitud_herramientas(sh_id)
);

create table if not exists entradas_productos(
	id_entrada int  primary key auto_increment,
	fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	cantidad int,
	cod_empleado char(25), 
	foreign key (cod_empleado) references usuarios(cod_empleado),
	codigo_producto char(20),
	foreign key(codigo_producto) references productos(codigo_producto),
	actividad int,
    foreign key(actividad) references programacion_actividades(pa_id),
    almacen_lugar int,
    foreign key(almacen_lugar) references almacenes(almacen_id)
);

create table if not exists informe_final_entrada(
	id_informeE int  primary key auto_increment,
	fecha_informe TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	cod_empleado char(25), 
	foreign key (cod_empleado) references usuarios(cod_empleado),
	id_entrada int, 
	foreign key (id_entrada) references entradas_productos(id_entrada),
	informe text
);

create table if not exists salida_productos(
	id_salida int  primary key auto_increment,
	fecha_salida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	cod_empleado char(25),
	foreign key (cod_empleado) references usuarios(cod_empleado),
	cantidad int,
	codigo_producto char(20),
	foreign key(codigo_producto) references productos(codigo_producto),
	actividad int,
    foreign key(actividad) references programacion_actividades(pa_id),
    almacen_lugar int,
    foreign key(almacen_lugar) references almacenes(almacen_id)
);

create table if not exists informe_final_salida(
	id_informeS int  primary key auto_increment,
	fecha_informe TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	cod_empleado char(25), 
	foreign key (cod_empleado) references usuarios(cod_empleado),
	id_salida int, 
	foreign key (id_salida) references salida_productos(id_salida),
	informe text
);

create table solicitud_produccion(
	soliPro_id int  primary key auto_increment,
    cod_empleado char(25),
	foreign key (cod_empleado) references usuarios(cod_empleado),
    cantidad_solicitada int,
    codigo_producto char(20),
	foreign key(codigo_producto) references productos(codigo_producto)
);

create table if not exists ChatMensajes (
	id_chatMensajes int not null primary key auto_increment,
	mensajeTexto longtext,
	fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	cod_empleado char(25),
	foreign key (cod_empleado) references usuarios (cod_empleado)
);