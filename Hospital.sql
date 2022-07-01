drop database hospital;
create database if not exists hospital default charset utf8 collate utf8_general_ci;
use  hospital;

create table if not exists  departamentos(
id_Dep int not null primary key auto_increment,
nomb_Dep varchar(50) 
);

create table if not exists  provincias(
id_Prov int not null primary key auto_increment,
nomb_Prov varchar(50),
id_Dep int,
 foreign key(id_Dep) references departamentos(id_Dep)
);

create table if not exists sub_sector(
	sub_id int not null primary key auto_increment,
    sub_sector varchar(100) default ''
);

create table if not exists  distritos(
id_Dist int not null primary key auto_increment,
nomb_Dist varchar(50),
id_Prov int,
foreign key(id_Prov) references provincias(id_Prov),
sub_id int,
foreign key(sub_id) references sub_sector(sub_id)
);

create table if not exists  IPRESS(
cod_Ipress int not null primary key auto_increment,
correo_Ipress varchar(100),
razon_social varchar(300),
RENIPRESS char(20) unique,
id_Dist int,
foreign key(id_Dist) references distritos(id_Dist)
);

create table if not exists  expedientes(
num_exped char(20) not null primary key,
estado varchar(150),
oficina varchar(150),
tipo varchar(150),
glosa varchar(150) default "archivo completo",
fecha datetime
);

create table if not exists  supervisores(
cod_sup int not null primary key auto_increment,
nombre varchar(100),
apellido varchar(100)
);

create table if not exists  instrumentos(
cod_instr int not null primary key auto_increment,
componente varchar(150),
verificador varchar(150),
descripcion text,
instrumentos varchar(150),
valorizacion varchar(150),
observaciones text
);

create table if not exists  instrumentos_supervision(
instrumentosAA int not null primary key auto_increment,
hora_Ini time,
hora_Fin time,
fecha date,
estado varchar(150),
cod_instru int, 
foreign key(cod_instru) references instrumentos(cod_instr)
);

create table if not exists planificaciones_supervision(
cod_plan int not null primary key auto_increment,
programacion varchar(250),
etapa varchar(150),
hora_vis time,
estado_plan varchar(150),
fecha_ini date,
fecha_fin date,
cod_ipress int,
foreign key(cod_ipress) references IPRESS(cod_Ipress),
num_expe char(20),
foreign key(num_expe) references expedientes(num_exped),
cod_super int,
foreign key(cod_super) references supervisores(cod_sup),
instrumentosAA int,
foreign key(instrumentosAA) references instrumentos_supervision(instrumentosAA)
);

create table if not exists  actas_supervisicion(
cod_plan int,
foreign key(cod_plan) references planificaciones_supervision(cod_plan),
acta_sup_pdf longtext
);

-- !supervisores
insert into supervisores(nombre,apellido) 
values("Gustavo","de las torres"),
("Jair","Mamani"),
("Bryan","Guadalupe"),
("Jose","Gutierrez"),
("Julio","Padilla"),
("Carmen","Rosales"),
("Luis","Pariona"),
("Lucho","Balverde"),
("Ana","Rojas"),
("Lucia","Magallanes"),
("Rodrigo","Liza"),
("Mariano","Villanueva"),
("Andres","Martinez"),
("Lupita","Concha Fuerte"),
("Nick","Segarra"),
("Ellis","Arturion"),
("Gustavo","Amarillo"),
("Alberto","Quispe"),
("Julian","Estivaldo"),
("Juan","Rodriguez"),
("Maria","Vargas"),
("Cristiano","Fuentes De la Cruz"),
("Almater","Sanquijano"),
("Rodrigo","Ogosi"),
("Junior","Silva"),
("Ester","Calle"),
("Mariano","Franco Casas"),
("Seis","Quispe"),
("Rossio","Fuentes"),
("Rosa","De Guadalupe");

-- ?departamento
insert into departamentos(nomb_Dep)
values("Lima"),
("Callao"),
("Huánuco"),
("Ucayali"),
("Ayacucho"),
("Cajamarca"),
("Ancash"),
("Cusco"),
("Huancavelica"),
("Apurimac"),
("Ica"),
("Junin"),
("La Libertad"),
("Lambayeque"),
("Amazonas"),
("Loreto"),
("Madre de Dios"),
("Moquegua"),
("Pasco"),
("Piura"),
("Puno"),
("San Martín"),
("Tacna"),
("Tumbes"),
("Arequipa");

