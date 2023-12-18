-- Vistas SQL
-- Una Vista SQL es básicamente una tabla virtual que se genera a partir de la ejecución de una o más consultas SQL, aplicada sobre una o más tablas.
-- Su estructura corresponde a una serie de filas y columnas tal como encontramos en las tablas SQL, que almacenan la vista de la información tal como la definimos al crearla.
-- 
-- Vistas: sintaxis
-- Su sintaxis está compuesta por:
-- La sentencia CREATE VIEW
-- El nombre que deseamos darle a la Vista
-- Las columnas que se crearán
-- La consulta SQL desde donde obtendrá los datos
-- CREATE VIEW nombre_vista [lista_columnas] AS consulta_sql
-- 
-- Vistas: sintaxis extendida
-- Su sintaxis está compuesta por:
-- La sintaxis CREATE VIEW cuenta con un modificador (opcional) denominado OR REPLACE. 
-- Esta sintaxis se ocupa de, crear la Vista si no existe, o reemplazar la existente por una nueva.
-- CREATE VIEW OR REPLACE nombre_vista [lista_columnas] AS consulta_sql
-- 
-- Vistas: beneficios
-- Privacidad de la información: los usuarios podrán ver sólo aquellos datos que creamos convenientes mostrar, en otras palabras, mejora la seguridad de la DB.
-- Rendimiento de la DB: Crear queries sobre vistas complejas nos ahorra ejecutar una query pesada para llegar a la información.
-- Protección de datos: Aquellos usuarios que no poseen un entorno de pre-producción, las vistas evitan errores de borrado o alteración.
-- 
-- Vistas: protección de datos
-- Construir vistas facilitan el acceso a mucha información además de ser la opción más práctica y segura para proteger la información de las tablas.
CREATE VIEW games AS
SELECT
  *
FROM
  game;

SELECT
  *
FROM
  games;

-- Tipos de vistas
-- Visualizar solo nombres y descripciones de los videojuegos
CREATE
OR REPLACE VIEW games AS (
  SELECT
    name,
    description
  FROM
    game
);

SELECT
  *
FROM
  games;

-- Visualizar solo los videojuegos con nombre “Call of duty”
CREATE
OR REPLACE VIEW games AS (
  SELECT
    name,
    description
  FROM
    game
  WHERE
    name like upper('%Call of Duty%')
);

SELECT
  *
FROM
  games;

-- Crear una vista ya existente
-- Nos encontraremos con un error que arrojará MySQL directamente en el panel Action Output, alertando que la Vista que deseamos crear, ya existe.
--
-- La sentencia ON REPLACE
-- Esta sentencia nos permite reemplazar la Vista existente.
-- Para sobre escribir Vistas con una nueva consulta, debemos agregar la sentencia OR REPLACE.
-- De esta manera, MySQL sobre escribirá directamente la Vista existente con el código de esta nueva Vista generada. Tengamos precaución porque MySQL no advertirá la operación de sobre-escritura.
--
--Aplicar filtros a una vista
-- Las Vistas, una vez creadas, pueden ser tratadas tal como si fuesen una tabla, por ejemplo aplicando un orden a la misma.
CREATE
OR REPLACE VIEW games AS (
  SELECT
    name,
    description
  FROM
    game
  ORDER BY
    name DESC
);

SELECT
  *
FROM
  games;

--Aplicar filtros a una vista
--Si aplicamos una cláusula WHERE y/u ORDER BY, veremos que los datos de la Vista, se listaran tal como lo indicamos en la consulta de selección. 
--Por lo tanto, ¡en las vistas podemos aplicar todas las operaciones que vimos sobre tablas!
CREATE
OR REPLACE VIEW games AS (
  SELECT
    name,
    description
  FROM
    game
  WHERE
    name LIKE '%You%'
  ORDER BY
    name DESC
);

SELECT
  *
FROM
  games;

-- Crear una vista con más de una tabla
-- Realicemos una viste que liste los nombres y descripción de los distintos videojuegos que ningún usuario ha podido completar.
CREATE
OR REPLACE VIEW games AS (
  SELECT
    DISTINCT name,
    description
  FROM
    game v
    JOIN PLAY p ON (v.id_game = p.id_game)
  where
    p.completed = false
);

SELECT
  *
FROM
  games;

-- Modificar una vista existente
-- Las Vistas ya creadas, pueden ser modificadas de forma rápida, recurriendo a 
-- menú contextual > Alter View... 
-- El código de la Vista será editado en una pestaña de Script.
-- Aplicando las modificaciones necesarias sobre este código, podremos ejecutarlo a través del botón Apply.
CREATE ALGORITHM = UNDEFINED DEFINER = 'root' @'localhost' SQL SECURITY DEFINER VIEW `games` AS
SELECT
  DISTINCT `v`.`name` AS `name`,
  `v`.`description` AS `description`
FROM
  (
    `game` `v`
    JOIN `play` `p` ON ((`v`.`id_game` = `p`.`id_game`))
  )
WHERE
  (`p`.`completed` = FALSE);

--Si vamos a mantener el nombre de la Vista, tal cual existía, recordemos agregar a la sentencia CREATE VIEW, el comando OR REPLACE, para que los cambios se sobre-escriban correctamente.
--
--
-- Eliminar una vista
-- También contamos con la posibilidad de eliminar aquellas Vistas que ya no utilizamos, haciendo uso del comando:
-- DROP VIEW <nombreDeLaVista>.
-- Ten presente que la eliminación, mediante un script, será instantánea.
DROP VIEW vista_productos;