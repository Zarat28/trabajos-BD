create database envios_articulos;
use envios_articulos;

create table proveedores(
id_p char(5)  primary key not null ,
pnombre varchar(50),
categoria varchar (10),
ciudad varchar(50)
);

create table componentes(
id_c char(5)   primary key not null ,
pnombre char(3),
color varchar (20),
peso double,
ciudad varchar(50)

);

create table articulos(
id_t char(5)   primary key not null ,
tnombre varchar(50),
ciudad varchar(50)

);

create table envios(

id_p char(5),
foreign key(id_p) references proveedores(id_p),
id_c char(5),
foreign key(id_c) references componentes(id_c),
id_t char(5),
foreign key(id_t) references articulos(id_t),
cantidad int 
);


insert into proveedores(id_p,pnombre,categoria,ciudad) 
values ('p1','carlos','20','sevilla'),
('p2','juan','10','madrid'),
('p3','jose','30','sevilla'),
('p4','inma','20','sevilla'),
('p5','eva','30','caceres');

select * from proveedores;

insert into componentes(id_c,pnombre,color,peso,ciudad)
 values ('C1','X3A','ROJO',12,'SEVILLA'),
	('C2','B85','VERDE',17,'MADRID'),('C3','C4B','AZUL',17,'MALAGA'),('C4','C4B','ROJO',14,'SEVILLA'),
	('C5','VT8','AZUL',12,'MADRID'),('C6','C30','ROJO',19,'SEVILLA');

select * from componentes;

insert into articulos(id_t,tnombre,ciudad) 
values ('T1','clasificadora ','madrid'),
('T2','perforadora','malaga'),
('T3','lectora','caceres'),
('T4','consola','caceres'),
('T5','mezcladora','sevilla'),
('T6','terminal','barcelona'),
('T7','cinta','sevilla');

select * from ARTICULOS;

insert into envios(id_p,id_c,id_t,cantidad) 
values ('P1','C1','T1',200),
('P1','C1','T4',700),
('P2','C3','T1',400),
('P2','C3','T2',200),
('P2','C3','T3',200),
('P2','C3','T4',500),
('P2','C3','T5',600),
('P2','C3','T6',400),
('P2','C3','T7',800),
('P2','C5','T2',100),
('P3','C3','T1',200),
('P3','C4','T2',500),
('P4','C6','T3',300),
('P4','C6','T7',300),
('P5','C2','T2',200),
('P5','C2','T4',100),
('P5','C5','T4',500),
('P5','C5','T7',100),
('P5','C6','T2',200),
('P5','C1','T4',100),
('P5','C3','T4',200),
('P5','C4','T4',800),
('P5','C5','T5',400),
('P5','C6','T4',500);

select * from ENVIOS;

-- TIPO DE CONSULTA INNER JOIN
select P.pnombre,C.pnombre,A.tnombre, E.cantidad from proveedores P, componentes C, articulos A, envios E 
where P.id_p = E.id_p and C.id_c = E.id_c and A.id_t = E.id_t;

select P.pnombre,C.pnombre,A.tnombre, sum(E.cantidad) from proveedores P, componentes C, articulos A, envios E 
where P.id_p = E.id_p and C.id_c = E.id_c and A.id_t = E.id_t group by P.pnombre;

-- 	PROMEDIO DE LA CANTIDAD DE LA TABLA ENVIOS
select  AVG(cantidad) from envios;

/*---------EJERCICIOS----------*/
/*1.	Obtener todos los detalles de todos los artículos de CACERES.*/
select id_t as id,tnombre as nombre, ciudad from articulos where ciudad='caceres';

/*2.	Obtener todos los valores de P# para los proveedores que abastecen el artículo T1.*/
select P.id_p,C.id_c,A.id_t, E.cantidad 
from proveedores P, componentes C, articulos A, envios E 
where P.id_p = E.id_p and C.id_c = E.id_c and A.id_t = E.id_t and A.id_t = 'T1';

/*3.	Obtener la lista de pares de atributos (COLOR, CIUDAD) de la tabla componentes   
		eliminando los pares duplicados.*/
select distinct color, ciudad from componentes;

/*4.	Obtener de la tabla de artículos los valores de T# y CIUDAD donde el nombre de la
		ciudad acaba en D o contiene al menos una E.*/
select id_t,ciudad from articulos where ciudad like '%e%' or ciudad like '%d';

/*5.	Obtener los valores de P# para los proveedores que suministran para el artículo T1 el componente C1.*/
select P.id_p,A.id_t,C.id_c, E.cantidad 
from proveedores P, componentes C, articulos A, envios E 
where P.id_p = E.id_p and C.id_c = E.id_c and A.id_t = E.id_t and A.id_t = 'T1' and C.id_c='C1';

