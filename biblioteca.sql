--CREAMOS LA BBDD BIBLIOTECA

CREATE DATABASE biblioteca;


--CREAMOS LAS TABLAS DE LA BBDD BIBLIOTECA
CREATE TABLE autor(
codigo_autor INT PRIMARY KEY,
nombre_autor VARCHAR(100),
apellido_autor VARCHAR(100),
fnac_autor DATE,
fdef_autor DATE,
tipo_autor VARCHAR(20)
);

CREATE TABLE libro(
isbn_libro CHAR(15) PRIMARY KEY,
titulo_libro VARCHAR(255),
paginas_libro INT
);

--SE CREA LA TABLA LIBRO_AUTOR PARA RESPETAR LA NORMALIZACION
CREATE TABLE libro_autor(
isbn_libro CHAR(15),
codigo_autor INT,
FOREIGN KEY (isbn_libro) REFERENCES libro (isbn_libro),
FOREIGN KEY (codigo_autor) REFERENCES autor (codigo_autor)
);

CREATE TABLE socio(
rut_socio CHAR(10) PRIMARY KEY,
nombre_socio VARCHAR(100),
apellido_socio VARCHAR(100),
direccion_socio VARCHAR(255),
telefono_socio VARCHAR(20)
);

CREATE TABLE prestamo(
id_prestamo SERIAL PRIMARY KEY,
fecha_prestamo DATE,
fecha_devolucion DATE,
rut_socio CHAR(10),
isbn_libro CHAR(15),
FOREIGN KEY (rut_socio) REFERENCES socio (rut_socio),
FOREIGN KEY (isbn_libro) REFERENCES libro (isbn_libro)
);


--SE INSERTAN DATOS EN LAS TABLAS CREADAS

INSERT INTO AUTOR(codigo_autor, nombre_autor, apellido_autor, fnac_autor, fdef_autor, tipo_autor) VALUES(3, 'JOSE', 'SALGADO', '1968-01-01', '01-01-2020', 'PRINCIPAL' );
INSERT INTO AUTOR(codigo_autor, nombre_autor, apellido_autor, fnac_autor, fdef_autor, tipo_autor) VALUES(4, 'ANA', 'SALGADO', '1972-01-01',NULL, 'COAUTOR');
INSERT INTO AUTOR(codigo_autor, nombre_autor, apellido_autor, fnac_autor, fdef_autor, tipo_autor) VALUES(1, 'ANDRES', 'ULLOA', '1982-01-01',NULL, 'PRINCIPAL');
INSERT INTO AUTOR(codigo_autor, nombre_autor, apellido_autor, fnac_autor, fdef_autor, tipo_autor) VALUES(2, 'SERGIO', 'MARDONES', '1950-01-01','2012-01-01', 'PRINCIPAL');
INSERT INTO AUTOR(codigo_autor, nombre_autor, apellido_autor, fnac_autor, fdef_autor, tipo_autor) VALUES(5, 'MARTIN', 'PORTA', '1976-01-01',NULL, 'PRINCIPAL');

INSERT INTO LIBRO(isbn_libro, titulo_libro, paginas_libro) VALUES('111-1111111-111', 'CUENTOS DE TERROR', 344);
INSERT INTO LIBRO(isbn_libro, titulo_libro, paginas_libro) VALUES('222-2222222-222', 'POESÍAS CONTEMPORANEAS', 167);
INSERT INTO LIBRO(isbn_libro, titulo_libro, paginas_libro) VALUES('333-3333333-333', 'HISTORIA DE ASIA', 511);
INSERT INTO LIBRO(isbn_libro, titulo_libro, paginas_libro) VALUES('444-4444444-444', 'MANUAL DE MECÁNICA', 298);

