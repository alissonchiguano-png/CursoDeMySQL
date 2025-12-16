-- Creo la base de datos 
CREATE DATABASE saludtotal;

-- seleccionamos la base de datos 
USE saludtotal;


-- TABLA MEDICINAS (Genericas y comerciales)

CREATE TABLE medicinas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo CHAR(3) DEFAULT 'GEN',   -- GEN = genérico, COM = comercial
    precio DECIMAL(15,2),
    stock INT,
    fechacaducidad DATETIME
);

ALTER TABLE medicinas
MODIFY COLUMN nombre VARCHAR(100) NOT NULL; -- no haya datos nulos

INSERT INTO medicinas (id, nombre, precio, stock, fechacaducidad)
VALUES (41, NULL, 1.50, 50, '2027-01-01 00:00:00');
-- tipo CHAR(3) DEFAULT 'GEN',
INSERT INTO medicinas (id, nombre, precio, stock, fechacaducidad)
VALUES (31, 'acetamol', 1.50, 50, '2027-01-01 00:00:00');

-- valores permitidos para la columna tipo 
ALTER TABLE medicinas
ADD CONSTRAINT medicina_tipo_val
CHECK (tipo IN ('GEN','COM'));
INSERT INTO medicinas (id, nombre, precio, stock, fechacaducidad)
VALUES (30, 'aceamol','gem', 1.50, 50, '2027-01-01 00:00:00');

-- inserto las medicinas genericas 
INSERT INTO medicinas VALUES (2, 'Ibuprofeno', 'GEN', 2.00, 60, '2027-02-01 00:00:00');
INSERT INTO medicinas VALUES (3, 'Naproxeno', 'GEN', 1.80, 45, '2027-03-01 00:00:00');
INSERT INTO medicinas VALUES (4, 'Levotiroxina', 'GEN', 3.00, 70, '2027-04-01 00:00:00');
INSERT INTO medicinas VALUES (5, 'Insulina Glargina', 'GEN', 15.00, 30, '2027-05-01 00:00:00');
INSERT INTO medicinas VALUES (6, 'Amoxicilina', 'GEN', 1.20, 80, '2026-12-01 00:00:00');
INSERT INTO medicinas VALUES (7, 'Azitromicina', 'GEN', 3.50, 55, '2027-06-01 00:00:00');
INSERT INTO medicinas VALUES (8, 'Ciprofloxacino', 'GEN', 2.10, 40, '2027-07-01 00:00:00');


-- inserto las medicinas comerciales 

INSERT INTO medicinas VALUES (9,  'Finalín',   'COM', 2.50, 40, '2027-01-01 00:00:00');
INSERT INTO medicinas VALUES (10, 'Panadol',   'COM', 3.00, 35, '2027-02-01 00:00:00');
INSERT INTO medicinas VALUES (11, 'Tempra',    'COM', 2.80, 30, '2027-03-01 00:00:00');
INSERT INTO medicinas VALUES (12, 'Advil',     'COM', 4.20, 25, '2027-04-01 00:00:00');
INSERT INTO medicinas VALUES (13, 'Motrin',    'COM', 4.00, 20, '2027-05-01 00:00:00');
INSERT INTO medicinas VALUES (14, 'Aleve',     'COM', 3.50, 15, '2027-06-01 00:00:00');
INSERT INTO medicinas VALUES (15, 'Flanax',    'COM', 3.20, 18, '2027-07-01 00:00:00');
INSERT INTO medicinas VALUES (16, 'Eutirox',   'COM', 5.00, 22, '2027-08-01 00:00:00');
INSERT INTO medicinas VALUES (17, 'Lantus',    'COM', 35.00, 10, '2027-09-01 00:00:00');
INSERT INTO medicinas VALUES (18, 'Amoxil',    'COM', 2.50, 60, '2026-11-01 00:00:00');
INSERT INTO medicinas VALUES (19, 'Zithromax', 'COM', 6.80, 32, '2027-03-01 00:00:00');
INSERT INTO medicinas VALUES (20, 'Cipro',     'COM', 5.75, 28, '2027-04-01 00:00:00');


-- TABLA CLIENTES

CREATE TABLE clientes (
    cedula CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    fechanacimiento DATE,
    medicina_id INT,
    telefono VARCHAR(15),
    correo VARCHAR(100),
    direccion VARCHAR(150)
);


DELETE FROM clientes;