-- //provincia
insert into provincias(id_Prov,nomb_Prov,id_Dep) values
(1, "Lima", 1),
(2, "Leoncio Prado", 1),
(3, "Callao", 2),
(4, "Coronel Portillo", 4),
(5, "Huanuco", 3),
(6, "Canta", 1),
(7, "Atalaya", 4),
(8, "Arequipa", 25),
(9, "Yauyos", 1),
(10, "Cañete", 1),
(11, "Marañon", 3),
(12, "Huaycabamba", 3),
(13, "Huaura", 3),
(14, "Humalies", 3),
(15, "Dos de Mayo", 3),
(16, "Yarowilca", 3),
(17, "Lauricocha", 3),
(18, "Huaral", 1),
(19, "Puerto Inca", 3),
(20, "Pachitea", 3),
(21, "Anbo", 3),
(22, "Padre Abad", 4),
(23, "Oyon", 1),
(24, "Barranca", 1),
(25, "Purus", 4),
(26, "Cajatambo", 1),
(27, "Huanta", 5),
(28, "La Mar", 5),
(29, "Huamanga", 5),
(30, "Victor", 5),
(31, "Huanca Santos", 5),
(32, "Lucanas", 5),
(33, "Parinacochas", 5),
(34, "Victor Fajardo", 5),
(35, "Vilcas Huaman", 5),
(36, "Sucre", 5),
(37, "Paucar del Sara Sara", 5);

-- sub sector
insert into sub_sector(sub_sector) 
values('Lima Centro'),
('Lima Norte'),
('Lima Este'),
('Lima Sur'),
('');

select * from provincias;

-- todo distrito
insert into distritos(nomb_Dist,id_Prov,sub_id) 
values("Jesus Maria",1,1),
("Santa Anita",1,3),
("Lima",1,1),
("Santiago de Surco",1,4),
("San Miguel",1,1),
("Pueblo Libre",1,1),
("San Isidro",1,1),
("Comas",1,2),
("Ate",1,3),
("Lince",1,1),
("La Molina",1,3),
("San Juan Lurigancho",1,1),
("Chorillos",1,1),
("Idenpendencia",1,2),
("Miraflores",1,1),
("Los Olivos",1,2),
("Puente Piedra",1,2),
("San Juan de Miraflores",1,4),
("Magdalena del Mar",1,1),
("San Martin de Porres",1,2),
("Callao",3,5),
("Bella vista",3,5),
("Carmen de la Legua Reinoso",3,5),
("Raymondi",7,5),
("Sepahua",7,5),
("Tahuania",7,5),
("Cayma",8,5),
("Characato",8,5),
("Cerro Colorado",8,5),
("La Joya",8,5),
("Calleria",4,5),
("San Borja",1,5),
("Huanuco",5,5);

-- IPRESS
insert into IPRESS(correo_Ipress,razon_social,RENIPRESS,id_Dist) 
values
('HMPNP@gmail.com','HOSPITAL NACIONAL POLICIA NACIONAL DEL PERU GRAL PNP LUIS N. SAENZ.','13591',1),
('EHICSI@gmail.com','ESSALUD - HOSPITAL IIE CLINICA GERIATRICA SAN ISIDRO LABRADOR','10434',2),
('CMSL@gmail.com','CLINICA MAISON DE SANTE DE LIMA','8281',3),
('CSP@gmail.com','CLINICA SAN PABLO','9988',4),
('CI@gmail.com','Clínica Internacional - Sede Lima','15610',3),
('CSF@gmail.com','CLINICA SAN FELIPE S.A.','9116',1),
('CN@gmail.com','HOSPITAL NAVAL','8266',22),
('HIOMN@gmail.com','HOSPITAL I OCTAVIO MONGRUT MUÑOZ','8564',5),
('HMLAS@gmail.com','HOSPITAL MILITAR LUIS ARIAS SCHEREIBER','17024',1),
('HN2@gmail.com','HOSPITAL NAVAL','82666',22),
('CFEIRL@gmail.com','CLINICA FERNANDEZ E.I.R.L.','13055',31),
('COFEIRL@gmail.com','CENTRO OFTALMOLÓGICO LUSS E.I.R.L.','25645',31),
('CRVYSP@gmail.com','CENTRO RENACER VIDA Y SALUD PUCALLPA','T0000706',31),
('CLAS@gmail.com','CLINICA LAS AMERICAS','14897',31),
('HRDP@gmail.com','HOSPITAL REGIONAL DE PUCALLPA','5576',31),
('CSAP2@gmail.com','CLINICA SANTA ANITA PUCALLPA','16041',31),
('CV78@gmail.com','CLÍNICA VESALIO','9850',32),
('CSB56@gmail.com','CLINICA SAN BORJA','9886',32),
('CSM63@gmail.com','CLINICA STELLA MARIS','10743',6),
('CMDSDE1@gmail.com','CLINICA MAISON DE SANTE DEL ESTE','15118',4),
('CMDSDE7@gmail.com','CLINICA JAVIER PRADO','12633',7),
('CMDSDE156@gmail.com','Hospital I Marino Molina Scippa - EsSalud','27565',8),
('CMDSDE174@gmail.com','CLINICA SAN JUDAS TADEO','11401',5),
('CMDSDE10@gmail.com','UNILABS','T0000717',21),
('CMDSDE101@gmail.com','SERVICIOS MEDICOS VIA MEDICA SAC','T0000714',13),
('CMDSDE102@gmail.com','HOSPITAL VITARTE','5945',9),
('CMDSDE103@gmail.com','NACIONAL DOS DE MAYO','6206',3),
('CMDSDE104@gmail.com','DIRECCIÓN REGIONAL DE SALUD DEL CALLAO','10000048',22),
('CMDSDE107@gmail.com','HOSPITAL SAN JUAN DE LURIGANCHO','5617',12),
('CMDSDE191@gmail.com','CLINICA DE CORTA ESTANCIA ROCA E.I.R.L.','18769',33);
alter table ipress add riesgo varchar(20);
update ipress set riesgo='ALTO RIESGO' where cod_ipress >= 1 && cod_ipress <=10 ;
update ipress set riesgo= 'BAJO RIESGO' where cod_ipress >= 11 && cod_ipress <=16 ;
update ipress set riesgo= 'MEDIANO RIESGO' where cod_ipress >= 17 && cod_ipress <=22 ;
update ipress set riesgo= 'BAJO RIESGO' where cod_ipress >= 23 && cod_ipress <=27 ;
update ipress set riesgo= 'ALTO RIESGO' where cod_ipress >= 28 && cod_ipress <=30 ;
select * from ipress;


