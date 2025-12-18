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

-- consultar los pacientes de medicina frecuente
-- en una lista que incluya:
-- nombre y cedula del paciente, nombre e id de la medicina,
-- descuento

SELECT
    cliente_cedula AS cedula,
    (SELECT nombre from clientes WHERE cedula = cliente_cedula) AS cliente,
    medicina_id AS medicinas,
    (SELECT nombre from medicinas WHERE id = medicina_id)AS nombremedicina,
    descuentos
FROM
    medicinafrecuente;
-- listar los clientes y las medicinas que tienen un descuento
-- menor al descuento que el cliente de la cedula 0102030401

SELECT
    cliente_cedula AS cedula,
    (SELECT nombre from clientes WHERE cedula = cliente_cedula) AS cliente,
    medicina_id AS medicinas,
    (SELECT nombre from medicinas WHERE id = medicina_id)AS nombremedicina,
    descuentos
FROM
  medicinafrecuente
WHERE descuentos < (
                    SELECT descuentos
                    FROM medicinafrecuente
                    WHERE cliente_cedula ='1739988776'
);


SELECT precio 
FROM medicinas 
WHERE id =86;

-- caso: listado de pacientes del plan medicinas frecuete
-- presente en el precio final de la medicina junto
-- con el precio sin descuento 


SELECT
    cliente_cedula AS cedula,

    (SELECT nombre 
     FROM clientes
     WHERE cedula = cliente_cedula) AS paciente,

    medicina_id AS id_medicina,

    (SELECT nombre 
     FROM medicinas 
     WHERE id = medicina_id) AS nombre_medicina,

    (SELECT precio
     FROM medicinas
     WHERE id = medicina_id) AS precio_sin_descuento,

    descuentos AS descuento_porcentaje,
      (
         select precio *(1- descuentos) as precio_final
         from medicinas
         where id = medicina_id
      ) AS precio_final
FROM
    medicinafrecuente;