/*6.	Obtener los valores de TNOMBRE en orden alfabético para los artículos bastecidos por  el proveedor P1.*/
select P.id_p,A.id_t,A.tnombre as nombre
from proveedores P,articulos A, envios E
where P.id_p = E.id_p and A.id_t = E.id_t and P.id_p = 'P1' order by A.tnombre asc;

/*7.	Obtener los valores de C# para los componentes suministrados para cualquier artículo de MADRID.*/
select C.id_c,A.id_t,A.tnombre,A.ciudad
from componentes C, articulos A, envios E
where C.id_c = E.id_c and A.id_t = E.id_t and A.ciudad = 'madrid';

/*8.	Obtener todos los valores de C# de los componentes tales que ningún otro componente tenga un 
		valor de peso inferior.*/
select id_c,pnombre,color,peso,ciudad from componentes where peso >15;

/*9.	Obtener los valores de P# para los proveedores que suministren los artículos T1 y T2.*/
select  distinct P.id_p as valoresP,A.id_t 
from  proveedores P, articulos A, envios E where  P.id_p = E.id_p and A.id_t = E.id_t 
and (A.id_t = 'T1' or A.id_t = 'T2');

/*10.	Obtener los valores de P# para los proveedores que suministran para un artículo 
		de SEVILLA o MADRID un componente ROJO.*/
select P.id_p,A.id_t,A.ciudad,C.id_c,C.color, E.cantidad 
from proveedores P, componentes C, articulos A, envios E 
where P.id_p = E.id_p and C.id_c = E.id_c and A.id_t = E.id_t 
and (A.ciudad = 'Sevilla' or A.ciudad = 'madrid') and C.color = 'rojo';

/*11.	Obtener, mediante sub consultas, los valores de C# para los componentes 
		suministrados para algún artículo de SEVILLA por un proveedor de SEVILLA.*/
select  distinct P.id_p,C.id_c,A.id_t 
from proveedores P, componentes C, articulos A, envios E 
where P.id_p = E.id_p and A.id_t = E.id_t and (A.ciudad = 'sevilla' and P.ciudad = 'sevilla');

/*12.	Obtener los valores de T# para los artículos que usan al menos un 
		componente que se puede obtener con el proveedor P1.*/
select A.id_t,A.tnombre,P.id_p
from articulos A, proveedores P, envios E
where (A.id_t = E.id_t and P.id_p = E.id_p) and (E.id_p = 'P1');

/*13.	Obtener todas las ternas (CIUDAD, C#, CIUDAD) tales que un proveedor  de la primera ciudad suministre 
		el componente especificado para un artículo montado en la segunda ciudad.*/
SELECT p.ciudad,e.id_c, a.ciudad FROM envios e, proveedores p , articulos a 
WHERE e.id_p=p.id_p AND e.id_t=a.id_t; 

/*14.	Repetir el ejercicio anterior pero sin recuperar las ternas 
		en los que los dos valores de ciudad sean los mismos.*/
SELECT p.ciudad ,id_c, a.ciudad FROM envios e, proveedores p , articulos a 
WHERE e.id_p=p.id_p AND e.id_t=a.id_t AND p.ciudad <> a.ciudad;

/*15.	Obtener el número de suministros, el de artículos distintos suministrados y la 
cantidad total de artículos suministrados por el proveedor P2*/
SELECT COUNT(*) as NúmeroSuministros, COUNT(distinct id_t) ArticulosSuministrados, 
SUM(cantidad) TotalSuministrados FROM envios WHERE id_p='P2';

/*16.	Para cada artículo y componente suministrado obtener los valores 
		de C#, T# y la cantidad total correspondiente*/
SELECT id_c,id_t, SUM(cantidad) Total FROM envios GROUP BY id_c,id_t; 

/*17.	Obtener los valores de T# de los artículos abastecidos al menos por un proveedor 
que no viva en MADRID y que no esté en la misma ciudad en la que se monta el artículo*/
SELECT DISTINCT e.id_t FROM envios e,articulos a WHERE e.id_t = a.id_t 
AND EXISTS( SELECT *FROM proveedores p 
WHERE p.ciudad!= a.ciudad AND p.id_p= e.id_p AND p.ciudad!='MADRID' ); 

/*18.	Obtener los valores de P# para los proveedores que suministran al menos un componente 
		suministrado al menos por un proveedor que suministra al menos un componente ROJO.*/
SELECT DISTINCT E.id_p AS Codigo_Proveedor FROM envios E 
INNER JOIN componentes C ON E.id_c=C.id_c WHERE C.color='ROJO';

/*19.	Obtener los identificadores de artículos, T#, para los que se ha suministrado algún 
		componente del que se haya suministrado una media superior a 320 artículos.*/