-- !instrumentos
insert into instrumentos(componente,verificador,descripcion,instrumentos,valorizacion,observaciones)     
values
("Gestión de la dirección ","V_3455","El IPRESS cumple con realizar las programaciones ","0000676 - MONITOREO COVID-19 AÑO 2021","No conforme ","La IPRESS no cuenta con registro en RENIPRESS "),
("Gestión de medidas protectoras","V_3456","La IPRESS ha considerado para toda actividad de atención directa y atención de soporte","0000676 - MONITOREO COVID-19 AÑO 2021","No aplica","La IPRESS no lleva un registro de la referencia y contrarferencia de los pacientes COVID-19"),
("Gestión de Desinfección y Esterilización","V_3457","La IPRESS,cuenta con registro en RENIPRESS actualizado ante la Superintendencia Nacional de Salud(SU SALUD)","0000675 - INSTRUMENTO DISPOSITIVOS DE DIAGNOSTICO IN VITRO SEGUNDA VERSION","No conforme","La IPRESS no ha considerado para toda actividad de atención directa y atención de soporte"),
("Gestión de Precios y Contratos","V_3458","La IPRESS lleva un registro de la referencia y contrareferencia de los pacientes covid-19","0000616 - Integral Abreviado","No aplica","La IPRESS del primer nivel de atención en salud(PNAS)no articula con el SAMU del MINSA"),
("Gestión de Atención al Usuario","V_3459","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad","0000630 - Supervisión Especial Abreviada Verificación de Cumplimiento de Medida de Seguridad","No aplica","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad"),
("Gestión de la referencia para atención de Emergencia","V_3460","La IPRESS del primer nivel de atención en salud(PNAS) articula con el SAMU del MINSA de las regiones","0000616 - Integral Abreviado","No conforme","No aplica al nivel de atención"),
("Gestion de medidad protectoras","V_3461","La IPRESS cumple con identificar al paciente de acuerdo al seguro de salud y garantiza la entrega de los producto farmaceúticos","0000658 - Informalidad Sanitaria 2020","No aplica","La IPRESS no cuenta con un sistema a que acredite el transporte de material limpio y residuos sólidos contaminados"),
("Gestión de la dirección ","V_3455","El IPRESS cumple con realizar las programaciones ","0000676 - MONITOREO COVID-19 AÑO 2021","No conforme ","La IPRESS no cuenta con registro en RENIPRESS "),
("Gestión de medidas protectoras","V_3456","La IPRESS ha considerado para toda actividad de atención directa y atención de soporte","0000676 - MONITOREO COVID-19 AÑO 2021","No aplica","La IPRESS no cuenta con un sistema a que acredite el transporte de material limpio y residuos sólidos contaminados"),
("Gestión de Atención al Usuario","V_3459","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad","0000658 - Informalidad Sanitaria 2020","No aplica","La IPRESS no cuenta con un sistema a que acredite el transporte de material limpio y residuos sólidos contaminados"),
("Gestión de la referencia para atención de Emergencia","V_3460","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad","0000676 - MONITOREO COVID-19 AÑO 2021","No conforme ","La IPRESS no cuenta con registro en RENIPRESS "),
("Gestión de medidas protectoras","V_3456","La IPRESS del primer nivel de atención en salud(PNAS) articula con el SAMU del MINSA de las regiones","0000616 - Integral Abreviado","No conforme","No aplica al nivel de atención"),
("Gestión de la dirección ","V_3455","El IPRESS cumple con realizar las programaciones ","0000676 - MONITOREO COVID-19 AÑO 2021","No conforme ","La IPRESS no cuenta con registro en RENIPRESS "),/*amen*/
("Gestión de Desinfección y Esterilización","V_3457","0000676 - MONITOREO COVID-19 AÑO 2021","La IPRESS,cuenta con registro en RENIPRESS actualizado ante la Superintendencia Nacional de Salud(SU SALUD)","No aplica","La IPRESS no lleva un registro de la referencia y contrarferencia de los pacientes COVID-19"),
("Gestión de la dirección ","V_3455","El IPRESS cumple con realizar las programaciones ","0000676 - MONITOREO COVID-19 AÑO 2021","No conforme ","La IPRESS no cuenta con registro en RENIPRESS "),
("Gestión de Desinfección y Esterilización","V_3457","La IPRESS,cuenta con registro en RENIPRESS actualizado ante la Superintendencia Nacional de Salud(SU SALUD)","0000675 - INSTRUMENTO DISPOSITIVOS DE DIAGNOSTICO IN VITRO SEGUNDA VERSION","No conforme","La IPRESS no ha considerado para toda actividad de atención directa y atención de soporte"),
("Gestión de Precios y Contratos","V_3458","La IPRESS lleva un registro de la referencia y contrareferencia de los pacientes covid-19","0000616 - Integral Abreviado","No aplica","La IPRESS del primer nivel de atención en salud(PNAS)no articula con el SAMU del MINSA"),
("Gestión de Atención al Usuario","V_3459","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad","0000630 - Supervisión Especial Abreviada Verificación de Cumplimiento de Medida de Seguridad","No aplica","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad"),
("Gestión de la referencia para atención de Emergencia","V_3460","La IPRESS del primer nivel de atención en salud(PNAS) articula con el SAMU del MINSA de las regiones","0000616 - Integral Abreviado","No conforme","No aplica al nivel de atención"),
("Gestion de medidad protectoras","V_3461","La IPRESS cumple con identificar al paciente de acuerdo al seguro de salud y garantiza la entrega de los producto farmaceúticos","0000658 - Informalidad Sanitaria 2020","No aplica","La IPRESS no cuenta con un sistema a que acredite el transporte de material limpio y residuos sólidos contaminados"),
("Gestión de Precios y Contratos","V_3458","La IPRESS lleva un registro de la referencia y contrareferencia de los pacientes covid-19","0000616 - Integral Abreviado","No aplica","La IPRESS del primer nivel de atención en salud(PNAS)no articula con el SAMU del MINSA"),
("Gestión de Atención al Usuario","V_3459","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad","0000630 - Supervisión Especial Abreviada Verificación de Cumplimiento de Medida de Seguridad","No aplica","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad"),
("Gestión de Atención al Usuario","V_3459","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad","0000630 - Supervisión Especial Abreviada Verificación de Cumplimiento de Medida de Seguridad","No aplica","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad"),
("Gestión de la referencia para atención de Emergencia","V_3460","La IPRESS del primer nivel de atención en salud(PNAS) articula con el SAMU del MINSA de las regiones","0000616 - Integral Abreviado","No conforme","No aplica al nivel de atención"),
("Gestion de medidad protectoras","V_3461","La IPRESS cumple con identificar al paciente de acuerdo al seguro de salud y garantiza la entrega de los producto farmaceúticos","0000658 - Informalidad Sanitaria 2020","No aplica","La IPRESS no cuenta con un sistema a que acredite el transporte de material limpio y residuos sólidos contaminados"),
("Gestión de medidas protectoras","V_3456","La IPRESS ha considerado para toda actividad de atención directa y atención de soporte","0000676 - MONITOREO COVID-19 AÑO 2021","No aplica","La IPRESS no cuenta con un sistema a que acredite el transporte de material limpio y residuos sólidos contaminados"),
("Gestión de Atención al Usuario","V_3459","La IPRESS establece la atención preferencial a las mujeres embarazadas,las niñas,niños,personas mayores y con discapacidad","0000658 - Informalidad Sanitaria 2020","No aplica","La IPRESS no cuenta con un sistema a que acredite el transporte de material limpio y residuos sólidos contaminados"),
("Gestión de la referencia para atención de Emergencia","La IPRESS del primer nivel de atención en salud(PNAS) articula con el SAMU del MINSA de las regiones","V_3460","0000676 - MONITOREO COVID-19 AÑO 2021","No conforme ","La IPRESS no cuenta con registro en RENIPRESS "),
("Gestión de medidas protectoras","V_3456","La IPRESS del primer nivel de atención en salud(PNAS) articula con el SAMU del MINSA de las regiones","0000616 - Integral Abreviado","No conforme","No aplica al nivel de atención"),
("Gestión de la dirección ","V_3455","El IPRESS cumple con realizar las programaciones ","0000676 - MONITOREO COVID-19 AÑO 2021","No conforme ","La IPRESS no cuenta con registro en RENIPRESS ");

