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
WHERE nombre like 'v%';


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


    -- mismo caso pero ahora con producto carteciano JOIN
SELECT
    medicinafrecuente.cliente_cedula AS cedula,
    clientes.nombre AS paciente,
    medicinafrecuente.medicina_id AS id_medicina,
    medicinas.nombre AS nombre_medicina,
    medicinas.precio AS precio_sin_descuento,
    medicinafrecuente.descuentos AS descuento_porcentaje,
    medicinas.precio * (1 - medicinafrecuente.descuentos) AS precio_final
FROM
    medicinafrecuente
JOIN
    clientes
        ON medicinafrecuente.cliente_cedula = clientes.cedula
JOIN
    medicinas
        ON medicinafrecuente.medicina_id = medicinas.id;


-- caso: las medicinas cmerciales pueden ser remplazadas por 
--       sus correspondietes medicinas génericas.
--       Elaborar un listado que compare el precio de la medicina comercial
--       con su equivalencia genérico
SELECT
    

    (SELECT nombre 
     FROM medicinas 
     WHERE id = id_comercial) AS medicina_comercial,

    (SELECT precio 
     FROM medicinas 
     WHERE id = id_comercial) AS precio_comercial,

    (SELECT nombre 
     FROM medicinas 
     WHERE id = id_generico) AS medicina_generica,

    (SELECT precio 
     FROM medicinas 
     WHERE id = id_generico) AS precio_generico,
    (
        (SELECT precio FROM medicinas WHERE id = id_comercial)
        -
        (SELECT precio FROM medicinas WHERE id = id_generico)
    ) AS ahorro

FROM
    equivalencia;

-- mismo caso de con join
SELECT
    medicinas_comercial.nombre AS medicina_comercial,
    medicinas_comercial.precio AS precio_comercial,

    medicinas_generica.nombre AS medicina_generica,
    medicinas_generica.precio AS precio_generico,

    medicinas_comercial.precio - medicinas_generica.precio AS ahorro
FROM
    equivalencia
JOIN
    medicinas AS medicinas_comercial
        ON equivalencia.id_comercial = medicinas_comercial.id
JOIN
    medicinas AS medicinas_generica
        ON equivalencia.id_generico = medicinas_generica.id;


-- caso: crear todas las combinaciones posibles entre la tabla 
-- de clientes y la tabla de medicinafrecuente
-- PRODUCTO CARTECIANO 

SELECT *
FROM clientes,
  medicinafrecuente
WHERE
  clientes.cedula = medicinafrecuente.cliente_cedula;

SELECT c.cedula, c.nombre, m.nombre, mf.descuentos,m.tipo
FROM medicinafrecuente mf
JOIN clientes c on c.cedula = mf.cliente_cedula
JOIN medicinas m on  m.id = mf.medicina_id
WHERE m.tipo = 'COM';
-- and c.cedula =mf.cliente_cedula
-- and m.tipo = 'COM';

-- caso: nombres de comerciales y nombres de genericos 


SELECT
    mc.nombre medicina_comercial,
    mc.precio precio_comercial,

    mg.nombre medicina_generica,
    mg.precio precio_generico,

    mc.precio - mg.precio ahorro
FROM equivalencia e
JOIN medicinas mc
    ON e.id_comercial = mc.id
JOIN medicinas mg
    ON e.id_generico = mg.id;

-- caso: presentar una factura y sus detalles, que incluya,
-- los datos de la farmacia: nombre, ruc, ...
-- los del cliente: ....
-- los datos de la cabecera de la factura: nomero, fecha
-- las medicinas vendidas: nombre medicina, id, cant, precio, subtotal
-- los datosn al pie de la factura: total y la forma de pago 

-- 1. Carga de datos en la factura cabecera y detalles 
-- usar los datos ya existentes 
-- 2. select para los detalles de la factura 
-- 3. select para los detalles de la factura 
-- 4. select para el pie de la fatura 

SELECT 
    'FARMACIA SALUD TOTAL' titulo,
    razonsocial nombre_farmacia,
    ruc,
    direccion,
    telefono,
    email
FROM empresa;


SELECT 
    c.nombre nombre_cliente,
    c.cedula,
    c.direccion,
    c.telefono,
    c.correo,
    f.facturanumero numero_factura,
    f.fecha
FROM facturas f
JOIN clientes c ON f.cedula = c.cedula
WHERE f.facturanumero = '0000000001';
 

SELECT 
    m.nombre nombre_medicina,
    m.id id_medicina,
    fd.cantidad,
    fd.precio precio_unitario,
    (fd.cantidad * fd.precio) subtotal
FROM facturadetalle fd
JOIN medicinas m ON fd.medicamento_id = m.id
WHERE fd.facturanumero = '0000000001';

SELECT 
    SUM(fd.cantidad * fd.precio) subtotal,
    'efectivo' forma_pago
FROM facturadetalle fd
JOIN medicinas m ON fd.medicamento_id = m.id
WHERE fd.facturanumero = '0000000001';

SELECT
*
from medicinas
WHERE id not in 
(
    SELECT medicina_id from clientesfrecuente
);

SELECT
*
from medicinas m
join clientesfrecuente cf on m.id = cf.medicina_id;


SELECT
*
from clientesfrecuente cf
left join medicinas m on m.id = cf.medicina_id;


-- caso:lista ordenada de clientes por nombre alfabetico 

SELECT * from clientes
ORDER BY fechanacimiento;

-- caso: cliente mas joven 
SELECT  nombre, fechanacimiento
from clientes
ORDER BY fechanacimiento 
DESC LIMIT 1;
-- caso:conocer las 5 medicinas mas caras que tenemos 
use saludtotal;
SELECT id, nombre, precio
FROM medicinas
ORDER BY precio DESC
LIMIT 5;

