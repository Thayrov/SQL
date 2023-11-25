-- ✓ Todos los comentarios sobre juegos desde 2019 en adelante.
SELECT comment_date AS fecha, commentary AS comentario 
FROM commentary WHERE comment_date >= "2019-01-01";

-- ✓ Todos los comentarios sobre juegos anteriores a 2011.
SELECT comment_date AS fecha, commentary AS comentario 
FROM commentary WHERE YEAR(comment_date) <= 2011;

-- ✓ Los usuarios y texto de aquellos comentarios sobre juegos cuyo código de juego (id_game) sea 73
SELECT id_game, id_system_user AS user_id, commentary AS comentario  
FROM commentary WHERE id_game = 73;

-- ✓ Los usuarios y texto de aquellos comentarios sobre juegos cuyo id de juego no sea 73.
SELECT id_game, id_system_user AS user_id, commentary AS comentario 
FROM commentary WHERE id_game != 73 
ORDER BY id_system_user DESC;

-- ✓ Aquellos juegos de nivel 1
SELECT id_level, name FROM game 
WHERE id_level = 1 ORDER BY name ASC;

-- ✓ Aquellos juegos sean de nivel 14, 5 ó 9
SELECT id_level, name FROM game 
WHERE id_level = 14 OR id_level = 5 OR id_level = 9;

-- ✓ Aquellos juegos de nombre ‘Riders Republic’ o ‘The Dark Pictures: House Of Ashes’.
SELECT name, description FROM game 
WHERE name = "Riders Republic" OR name = "The Dark Pictures: House Of Ashes";

-- ✓ Aquellos juegos cuyo nombre empiece con ‘Gran’.
SELECT id_game, name FROM game 
WHERE name LIKE "Gran%";

-- ✓ Aquellos juegos cuyo nombre contenga ‘field’.
SELECT id_game, name FROM game 
WHERE name LIKE "%field%" ORDER BY name ASC;

-- Devuelve el número total de filas seleccionadas en una consulta.
SELECT COUNT(*) AS total_level FROM level_game;

-- Devuelve el valor mínimo de un campo que especifiquemos.
SELECT MIN(id_level) AS min_level FROM level_game;

-- Devuelve el valor máximo de un campo que especifiquemos.
SELECT MAX(id_level) AS max_level FROM level_game;

-- Devuelve la suma de los valores de un campo que especifiquemos
SELECT SUM(value) FROM vote WHERE id_game = 1;

-- Devuelve el valor promedio de un campo que especifiquemos.
SELECT AVG(value) FROM vote WHERE id_game = 1;

-- la cláusula GROUP BY la debemos utilizar cuando debemos obtener información que nace de la agrupación de registros.
SELECT id_system_user AS user, COUNT(*) AS games_by_user
FROM play 
GROUP BY id_system_user;

-- HAVING permite establecer condiciones para filtrar resultados. 
-- Para ello, necesitamos generar campos con resultados filtrados, para luego sumar a HAVING.
-- Esta sentencia solo funciona con campos generados a partir de una función.
SELECT id_system_user AS user, COUNT(*) AS games_by_user
FROM play GROUP BY id_system_user
HAVING COUNT(*) > 1;

-- EJERCICIOS
SELECT * FROM commentary ORDER BY id_system_user desc;

SELECT * FROM commentary ORDER BY id_system_user LIMIT 3;

SELECT COUNT(id_system_user) AS comments, id_system_user 
FROM commentary GROUP BY id_system_user ;

SELECT COUNT(id_system_user) AS comments, id_system_user 
FROM commentary GROUP BY id_system_user 
HAVING comments > 2;


-- INNER JOIN, o JOIN, retorna todas las filas de las dos tablas siempre que haya coincidencia por el campo declarado en el ON.
-- El resultado es NULL cuando no hay coincidencia alguna.
SELECT id_system_user as user, g.id_game as game, name, id_level as level
FROM play p INNER JOIN game g 
ON (p.id_game = g.id_game);

-- LEFT JOIN retorna todas las filas de la tabla izquierda que coincidan con las filas de la tabla derecha
-- El resultado es NULL del lado derecho, cuando no hay coincidencia.
SELECT id_system_user as user, g.id_game as game, name, id_level as level
FROM game g LEFT JOIN play p
ON (p.id_game = g.id_game);

-- RIGHT JOIN retorna todas las filas de la tabla derecha que coincidan con las filas de la tabla izquierda
-- El resultado es NULL cuando no hay coincidencia del lado izquierdo
SELECT id_system_user as user, g.id_game as game, name, id_level as level
FROM play p RIGHT JOIN game g
ON (p.id_game = g.id_game);

-- FULL JOIN retorna todas las filas de la tabla derecha y también las filas de la tabla izquierda.
-- Básicamente combina los resultados de LEFT y RIGHT JOIN, pudiendo tener valores nulo de ambos lados.
-- Nota: MySQL no soporta FULL JOIN.
-- SELECT s.id_system_user as user, g.id_game as game, name, id_level as level FROM system_user s 
-- FULL JOIN play p ON (s.id_system_user = p.id_system_user)
-- FULL JOIN game g ON (p.id_game = g.id_game);