-- expedientes
insert into expedientes(num_exped,estado,oficina,tipo,fecha)
values
('01366-2021','Abierto','IPROT','GRAL','2021-01-11'),
('01369-2021','Abierto','SUP','GRAL','2021-02-13'),
('01371-2021','Cerrado','ISPRESS','GRAL','2021-03-14'),
('01376-2021','Abierto','OGPP','GRAL','2021-04-15'),
('01379-2021','Cerrado','ADONP','GRAL','2021-05-16'),
('01380-2021','Cerrado','IPROT','GRAL','2021-06-17'),
('01381-2021','Abierto','OGPP','GRAL','2021-07-18'),
('01384-2021','Abierto','ADONP','GRAL','2021-08-19'),
('01401-2021','Cerrado','ADONP','GRAL','2021-09-20'),
('01402-2021','Cerrado','ADONP','GRAL','2021-10-21'),
('01403-2021','Abierto','OGPP','GRAL','2021-11-22'),
('01405-2021','Cerrado','ISPRESS','GRAL','2021-12-23'),
('01429-2021','Abierto','IPROT','GRAL','2021-12-23'),
('01430-2021','Cerrado','IPROT','GRAL','2021-12-23'),
('01431-2021','Abierto','OGPP','GRAL','2021-11-22'),
('01432-2021','Cerrado','ADONP','GRAL','2021-11-22'),
('01436-2021','Cerrado','ISPRESS','GRAL','2021-08-19'),
('01438-2021','Abierto','OGPP','GRAL','2021-08-19'),
('01442-2021','Cerrado','ISPRESS','GRAL','2021-03-14'),
('01444-2021','Cerrado','ADONP','GRAL','2021-03-14'),
('01446-2021','Abierto','SUP','GRAL','2021-01-11'),
('01447-2021','Abierto','OGPP','GRAL','2021-01-11'),
('01449-2021','Abierto','SUP','GRAL','2021-04-15'),
('01450-2021','Cerrado','ISPRESS','GRAL','2021-04-15'),
('01452-2021','Abierto','OGPP','GRAL','2021-07-18'),
('01453-2021','Abierto','SUP','GRAL','2021-07-18'),
('01455-2021','Abierto','ADONP','GRAL','2021-04-15'),
('01461-2021','Cerrado','ISPRESS','GRAL','2021-07-18'),
('01519-2021','Abierto','SUP','GRAL','2021-06-17'),
('01572-2021','Abierto','OGPP','GRAL','2021-11-22');
alter table expedientes add Departamento varchar(20);
update expedientes set Departamento = "LIMA" WHERE num_exped between '01366-2021' and '01380-2021';
update expedientes set Departamento = "HUANUCO" WHERE num_exped between '01381-2021' and '01384-2021';
update expedientes set Departamento = "UCAYALI" WHERE num_exped between '01401-2021' and '01430-2021';
update expedientes set Departamento = "LIMA" WHERE num_exped between '01431-2021' and '01449-2021';
update expedientes set Departamento = "CALLAO" WHERE num_exped between '01450-2021' and '01461-2021';
update expedientes set Departamento = "AYACUCHO" WHERE num_exped between '01519-2021' and '01572-2021';

