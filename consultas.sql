-- consulta  s de bases de datos 
SELECT *FROM clientes;
SELECT * FROM medicinas;
SELECT COUNT (*) from clientes;
SELECT COUNT (*) FROM medicinas;

use saludtotal;
-- caso: consultar los datos de un cliente por su numero de cedula 

SELECT *
FROM clientes
WHERE cedula = '1715128409';

-- caso: proyeccion. consultar el email de un cliente por su cedulka 

SELECT
    Correo 
FROM clientes
WHERE cedula = '1715128409';

-- caso: consulta el nombre de un cliente por medio de su cedula 

SELECT
    nombre,
    correo 
FROM clientes
WHERE cedula = '1715128409';

SELECT *
FROM medicinas
WHERE nombre = 'paracetamol';

SELECT
    precio,
    id 
FROM medicinas
WHERE nombre = 'paracetamol';

-- consultar totos los clientes cuyo nombre empiece por laletra A

SELECT
    cedula,
    nombre
FROM clientes
WHERE nombre LIKE 'P%';

SELECT 
    id,
    nombre
FROM medicinas
WHERE nombre like 'F%';

SELECT
    cedula,
    nombre
FROM clientes
WHERE nombre like '%herrera%';
 -- consuklta personas juridicas que tengan como nombre juan 
SELECT 
    cedula,
    nombre, 
    correo
FROM clientes
WHERE tipo = 'JUR'
  AND nombre LIKE '%farmacia%';

SELECT *
FROM clientes
WHERE tipo = 'JUR'
  AND nombre LIKE '%farmacia%';

SELECT *
FROM clientes
WHERE tipo = 'NAT'
  AND nombre LIKE '%juan%';

-- bucar los clietes sea gemail y juridico 
SELECT 
    cedula,
    nombre, 
    correo
FROM clientes
WHERE tipo = 'JUR'
  AND correo LIKE '%@empresa%';

-- en medicinas 
SELECT 
    id,
    nombre
FROM medicinas
WHERE tipo = 'GEN'
  AND NOMBRE LIKE 'P%';

-- operadores logicos de comparacion 
SELECT 
    cedula, 
    nombre, 
    fechanacimiento
FROM clientes
WHERE fechanacimiento < '1990-01-01';

SELECT id, nombre, precio
FROM medicinas
WHERE precio BETWEEN 6 AND 10;

