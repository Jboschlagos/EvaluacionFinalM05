# 📺 Evaluación Final – Base de Datos Teleseries

## Este proyecto corresponde a la evaluación final de bases de datos y modelamiento Entidad-Relación.
Se parte desde una base de datos inicial no normalizada y se evoluciona hacia un modelo E-R mejorado, con sus respectivas consultas SQL.

### 1️⃣ Base de datos original

El ejercicio original entregó dos tablas independientes:

reparto_soltera_otra_vez

reparto_papi_ricky

Ambas contenían:

nombre del actor

información de participación

sueldo

rol protagónico

Esto generaba duplicación de datos y dificultaba el mantenimiento.

### 2️⃣ Modelo mejorado (Entidad-Relación)

Se diseñó un modelo normalizado, separando entidades y relaciones.

Tablas finales

actores
Información única de cada actor.

teleseries
Registro de las teleseries.

actores_reparto
Relación muchos-a-muchos entre actores y teleseries, con atributos propios de la participación.

Este modelo:

elimina redundancia

cumple 3FN

representa correctamente la realidad del problema

### 3️⃣ Creación de tablas (DDL)
CREATE TABLE actores (
    id_actor SERIAL PRIMARY KEY,
    nombre VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE teleseries (
    id_teleserie SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE actores_reparto (
    id_reparto SERIAL PRIMARY KEY,
    id_actor INT NOT NULL,
    id_teleserie INT NOT NULL,
    temporadas INT,
    capitulos INT,
    protagonico BOOLEAN,
    sueldo INT NOT NULL,
    UNIQUE (id_actor, id_teleserie),
    FOREIGN KEY (id_actor) REFERENCES actores(id_actor),
    FOREIGN KEY (id_teleserie) REFERENCES teleseries(id_teleserie)
);

### 4️⃣ Consultas realizadas
Actores que participaron en ambas teleseries

(con sueldo en cada una y suma total)

SELECT
    s.nombre,
    s.sueldo AS sueldo_soltera,
    p.sueldo AS sueldo_papi_ricky,
    s.sueldo + p.sueldo AS sueldo_total
FROM reparto_soltera_otra_vez s
INNER JOIN reparto_papi_ricky p
ON s.nombre = p.nombre
ORDER BY s.nombre;

Actores exclusivos de Soltera otra vez con sueldo mayor a 90
SELECT s.nombre, s.sueldo
FROM reparto_soltera_otra_vez s
LEFT JOIN reparto_papi_ricky p
ON s.nombre = p.nombre
WHERE p.nombre IS NULL
AND s.sueldo > 90;

Actores con sueldo menor a 85 que actuaron en una sola teleserie
SELECT nombre, sueldo FROM reparto_soltera_otra_vez s
WHERE sueldo < 85
AND NOT EXISTS (
    SELECT 1 FROM reparto_papi_ricky p WHERE p.nombre = s.nombre
)
UNION
SELECT nombre, sueldo FROM reparto_papi_ricky p
WHERE sueldo < 85
AND NOT EXISTS (
    SELECT 1 FROM reparto_soltera_otra_vez s WHERE s.nombre = p.nombre
);

Todas las teleseries con actores de reparto (sin secundarios)
SELECT
    t.nombre AS teleserie,
    a.nombre AS actor
FROM teleseries t
LEFT JOIN actores_reparto ar
    ON t.id_teleserie = ar.id_teleserie
   AND ar.protagonico = true
LEFT JOIN actores a
    ON ar.id_actor = a.id_actor
ORDER BY t.nombre, a.nombre;

## ✅ Conclusión

El trabajo muestra el proceso completo, desde una base inicial simple hasta un modelo E-R correcto, normalizado y funcional, acompañado de consultas SQL que responden a los requerimientos planteados en la evaluación.