-- instrumentos_supervision
insert into instrumentos_supervision(hora_Ini,hora_Fin,fecha,estado,cod_instru)
value
("13:20","15:40","22/02/14","EN PROCESO SUPERVISIÓN",1),
("15:40","17:20","22/02/14","EN PROCESO PLANEAMIENTO",3),
("13:15","14:30","22/02/15","ACTA SUPERVISIÓN CARGADA",22),
("15:20","16:20","22/02/15","ACTA SUPERVISIÓN CARGADA",6),
("14:20","16:40","22/02/15","ACTA SUPERVISIÓN CARGADA",8),
("12:20","15:20","22/02/16","ACTA SUPERVISIÓN CARGADA",9),
("14:50","16:30","22/02/16","EN PROCESO SUPERVISIÓN",10),
("13:20","15:20","22/02/16","EN PROCESO SUPERVISIÓN",11),
("14:00","15:50","22/02/17","ACTA SUPERVISIÓN CARGADA",11),
("15:00","17:20","22/02/18","ACTA SUPERVISIÓN CARGADA",11),
("13:20","15:00","22/02/18","ACTA SUPERVISIÓN CARGADA",15),
("14:00","15:20","22/02/19","ACTA SUPERVISIÓN CARGADA",18),
("13:15","14:30","22/02/20","ACTA SUPERVISIÓN CARGADA",22),
("15:25","16:20","22/02/20","ACTA SUPERVISIÓN CARGADA",14),
("15:45","17:20","22/02/21","EN PROCESO PLANEAMIENTO",13),
("13:55","14:30","22/02/21","ACTA SUPERVISIÓN CARGADA",9),
("13:50","15:20","22/02/21","EN PROCESO SUPERVISIÓN",9),
("14:00","15:50","22/02/22","ACTA SUPERVISIÓN CARGADA",9),
("12:20","15:20","22/02/23","ACTA SUPERVISIÓN CARGADA",5),
("14:50","16:30","22/02/24","EN PROCESO SUPERVISIÓN",6),
("13:20","15:20","22/02/24","EN PROCESO SUPERVISIÓN",7),
("14:00","15:50","22/02/25","ACTA SUPERVISIÓN CARGADA",17),
("13:15","14:30","22/02/26","ACTA SUPERVISIÓN CARGADA",13),
("15:20","16:20","22/02/27","ACTA SUPERVISIÓN CARGADA",12),
("14:20","16:40","22/02/27","ACTA SUPERVISIÓN CARGADA",11),
("12:20","15:20","22/02/28","ACTA SUPERVISIÓN CARGADA",11),
("13:20","15:20","22/02/28","EN PROCESO SUPERVISIÓN",10),
("14:00","15:50","22/02/28","ACTA SUPERVISIÓN CARGADA",1),
("15:00","17:20","22/28/28","ACTA SUPERVISIÓN CARGADA",2),
("13:20","15:00","22/28/18","ACTA SUPERVISIÓN CARGADA",3);