INSERT INTO LIBRO_AUTOR(isbn_libro, codigo_autor) VALUES('111-1111111-111', 3);
INSERT INTO LIBRO_AUTOR(isbn_libro, codigo_autor) VALUES('111-1111111-111', 4);
INSERT INTO LIBRO_AUTOR(isbn_libro, codigo_autor) VALUES('222-2222222-222', 1);
INSERT INTO LIBRO_AUTOR(isbn_libro, codigo_autor) VALUES('333-3333333-333', 2);
INSERT INTO LIBRO_AUTOR(isbn_libro, codigo_autor) VALUES('444-4444444-444', 5);

INSERT INTO SOCIO(rut_socio, nombre_socio, apellido_socio, direccion_socio, telefono_socio) VALUES ('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1, SANTIAGO', '911111111');
INSERT INTO SOCIO(rut_socio, nombre_socio, apellido_socio, direccion_socio, telefono_socio) VALUES ('2222222-2', 'ANA', 'PÉREZ', 'PASAJE 2, SANTIAGO', '922222222');
INSERT INTO SOCIO(rut_socio, nombre_socio, apellido_socio, direccion_socio, telefono_socio) VALUES ('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2, SANTIAGO', '933333333');
INSERT INTO SOCIO(rut_socio, nombre_socio, apellido_socio, direccion_socio, telefono_socio) VALUES ('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3, SANTIAGO', '944444444');
INSERT INTO SOCIO(rut_socio, nombre_socio, apellido_socio, direccion_socio, telefono_socio) VALUES ('5555555-5', 'SILVANA', 'MUÑOZ', 'PASAJE 3, SANTIAGO', '955555555');

INSERT INTO PRESTAMO(fecha_prestamo, fecha_devolucion, rut_socio, isbn_libro) VALUES('2020-01-20', '2020-01-27', '1111111-1', '111-1111111-111');
INSERT INTO PRESTAMO(fecha_prestamo, fecha_devolucion, rut_socio, isbn_libro) VALUES('2020-01-20', '2020-01-30', '5555555-5', '222-2222222-222');
INSERT INTO PRESTAMO(fecha_prestamo, fecha_devolucion, rut_socio, isbn_libro) VALUES('2020-01-22', '2020-01-30', '3333333-3', '333-3333333-333');
INSERT INTO PRESTAMO(fecha_prestamo, fecha_devolucion, rut_socio, isbn_libro) VALUES('2020-01-23', '2020-01-30', '4444444-4', '444-4444444-444');
INSERT INTO PRESTAMO(fecha_prestamo, fecha_devolucion, rut_socio, isbn_libro) VALUES('2020-01-27', '2020-02-04', '2222222-2', '111-1111111-111');
INSERT INTO PRESTAMO(fecha_prestamo, fecha_devolucion, rut_socio, isbn_libro) VALUES('2020-01-31', '2020-02-12', '1111111-1', '444-4444444-444');
INSERT INTO PRESTAMO(fecha_prestamo, fecha_devolucion, rut_socio, isbn_libro) VALUES( '2020-01-31', '2020-02-12', '3333333-3', '222-2222222-222');


--a. Mostrar todos los libros que posean menos de 300 páginas.

select * from libro 
where paginas_libro <300;

--b. Mostrar todos los autores que hayan nacido después del 01-01-1970

select * from autor 
where fnac_autor > '1970-01-01';

--c. ¿Cuál es el libro más solicitado?

select count(prestamo.isbn_libro), prestamo.isbn_libro, libro.titulo_libro
from prestamo 
inner join libro on prestamo.isbn_libro = libro.isbn_libro
group by prestamo.isbn_libro, libro.titulo_libro
order by count(*) desc limit 3;

--d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días

select prestamo.id_prestamo, prestamo.rut_socio,((prestamo.fecha_devolucion - prestamo.fecha_prestamo)-7)*100 as multa
from prestamo
inner join libro on prestamo.isbn_libro = libro.isbn_libro
where ((prestamo.fecha_devolucion - prestamo.fecha_prestamo)-7)>0;