-- caso: conocer las 5 medicinas mas baratas 
SELECT id, nombre, precio
FROM medicinas
ORDER BY precio 
LIMIT 5;

-- caso: la medicina comercial mas barata 
SELECT id, nombre, precio
FROM medicinas
WHERE tipo = 'COM'
ORDER BY precio 
LIMIT 1;

-- caso: la medicina generica mas cara
SELECT id, nombre, precio
FROM medicinas
WHERE tipo = 'GEN'
ORDER BY precio DESC
LIMIT 1;

-- caso: las 5 medicinas comerciales con el menor descuento

SELECT * from clientesfrecuente WHERE medicina_id=4;
INSERT INTO clientesFrecuente VALUES ('0102030401', 4, 'Hipertensión', 'men', 0.10);
SELECT
    nombre,
    precio,
    descuentos
FROM clientesfrecuente 
WHERE tipo = 'COM'
ORDER BY descuentos;

SELECT nombre
FROM medicinas
WHERE id in (
    SELECT id
    FROM medicinafrecuente
    JOIN medicinas on id = medicina_id
    WHERE tipo = 'COM'
    order by descuentos 
    );

use saludtotal;
SELECT DISTINCT
    m.id,
    m.nombre,
    m.precio,
    mf.descuentos
FROM medicinafrecuente mf
JOIN medicinas m
    ON mf.medicina_id = m.id
WHERE id in (
    SELECT id
    FROM medicinafrecuente
    JOIN medicinas on id = medicina_id
    WHERE tipo = 'COM'
    )
order by descuentos 
LIMIT 5;

-- caso: agrupamientos
SELECT tipo, COUNT(*) AS numero 
FROM clientes
GROUP BY tipo;

DESC medicinas;

SELECT id, nombre, precio, stock,
precio *stock 
FROM medicinas;

SELECT tipo,
SUM (precio * stock)
FROM medicinas
GROUP BY tipo;

-- caso facturas detalle. Valor monerario por medicina vendida
select medicamento_id, cantidad, precio, 
cantidad * precio as subtotal 
FROM facturadetalle
ORDER BY medicamento_id;

SELECT fd.medicamento_id, m.nombre,
SUM(fd.cantidad * fd.precio)
FROM facturadetalle fd
JOIN medicinas m ON m.id =fd.medicamento_id
GROUP BY medicamento_id
ORDER BY medicamento_id;

-- caso: mejor cliente de la farmacia
SELECT
    c.cedula,
    c.nombre,
    SUM(fd.cantidad * fd.precio) AS total_comprado
FROM clientes c
JOIN facturas f
    ON c.cedula = f.cedula
JOIN facturadetalle fd
    ON f.facturanumero = fd.facturanumero
GROUP BY c.cedula, c.nombre
ORDER BY total_comprado DESC
LIMIT 1;

-- caso: proyecion dde la venta total del stock, tomando en cuenta 
-- el descuento para las medicinas del plan de medicina frecuente
use saludtotal;
SELECT id, nombre, precio, stock,
precio * stock 
FROM medicinas;

use saludtotal;

CREATE VIEW v_proyeccion_ventas 
AS
SELECT 
    m.id,
    m.nombre,
    m.precio,
    m.stock,
    mf.descuentos,
    m.precio * (1 - mf.descuentos/100) AS nuevo_precio
FROM medicinas m
JOIN medicinafrecuente mf 
    ON m.id = mf.medicina_id

UNION

SELECT 
    m.id,
    m.nombre,
    m.precio,
    m.stock,
    0 AS descuentos,
    m.precio AS nuevo_precio
FROM medicinas m
WHERE m.id is null;

-- caso: 

SELECT
sum(nuevo_precio * stock)  
FROM 
v_proyeccion_ventas;
 -- averiguar que medicinas vencen en el proyimo mes


SELECT
    id,
    nombre,
    fechacaducidad
FROM medicinas
WHERE fechacaducidad >= DATE_ADD(LAST_DAY(CURDATE()), INTERVAL 1 DAY)
  AND fechacaducidad <= LAST_DAY(DATE_ADD(CURDATE(), INTERVAL 1 MONTH))
ORDER BY fechacaducidad;

-- cronograma de vencimientos a 3 meses vista 

CREATE VIEW vista_cronograma_vencimientos AS
SELECT
    id,
    nombre,
    fechacaducidad,
    'Enero' AS mes_vencimiento
FROM medicinas
WHERE fechacaducidad >= DATE_ADD(LAST_DAY(CURDATE()), INTERVAL 1 DAY)
  AND fechacaducidad <= LAST_DAY(DATE_ADD(CURDATE(), INTERVAL 1 MONTH))

UNION

SELECT
    id,
    nombre,
    fechacaducidad,
    'Febrero' AS mes_vencimiento
FROM medicinas
WHERE fechacaducidad >= DATE_ADD(LAST_DAY(DATE_ADD(CURDATE(), INTERVAL 1 MONTH)), INTERVAL 1 DAY)
  AND fechacaducidad <= LAST_DAY(DATE_ADD(CURDATE(), INTERVAL 2 MONTH))

UNION


SELECT
    id,
    nombre,
    fechacaducidad,
    'Marzo' AS mes_vencimiento
FROM medicinas
WHERE fechacaducidad >= DATE_ADD(LAST_DAY(DATE_ADD(CURDATE(), INTERVAL 2 MONTH)), INTERVAL 1 DAY)
  AND fechacaducidad <= LAST_DAY(DATE_ADD(CURDATE(), INTERVAL 3 MONTH));

SELECT *
FROM vista_cronograma_vencimientos
ORDER BY fechacaducidad;