select * from planificaciones_supervision;
-- planificaciones_supervision - esta alterada
insert into planificaciones_supervision(programacion,etapa,hora_vis,estado_plan,fecha_ini,fecha_fin,cod_ipress,num_expe,cod_super,instrumentosAA) values
('Programada','Supervision especial abreviada','13:20','Acta de supervision cargada','22/02/02','22/02/05',1,'01366-2021',1,3),
('No Programada','Siguimineto','14:20','En proceso de planeamiento','22/01/21','22/01/25',2,'01369-2021',2,1),
('Programada','Planificacion','19:20','Acta de supervision cargada','22/01/20','22/01/22',3,'01371-2021',3,12),
('No Programada','Supervision especial abreviada','15:20','En proceso de planeamiento','22/02/11','22/02/15',4,'01376-2021',4,15),
('Programada','Siguimineto','11:20','En proceso de planeamiento','22/02/21','22/02/25',5,'01379-2021',5,17),
('Programada','Supervision especial abreviada','07:20','Acta de supervision cargada','22/03/11','22/03/15',6,'01380-2021',6,3),
('No Programada','Siguimineto','19:20','En proceso de planeamiento','22/02/21','22/02/22',7,'01381-2021',7,5),
('Programada','Planificacion','16:50','En proceso de planeamiento','22/03/02','22/03/19',8,'01384-2021',8,1),
('No Programada','Supervision especial abreviada','11:40','En proceso de planeamiento','22/03/02','22/03/15',9,'01401-2021',9,19),
('Programada','Siguimineto','08:30','En proceso de planeamiento','22/03/01','22/03/12',10,'01402-2021',10,2),
('Programada','Supervision especial abreviada','13:20','Acta de supervision cargada','22/02/09','22/02/17',11,'01403-2021',11,3),
('No Programada','Siguimineto','14:00','En proceso de planeamiento','22/02/09','22/02/18',12,'01405-2021',13,14),
('Programada','Planificacion','12:20','En proceso de Supervision','21/05/09','22/05/12',13,'01429-2021',13,13),
('No Programada','Supervision especial abreviada','08:20','En proceso de Supervision','22/02/05','22/02/15',14,'01430-2021',14,21),
('Programada','Siguimineto','09:40','En proceso de planeamiento','22/02/11','22/02/14',15,'01431-2021',15,25),
('Programada','Supervision especial abreviada','13:10','Acta de supervision cargada','22/02/11','22/02/13',16,'01432-2021',16,27),
('No Programada','Siguimineto','14:20','En proceso de planeamiento','22/02/21','22/02/26',17,'01436-2021',17,6),
('Programada','Planificacion','14:20','En proceso de planeamiento','22/02/15','22/02/27',18,'01438-2021',18,1),
('No Programada','Supervision especial abreviada','11:55','En proceso de Supervision','22/01/01','22/01/15',19,'01442-2021',19,2),
('Programada','Siguimineto','12:25','En proceso de planeamiento','22/01/21','22/01/25',20,'01444-2021',20,10),
('Programada','Supervision especial abreviada','13:20','Acta de supervision cargada','22/01/21','22/01/27',21,'01446-2021',21,23),
('No Programada','Siguimineto','14:20','En proceso de planeamiento','22/02/08','22/02/16',22,'01447-2021',22,11),
('Programada','Planificacion','14:20','En proceso de planeamiento','22/02/01','22/02/15',23,'01449-2021',23,10),
('No Programada','Supervision especial abreviada','21:20','En proceso de Supervision','22/02/12','22/02/19',24,'01450-2021',24,15),
('Programada','Siguimineto','22:20','En proceso de planeamiento','21/05/18','21/05/20',25,'01452-2021',17,17),
('Programada','Supervision especial abreviada','13:20','Acta de supervision cargada','21/09/11','21/09/18',26,'01453-2021',17,30),
('No Programada','Siguimineto','23:20','Acta de supervision cargada','21/11/07','21/11/15',27,'01455-2021',17,11),
('Programada','Planificacion','14:20','En proceso de Supervision','22/02/21','22/03/25',28,'01461-2021',28,13),
('No Programada','Supervision especial abreviada','14:20','En proceso de Supervision','22/02/12','22/02/25',29,'01519-2021',29,19),
('Programada','Siguimineto','12:20','En proceso de planeamiento','22/02/12','22/02/28',30,'01572-2021',30,11);
update planificaciones_supervision set cod_super = 1 where cod_plan = 4;
update planificaciones_supervision set cod_super = 3 where cod_plan = 7;
update planificaciones_supervision set cod_super = 2 where cod_plan = 8;
update planificaciones_supervision set cod_super = 9 where cod_plan = 18;
update planificaciones_supervision set cod_super = 7 where cod_plan = 21;
update planificaciones_supervision set cod_super = 1 where cod_plan = 14;
update planificaciones_supervision set cod_super = 1 where cod_plan = 16;
update planificaciones_supervision set cod_super = 1 where cod_plan = 23;
update planificaciones_supervision set cod_super = 1 where cod_plan = 11;
update planificaciones_supervision set cod_super = 1 where cod_plan = 26;
update planificaciones_supervision set cod_super = 2 where cod_plan = 9;
update planificaciones_supervision set fecha_ini = '2022-02-27' where cod_plan = 4;
update planificaciones_supervision set fecha_fin = '2022-04-02' where cod_plan = 4