SELECT DISTINCT * FROM envios WHERE id_c IN 
(SELECT id_c FROM envios GROUP BY id_c HAVING SUM(cantidad)/COUNT(cantidad)>320);

/*20.	Seleccionar los identificadores de proveedores que hayan realizado algún envío con 
Cantidad mayor que la media de los envíos realizados para el componente a que corresponda dicho envío*/
SELECT DISTINCT id_p Identificador_Proveedor FROM envios WHERE id_c IN 
(SELECT id_c FROM envios GROUP BY id_c HAVING cantidad>AVG(cantidad) );

/*21.	Seleccionar los identificadores de componentes suministrados para el artículo 'T2' por el proveedor 'P2'.*/
SELECT id_c as Codigo_Componente FROM envios WHERE (id_p='P2' AND id_t='T2');

/*22.	Seleccionar todos los datos de los envíos realizados de componentes cuyo color no sea 'ROJO'.*/
SELECT E.id_p AS Codigo_Proveedor,E.id_c AS Codigo_Componente,E.id_t AS Codigo_Articulo,E.cantidad AS Cantidad 
FROM envios E INNER JOIN componentes C ON E.id_c=C.id_c WHERE C.color!='ROJO';

/*23.	Seleccionar los identificadores de componentes que se suministren para los artículos 'T1' y 'T2'.*/
SELECT C.id_c AS Identificador,E.id_t AS Artículo FROM componentes C 
INNER JOIN envios E ON C.id_c=E.id_c WHERE E.id_t='T1' OR E.id_t='T2';
        
/*24.	Seleccionar el identificador de proveedor y el número de envíos de componentes de color 'ROJO' 
		llevados a cabo por cada proveedor.*/
SELECT P.id_p AS Identificador,COUNT(E.id_c) AS '# Envíos componente color ROJO' FROM proveedores P 
INNER JOIN envios E ON P.id_p=E.id_p INNER JOIN componentes C ON E.id_c=C.id_c WHERE C.color='ROJO' GROUP BY P.id_p;

/*25.	Seleccionar los colores de componentes suministrados por el proveedor 'P1'.*/
SELECT C.color AS Color, E.id_p AS Proveedor FROM componentes C 
INNER JOIN envios E ON C.id_c=E.id_c WHERE E.id_p='p1' GROUP BY C.color, E.id_p;
        
/*26.	Seleccionar los datos de envío y nombre de ciudad de aquellos envíos que cumplan que el artículo, 
		proveedor y componente son de la misma ciudad.*/
SELECT E.id_p AS Proveedor, E.id_c AS Componente, E.id_t AS Artículo, E.cantidad AS Cantidad, A.ciudad AS Ciudad
FROM envios E INNER JOIN articulos A ON E.id_t=A.id_t INNER JOIN componentes C ON E.id_c=C.id_c
INNER JOIN proveedores P ON E.id_p=P.id_p WHERE A.ciudad=C.ciudad AND C.ciudad=P.ciudad;

/*27.	Seleccionar los nombres de los componentes que son suministrados en una cantidad total superior a 500.*/
SELECT C.pnombre AS Nombre,SUM(E.cantidad) AS Cantidad FROM componentes C 
INNER JOIN envios E ON C.id_c=E.id_c WHERE E.cantidad>500 GROUP BY C.pnombre;

/*28.	Seleccionar los identificadores de proveedores que residan en Sevilla y 
		no suministren más de dos artículos distintos.*/
SELECT P.id_p AS Identificador,P.ciudad As Ciudad,COUNT(E.cantidad) AS 'Cantidad de artículos'
FROM proveedores P INNER JOIN envios E ON P.id_p=E.id_p
WHERE P.ciudad='sevilla' GROUP BY P.id_p, P.ciudad;
        
/*29.	Seleccionar los identificadores de artículos para los cuales todos sus 
		componentes se fabrican en una misma ciudad.*/
SELECT id_t FROM envios e,componentes c WHERE e.id_c = c.id_c GROUP BY id_t HAVING COUNT(DISTINCT ciudad) = 1;

/*30.	Seleccionar los identificadores de artículos para los que se provean 
		envíos de todos los componentes existentes en la base de datos.*/
SELECT id_t FROM envios GROUP BY id_t HAVING COUNT(DISTINCT id_c) = ( SELECT COUNT(*)FROM Componentes);

/*31.	Seleccionar los códigos de proveedor y artículo que 
		suministran al menos dos componentes de color 'ROJO'.*/
SELECT id_p, id_t FROM envios e,componentes c WHERE e.id_c = c.id_c 
AND c.color='ROJO' GROUP BY id_p, id_t HAVING COUNT(*)> 1;