INSERT INTO clientes VALUES ('1715128409','Kevin Rodriguez','2002-11-06',1,'0981112233','kevin.rodriguez@gmail.com','Quito Norte');
INSERT INTO clientes VALUES ('1756209837','Juan Perez','2002-11-06',2,'0982223344','juan.perez@gmail.com','Quito Centro');
INSERT INTO clientes VALUES ('1756986547','Roger Tallana','2002-11-06',3,'0983334455','roger.tallana@gmail.com','Quito Sur');
INSERT INTO clientes VALUES ('1745792364','Erik Analuisa','2005-09-06',1,'0984445566','erik.analuisa@gmail.com','Machachi');
INSERT INTO clientes VALUES ('1790012345','Carlos Andrade','1999-03-15',4,'0985556677','carlos.andrade@gmail.com','Sangolquí');
INSERT INTO clientes VALUES ('1785567890','Daniela López','2000-07-21',5,'0986667788','daniela.lopez@gmail.com','Quito Norte');
INSERT INTO clientes VALUES ('1764433221','Sofía Molina','1997-01-11',6,'0987778899','sofia.molina@gmail.com','Cumbayá');
INSERT INTO clientes VALUES ('1751122334','Jorge Ruiz','1985-11-30',7,'0988889900','jorge.ruiz@gmail.com','Tumbaco');
INSERT INTO clientes VALUES ('1739988776','María Torres','1994-06-18',8,'0989990011','maria.torres@gmail.com','Guayaquil');


-- TABLA CLIENTES FRECUENTES

CREATE TABLE clientesFrecuente (
    cedula CHAR(10),
    medicina_id INT,
    condicion VARCHAR(100),
    frecuencia CHAR(3),
    descuento DECIMAL(5,2)
);

ALTER TABLE clientesFrecuente
ADD PRIMARY KEY (cedula, medicina_id);

ALTER TABLE clientesFrecuente
ADD CONSTRAINT clientesfrecuente_cliente_fk
FOREIGN KEY (cedula) REFERENCES clientes(cedula);

ALTER TABLE clientesFrecuente
ADD CONSTRAINT clientesfrecuente_medicina_fk
FOREIGN KEY (medicina_id) REFERENCES medicinas(id);


INSERT INTO clientesFrecuente VALUES ('1715128409', 4, 'Hipertensión', 'men', 0.10);
INSERT INTO clientesFrecuente VALUES ('1756209837', 5, 'Diabetes Tipo 2', 'men', 0.05);
INSERT INTO clientesFrecuente VALUES ('1756986547', 6, 'Asma', 'sem', 0.08);
INSERT INTO clientesFrecuente VALUES ('1739988776', 7, 'Colesterol alto', 'cri', 0.07);
INSERT INTO clientesFrecuente VALUES ('1790012345', 8, 'Hipotiroidismo', 'sem', 0.06);


-- TABLA MEDICINA FRECUENTE

CREATE TABLE medicinafrecuente (
    cliente_cedula CHAR(10),
    medicina_id INT,
    frecuencia CHAR(3),
    descuentos DECIMAL(5,2)
);

ALTER TABLE medicinafrecuente
ADD CONSTRAINT clientecedula_fk FOREIGN KEY (cliente_cedula)
REFERENCES clientes(cedula);

ALTER TABLE medicinafrecuente
ADD CONSTRAINT medicina_fk FOREIGN KEY (medicina_id)
REFERENCES medicinas(id);

ALTER TABLE medicinafrecuente
ADD PRIMARY KEY (cliente_cedula, medicina_id);

INSERT INTO medicinafrecuente VALUES ('1739988776', 12, 'men', 0.25);

-- Relación: ID genérico  y ID comercial

-- CREACIÓN DE TABLA EQUIVALENCIA
CREATE TABLE equivalencia (
    id_generico INT,
    id_comercial INT
);

-- añadir validacion de clave foranea al medicamento generico 
ALTER TABLE equivalencia
ADD CONSTRAINT equivalencia_generico_fk
FOREIGN KEY (id_generico)
REFERENCES medicinas(id);

-- añadir validacion de clave foranea al medicamento comercial
ALTER TABLE equivalencia
ADD CONSTRAINT equivalencia_comercial_fk
FOREIGN KEY (id_comercial)
REFERENCES medicinas(id);

-- añadir la validacion de clave prymaria al medcamento generico y al medicamenro comercial 
ALTER table equivalencia
ADD PRIMARY KEY (id_generico, id_comercial);


INSERT INTO equivalencia VALUES (1, 9); -- Paracetamol → Finalín
INSERT INTO equivalencia VALUES (1, 10); -- Paracetamol → Panadol
INSERT INTO equivalencia VALUES (1, 11); -- Paracetamol → Tempra
INSERT INTO equivalencia VALUES (2, 12); -- Ibuprofeno → Advil
INSERT INTO equivalencia VALUES (2, 13); -- Ibuprofeno → Motrin
INSERT INTO equivalencia VALUES (3, 14); -- Naproxeno → Aleve
INSERT INTO equivalencia VALUES (3, 15); -- Naproxeno → Flanax
INSERT INTO equivalencia VALUES (4, 16); -- Levotiroxina → Eutirox
INSERT INTO equivalencia VALUES (5, 17); -- Insulina Glargina → Lantus
INSERT INTO equivalencia VALUES (6, 18); -- Amoxicilina → Amoxil
INSERT INTO equivalencia VALUES (7, 19); -- Azitromicina → Zithromax
INSERT INTO equivalencia VALUES (8, 20); -- Ciprofloxacino → Cipro