/* Pregunta 1°*/ 
select count(*) from departamentos;
select count(*) from distritos;
select count(*) from provincias;
select count(*) from expedientes;
select count(*) from instrumentos;
select count(*) from instrumentos_supervision;
select count(*) from ipress;
select count(*) from planificaciones_supervision;
select count(*) from supervisores;
select count(*) from supervisores;

-- 2
select ps.cod_super,s.nombre,s.apellido,count(*) as CantidadSupervisiones
from planificaciones_supervision as ps
join supervisores as s
	on ps.cod_super = s.cod_sup
group by  ps.cod_super,s.nombre,s.apellido
having count(*)>1;

/* Pregunta 5°*/ 
select b.nombre,apellido b from planificaciones_supervision as a join supervisores as b on a.cod_super = b.cod_sup where fecha_ini BETWEEN '21/05/01' AND '22/05/01' group by cod_super having count(*)>1;

/* Pregunta 6°*/
select * from planificaciones_supervision order by cod_plan asc;

/* Pregunta 7°*/
select * from planificaciones_supervision where fecha_ini BETWEEN '22/02/16' AND '22/02/23';

/* Pregunta 8°*/
select * from planificaciones_supervision where fecha_ini BETWEEN '22/01/19' AND '22/01/26';

/* Pregunta 9°*/
select * from planificaciones_supervision where estado_plan = 'En proceso de Supervision';

/* Pregunta 10°*/
-- No entendimos

/* Pregunta 11°*/
SELECT a.razon_social, b.nomb_Dist, c.nomb_Prov, d.nomb_Dep 
FROM IPRESS AS a JOIN distritos AS b JOIN provincias AS c JOIN departamentos AS d  ON a.id_Dist = b.id_Dist 
and  b.id_Prov = c.id_Prov and  c.id_Dep = d.id_Dep;

/* Pregunta 12°*/

-- 13.- 
SELECT instrumentos, COUNT( instrumentos ) AS total
FROM  instrumentos
GROUP BY instrumentos ORDER BY total DESC;

-- 14.- 
select a.cod_Ipress, a.correo_Ipress, a.razon_social, a.RENIPRESS, b.nomb_Dist, c.sub_sector from IPRESS as a join distritos as b join sub_sector as c on a.id_Dist = b.id_Dist and b.sub_id = c.sub_id where c.sub_id = 1;

-- 15.- 
select a.cod_Ipress, a.correo_Ipress, a.razon_social, a.RENIPRESS, b.nomb_Dist, c.sub_sector from IPRESS as a join distritos as b join sub_sector as c on a.id_Dist = b.id_Dist and b.sub_id = c.sub_id where c.sub_id = 4;
-- 16.- 
select * from ipress where riesgo='ALTO RIESGO';

/*PREGUNTA 17*/
-- Mostrar la cantidad de IPRESS que tienen “Alto Riesgo”, “Bajo Riesgo” y “Mediano Riesgo”
select * from ipress;
select count(*) AS 'ALTO RIESGO' from ipress where riesgo = "ALTO RIESGO"; 
select count(*) AS 'BAJO RIESGO' from ipress where riesgo = "BAJO RIESGO"; 
select count(*) AS 'MEDIANO RIESGO' from ipress where riesgo = "MEDIANO RIESGO";

-- PREGUNTA 18
/*	Listado de expedientes generados*/
SELECT * FROM EXPEDIENTES;
SELECT num_exped as 'EXPEDIENTES GENERADOS', fecha AS 'FECHA REGISTRADA' from  expedientes;

-- PREGUNTA 19/	
/*	Listado de Expediente por Departamento.*/
SELECT num_exped AS 'LISTA EXPEDIENTES', Departamento AS 'DEPARTAMENTO' FROM expedientes order by departamento desc;



/* ---------------------- Insert ----------------------- */

/* Total de registros en la Base de Datos (1)*/
	select count(*) from departamentos;
	select count(*) from distritos;
	select count(*) from provincias;
	select count(*) from expedientes;
	select count(*) from instrumentos;
	select count(*) from instrumentos_supervision;
	select count(*) from ipress;
	select count(*) from planificaciones_supervision;
	select count(*) from supervisores;
	select count(*) from supervisores;

