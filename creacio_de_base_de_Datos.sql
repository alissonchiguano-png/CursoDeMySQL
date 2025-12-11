-- Creo la base de datos 
CREATE DATABASE saludtotal;

-- seleccionamos la base de datos 
USE saludtotal;


-- TABLA MEDICINAS (Genericas y comerciales)

CREATE TABLE medicinas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo CHAR(3),   -- GEN = genérico, COM = comercial
    precio DECIMAL(15,2),
    stock INT,
    fechacaducidad DATETIME
);

-- inserto las medicinas genericas 

INSERT INTO medicinas VALUES (1, 'Paracetamol', 'GEN', 1.50, 50, '2027-01-01 00:00:00');
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
    medicina_id INT
);

-- inserto los clientes 
INSERT INTO clientes VALUES ('1715128409', 'Kevin Rodriguez', '2002-11-06', 1);
INSERT INTO clientes VALUES ('1756209837', 'Juan Perez', '2002-11-06', 2);
INSERT INTO clientes VALUES ('1756986547', 'Roger Tallana', '2002-11-06', 3);
INSERT INTO clientes VALUES ('1745792364', 'Erik Analuisa', '2005-09-06', 1);
INSERT INTO clientes VALUES ('1790012345', 'Carlos Andrade', '1999-03-15', 4);
INSERT INTO clientes VALUES ('1785567890', 'Daniela López', '2000-07-21', 5);
INSERT INTO clientes VALUES ('1764433221', 'Sofia Molina', '1997-01-11', 6);
INSERT INTO clientes VALUES ('1751122334', 'Jorge Ruiz', '1985-11-30', 7);
INSERT INTO clientes VALUES ('1739988776', 'María Torres', '1994-06-18', 8);
INSERT INTO clientes VALUES ('1723349876', 'Pedro Castillo', '1988-09-22', 4);
INSERT INTO clientes VALUES ('1717723456', 'Elena Salinas', '2001-12-01', 5);
INSERT INTO clientes VALUES ('1709988775', 'Luis Guerrero', '1995-02-10', 6);
INSERT INTO clientes VALUES ('1795566123', 'Andrea Paredes', '1990-03-26', 7);
INSERT INTO clientes VALUES ('1784455667', 'Mónica Herrera', '1993-08-09', 8);


-- TABLA CLIENTES FRECUENTES

CREATE TABLE clientesFrecuente (
    cedula CHAR(10),
    medicina_id INT,
    condicion VARCHAR(100),
    frecuencia CHAR(3),
    descuento DECIMAL(5,2)    -- 10% = 0.10
);
-- inserto lpos clienyes frecuentes
INSERT INTO clientesFrecuente VALUES ('1715128409', 4, 'Hipertensión',      'men', 0.10);
INSERT INTO clientesFrecuente VALUES ('1756209837', 5, 'Diabetes Tipo 2',   'men', 0.05);
INSERT INTO clientesFrecuente VALUES ('1715227401', 6, 'Asma',              'sem', 0.08);
INSERT INTO clientesFrecuente VALUES ('1723345689', 7, 'Colesterol alto',   'cri', 0.07);
INSERT INTO clientesFrecuente VALUES ('1715567834', 8, 'Hipotiroidismo',    'sem', 0.06);


-- TABLA MEDICINA FRECUENTE

CREATE TABLE medicinafrecuente (
    cliente_cedula CHAR(10),
    medicina_id INT,
    frecuencia CHAR(3),
    descuentos DECIMAL(5,2)
);
-- añadir validacion de clave foranea a la cedula del cliente
ALTER TABLE medicinafrecuente
ADD CONSTRAINT clientecedula_fk FOREIGN KEY (cliente_cedula)
REFERENCES clientes(cedula);
-- añadir validacion de clave foranea a la medicina del cliente 
ALTER TABLE medicinafrecuente
ADD CONSTRAINT medicina_fk FOREIGN KEY (medicina_id)
REFERENCES medicinas(id);

-- añadir la validacion de clave prymaria de la cedula y medicina 
ALTER table medicinafrecuente
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