-- VERIFICACIONES

SELECT * FROM medicinas;
SELECT * FROM clientes;
SELECT * FROM clientesfrecuente;
SELECT * FROM medicinafrecuente;
SELECT * FROM equivalencia;
SHOW DATABASES;
DESC equivalencia;

-- creacion de la tabla datos de la empresa

CREATE TABLE empresa(
    ruc char(13),
    razonsocial VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR (14),
    email VARCHAR(25)
);

INSERT INTO empresa VALUES('1756209837001', 'Salud Total', 'Av. 10 de agosto s/a', '0980596412','alissonchiguano@gmail.com');

SELECT * FROM empresa;


create table facturas(
    facturanumero CHAR(10) PRIMARY key,
    fecha DATE,
    cedula char (10),
    total DECIMAL(15,2)
);

alter table facturas
add constraint facturascedula_fk
Foreign Key (cedula) REFERENCES clientes(cedula);

insert into facturas values('0000000001','2025-12-12', '1715128409', 5.25);
INSERT INTO facturas values ('0000000002','2025-12-13', '1756209837', 5.25);

SELECT * from facturas;

CREATE table facturadetalle(
    facturanumero CHAR(19),
    medicamento_id int,
    cantidad INT,
    precio DECIMAL(15,2)
);


ALTER Table facturadetalle
add PRIMARY KEY (facturanumero, medicamento_id);

alter TABLE facturadetalle
add constraint facturadetalle_cantidad_ck
check (cantidad > 0);

alter TABLE facturadetalle
add constraint facturadetalle_precio_ck
check (precio > 0);

-- VALIDACIONES FACTURA DETALLE
ALTER TABLE facturadetalle
ADD CONSTRAINT facturadetalle_factura_fk
FOREIGN KEY (facturanumero)
REFERENCES facturas(facturanumero);

ALTER TABLE facturadetalle
ADD CONSTRAINT facturadetalle_medicina_fk
FOREIGN KEY (medicamento_id)
REFERENCES medicinas(id);

INSERT INTO facturadetalle VALUES ('0000000001', 9, 12, 2.50);
INSERT INTO facturadetalle VALUES ('0000000001', 1, 5, 1.50);
INSERT INTO facturadetalle VALUES ('0000000002', 3, 2, 1.80);
INSERT INTO facturadetalle VALUES ('0000000002', 5, 6, 15.00);
INSERT INTO facturadetalle VALUES ('0000000002', 6, 3, 1.20);
SELECT * FROM facturadetalle;




-- TABLA PROVEEDOR
CREATE TABLE proveedor (
    ruc CHAR(13) PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(100),
    email VARCHAR(100)
);

-- DATOS DE PROVEEDORES
INSERT INTO proveedor VALUES ('1700000000001', 'Bayer Ecuador', 'Luis Mayorga', 'mayorga@bayer.com');
INSERT INTO proveedor VALUES ('1700000000002', 'HealthCom', 'Andres Zotoz', 'soto@health.com');

SELECT * FROM proveedor;
-- TABLA PROVEEDOR_MEDICINAS
CREATE TABLE proveedor_medicinas (
    proveedor_ruc CHAR(13),
    medicina_id INT,
    proveedor_precio DECIMAL(10,2),
    lote INT,
    plazo INT

);

    -- CLAVE PRIMARIA (evita repetir proveedor con mismo precio)
ALTER table proveedor_medicinas
add PRIMARY KEY (proveedor_ruc, proveedor_precio);

    -- CLAVE FORÁNEA: proveedor debe existir

alter TABLE proveedor_medicinas
add CONSTRAINT proveedor_fk
FOREIGN KEY (proveedor_ruc)
REFERENCES proveedor(ruc);

    -- CLAVE FORÁNEA: medicina debe existir
alter TABLE proveedor_medicinas
add CONSTRAINT medicina_proveedor_fk
FOREIGN KEY (medicina_id)
REFERENCES medicinas(id);

INSERT INTO proveedor_medicinas VALUES ('1700000000001', 1, 0.25, 100, 15);
INSERT INTO proveedor_medicinas VALUES ('1700000000001', 2, 0.12, 200, 30);
INSERT INTO proveedor_medicinas VALUES ('1700000000001', 3, 0.32, 300, 7);
INSERT INTO proveedor_medicinas VALUES ('1700000000002', 2, 0.10, 800, 7);
INSERT INTO proveedor_medicinas VALUES ('1700000000002', 3, 0.30, 250, 7);

SELECT * FROM proveedor_medicinas;

DROP DATABASE saludtotal;

---Atributo email unico en la tabla clientes (es para que no se repita los correos de clientes)
alter table medicinas
add constraint medicinas_uq
UNIQUE (nombre);

INSERT INTO medicinas VALUES (1, 'finalin', 'GEN', 1.50, 50, '2027-01-01 00:00:00');