-- Listado de supervisores que tuvieron a cargo dos o más supervisiones (2)
	select ps.cod_super,s.nombre,s.apellido,count(*) as CantidadSupervisiones
	from planificaciones_supervision as ps
	join supervisores as s
	on ps.cod_super = s.cod_sup
	group by  ps.cod_super,s.nombre,s.apellido
	having count(*)>1;

-- Listado de supervisores que tuvieron a cargo dos o más supervisiones dentro de un intervalo de tiempo (mensual) (3).
	select ps.cod_super,s.nombre,s.apellido
	from planificaciones_supervision as ps
	join supervisores as s
	on ps.cod_super = s.cod_sup
	where fecha_ini BETWEEN '22/02/01' AND '22/02/28'
	group by  ps.cod_super,s.nombre,s.apellido
	having count(*)>1;

-- Listado de supervisores que tuvieron a cargo dos o más supervisiones dentro de un intervalo de tiempo (trimestral) (4).
	select ps.cod_super,s.nombre,s.apellido
	from planificaciones_supervision as ps
	join supervisores as s
	on ps.cod_super = s.cod_sup
	where fecha_ini BETWEEN '22/02/01' AND '22/04/30'
	group by  ps.cod_super,s.nombre,s.apellido
	having count(*)>1;

-- Listado de supervisores que tuvieron a cargo dos o más supervisiones dentro de un intervalo de tiempo (anual)(5).
select b.nombre,apellido b from planificaciones_supervision as a join supervisores as b on a.cod_super = b.cod_sup where fecha_ini BETWEEN '21/05/01' AND '22/05/01' group by cod_super having count(*)>1;

-- Listado de los códigos de planes ordenados ascendentemente (6).
	select * from planificaciones_supervision order by cod_plan asc;


-- Listado de planes generados en un intervalo de tiempo (semana) (7).
	select * from planificaciones_supervision where fecha_ini BETWEEN '22/02/16' AND '22/02/23';

-- Listado de planes generados en un intervalo de tiempo (semana) en un mes diferente a la anterior consulta (8).
	select * from planificaciones_supervision where fecha_ini BETWEEN '22/01/19' AND '22/01/26';


-- Listado de supervisiones que se vienen ejecutando (Estado “En proceso Supervisión”) (9).
	select * from planificaciones_supervision where estado_plan = 'En proceso de Supervision';

-- Listado de IPRESS, dirección, distrito, provincia y departamento (10).
	SELECT a.razon_social, b.nomb_Dist, c.nomb_Prov, d.nomb_Dep 
	FROM IPRESS AS a JOIN distritos AS b JOIN provincias AS c JOIN departamentos AS d  ON a.id_Dist = b.id_Dist 
	and  b.id_Prov = c.id_Prov and  c.id_Dep = d.id_Dep;

-- Identificar la IPRESS con más supervisiones ejecutadas (11).
	

-- Identificar el INSTRUMENTO que más se utilizó (12)
	SELECT instrumentos, COUNT( instrumentos ) AS total
	FROM  instrumentos
	GROUP BY instrumentos ORDER BY total DESC;

-- Listado de IPRESS por Lima centro (13)
	select a.cod_Ipress, a.correo_Ipress, a.razon_social, a.RENIPRESS, b.nomb_Dist, c.sub_sector from IPRESS as a join distritos as b join sub_sector as c on a.id_Dist = b.id_Dist and b.sub_id = c.sub_id where c.sub_id = 1;

-- Listado de IPRESS por Lima Sur (14)
	select a.cod_Ipress, a.correo_Ipress, a.razon_social, a.RENIPRESS, b.nomb_Dist, c.sub_sector from IPRESS as a join distritos as b join sub_sector as c on a.id_Dist = b.id_Dist and b.sub_id = c.sub_id where c.sub_id = 4;

-- Listado de IPRESS que tiene Alto Riesgo (15)
	select * from ipress where riesgo='ALTO RIESGO';

-- Mostrar la cantidad de IPRESS que tienen “Alto Riesgo”, “Bajo Riesgo” y “Mediano Riesgo” (16).
	select * from ipress;
	select count(*) AS 'ALTO RIESGO' from ipress where riesgo = "ALTO RIESGO"; 
	select count(*) AS 'BAJO RIESGO' from ipress where riesgo = "BAJO RIESGO"; 
	select count(*) AS 'MEDIANO RIESGO' from ipress where riesgo = "MEDIANO RIESGO";

-- Listado de expedientes generados (17)
	SELECT * FROM EXPEDIENTES;
	SELECT num_exped as 'EXPEDIENTES GENERADOS', fecha AS 'FECHA REGISTRADA' from  expedientes;

-- Listado de Expediente por Departamento (18).
	SELECT num_exped AS 'LISTA EXPEDIENTES', Departamento AS 'DEPARTAMENTO' FROM expedientes order by departamento desc;