-- UNION
-- El operador UNION combina los resultados de dos o más consultas, 
-- en un único resultado que incluye todas las filas que pertenecen a todas las consultas que aparecen.
-- Es decir, las consultas se ejecutan por separado, concatenando luego los resultados de cada una.
-- EJEMPLO UNION

SELECT * FROM game WHERE id_level = 1 
UNION 
SELECT * FROM game WHERE id_level = 2;


-- DATOS
-- La clase pasada vimos cómo realizar consultas con WHERE, especificando valores como filtros, 
-- según el tipo de datos almacenado. Con esto notamos que, en SQL, 
-- el tipo de dato a definir en un campo es un punto clave debido a diferentes factores.
-- Por ello, al gestionar nuestras DB debemos establecer reglas de contenidos claras para cada uno de los campos en las tablas.

-- Repaso: principales tipos de datos
-- Tipo de dato      |  valor SQL    |   Ejemplo
-- Número entero     |    int        |    1000
-- Texto             |  text(n)      | Coderhouse
-- Alfanumérico      | varchar(n)    |   AB123CD
-- Fecha 		     |    date       | 21/03/1975
-- Fecha y Hora      |  datetime     | 21/01/1972 15:00:00
-- Verdadero o Falso |   boolean     | TRUE ó FALSE
-- Decimal           | decimal(p, s) | 3008,05
-- Numérico			 | numeric(p, s) | 1407,96

-- Existen muchos otros tipos de datos en SQL pero, por el momento, solo nos manejaremos con los básicos.
-- Éstos nos acompañarán durante todo nuestro período de trabajo. 



-- El operador “LIKE”

-- La clase pasada vimos cómo realizar consultas con WHERE, especificando valores como filtros, 
-- según el tipo de datos almacenado. Con esto notamos que, en SQL, 
-- el tipo de dato a definir en un campo es un punto clave debido a diferentes factores.

-- Por ello, al gestionar nuestras DB debemos establecer reglas de contenidos claras para cada uno de los campos en las tablas.

-- La implementación de este operador se realiza sobre campos del tipo texto o alfanuméricos, 
-- para buscar parte de un valor coincidente. 

-- En combinación con el dato a buscar, se suele utilizar al menos un carácter ‘comodín’, 
-- que oficia de parámetro para encontrar datos ‘que se asimilen a lo escrito’

-- EJEMPLOS LIKE

-- Sobre nuestra tabla GAME debemos traer aquellos registros cuyo nombre del juego comience con FIFA.
SELECT id_game, name FROM game WHERE name LIKE "FIFA%";

-- También podemos combinar el uso de % para obtener parámetros que coincidan con un texto ubicado en cualquier parte del texto almacenado.
SELECT * FROM game WHERE name LIKE "%Ultimate%";

-- Y, por supuesto, podemos buscar también algo más específico, 
-- como ser todos aquellos registros que finalicen con el texto en cuestión sin importar lo que tengan al inicio del mismo.
SELECT * FROM game WHERE name LIKE "%Team";

-- E implementando el caracter comodín “_”, podemos también definir el desconocimiento de un solo caracter. 
-- Se puede combinar con el caracter %.
SELECT * FROM game WHERE name LIKE "_IFA%";

-- En MySQL, puedes usar expresiones regulares (regex) para realizar búsquedas más complejas que las que permite LIKE. 
-- La función para usar regex en MySQL es REGEXP
-- Estas consultas REGEXP proporcionan una mayor flexibilidad 
-- y son útiles para patrones más complejos que no son fácilmente manejables con el operador LIKE.


-- Uso del LIKE con corchetes []
-- Dentro de expresiones regulares, el uso de corchetes nos permite 
-- que el resultado de la búsqueda se limite a un rango inicial determinado de caracteres.
SELECT * FROM game WHERE name LIKE "[A-B]%";

-- También podemos integrar la búsqueda de registros que coincidan con uno o dos caracteres iniciales específicos 
SELECT * FROM system_user WHERE first_name LIKE "[AM]%del%";

-- Exclusión de caracteres
-- Aprovechando el uso de corchetes, también nos podemos ocupar de excluir de los resultados determinados caracteres. 
-- Para ello debemos usar [^]
SELECT * FROM game WHERE name LIKE "[^DV]%";


-- EJERCICIOS

-- Buscaremos usuarios (SYSTEM_USER) utilizando el operador LIKE, y combinando el mismo con las diferentes variantes vistas hasta aquí.
-- Aquellos usuarios cuyo nombre comience con la letra ‘J’
SELECT * FROM system_user WHERE first_name LIKE "J%";
SELECT * FROM system_user WHERE first_name REGEXP '^J';

-- Aquellos usuarios cuyo apellido contenga la letra ‘W’
SELECT * FROM system_user WHERE last_name LIKE "%W%";
SELECT * FROM system_user WHERE last_name REGEXP 'W';

-- Aquellos usuarios cuyo nombre contenga la letra ‘i’ en segundo lugar
SELECT * FROM system_user WHERE first_name LIKE "_I%";
SELECT * FROM system_user WHERE first_name REGEXP '^.{1}i';

-- Aquellos usuarios cuyo nombre finalice con la letra ‘k’
SELECT * FROM system_user WHERE first_name LIKE "%K";
SELECT * FROM system_user WHERE first_name REGEXP 'k$';

-- Aquellos usuarios cuyo nombre no incluya las letras ‘ch’
SELECT * FROM system_user WHERE first_name NOT LIKE '%ch%';
SELECT * FROM system_user WHERE first_name NOT REGEXP 'ch';

-- Aquellos usuarios cuyo nombre solo incluya las letras ‘ch’
SELECT * FROM system_user WHERE first_name LIKE '%ch%';
SELECT * FROM system_user WHERE first_name REGEXP '^ch$';



-- Subconsultas SQL
-- Reglas a tener en cuenta

-- Para poder llevar a cabo esto de manera exitosa, debemos tener en cuenta las siguientes reglas:
-- La subconsulta debe ir entre paréntesis.
-- La subconsulta debe tener una sola columna o expresión.
-- No podemos utilizar BETWEEN o LIKE en la subconsulta.
-- No debemos colocar la cláusula ORDER BY en la subconsulta.
-- Otras cuestiones más con UPDATE y DELETE, que veremos oportunamente cuando abordemos dichos temas.

-- Contamos con dos tablas: SYSTEM_USER y USER_TYPE; necesitamos visualizar aquellos usuarios con el máximo identificador de tipo.
SELECT id_system_user, last_name FROM system_user WHERE id_user_type = (SELECT max(id_user_type) FROM user_type);

-- Subconsultas internas
-- También podemos abordar subconsultas dentro de una misma tabla. 
-- En este caso, la tabla vote cuenta con información del puntaje que cada usuario le dio a un juego en la columna value.
-- Busquemos los usuarios que votaron con un puntaje superior al promedio.
-- Nota: La función floor convierte float a entero.
SELECT id_system_user FROM vote WHERE value = (SELECT FLOOR(AVG(value)) FROM vote);

-- Podemos también obtener los votos totales de un juego específico, por ejemplo el de menor id:
SELECT SUM(value) FROM vote WHERE id_game = (SELECT min(id_game) FROM game);

-- Por supuesto, podemos también sumar otros operadores combinados con WHERE, como ser <, > =>, <=, 
-- para recuperar un conjunto de valores más específico todavía. 
-- Por ejemplo los usuarios que votaron por encima del promedio total de votos.
SELECT id_system_user FROM vote WHERE value > (SELECT avg(value) FROM vote);


-- Ordenamiento de subconsultas SQL

-- Uso de ORDER BY en subconsultas SQL
-- Sabemos que el ordenamiento de la información obtenida a partir de una consulta es clave para mostrar los resultados de forma homogénea.
-- Por ello, la sentencia ORDER BY puede ser utilizada dentro de consultas con subconsultas, 
-- teniendo en cuenta que dicho ordenamiento debe realizarse en la consulta principal.
-- Recordemos que en los casos vistos hasta ahora siempre se ejecuta la subconsulta en primera instancia y una vez resuelta ésta,
-- se ejecuta la consulta. Entonces debemos incluir el orden sobre la consulta más externa.
SELECT id_system_user, last_name FROM system_user WHERE id_user_type = (SELECT max(id_user_type) FROM user_type) 
ORDER BY last_name ASC;

-- Uso de GROUP BY en subconsultas SQL
-- Acoplamos la sentencia GROUP BY dentro de una consulta con subconsulta asociada. 
-- Veamos que nuestro ejemplo presta más información que antes, destacando ahora en qué se desempeña cada uno de ellos
-- Debemos obtener la suma de votos por juego, solo de aquellos juegos de nivel 1. Observemos cómo podemos hacerlo con nuestras tablas
-- Obtener la suma de votos por juego, solo de aquellos juegos de nivel 1.
SELECT id_game, SUM(value) AS votos FROM vote WHERE id_game IN (SELECT id_game FROM game WHERE id_level = 1) 
GROUP BY id_game;

-- Uso de HAVING en subconsultas SQL
-- Veamos cómo integrar consultas con HAVING. Ahora seleccionaremos los juegos pero sólo aquellos que hayan tenido más de un voto. 
-- Seleccionaremos los juegos pero sólo aquellos que hayan tenido más de un voto.
SELECT id_game, name FROM game WHERE id_level = 1 AND id_game IN (SELECT id_game FROM vote GROUP BY id_game HAVING count(*) > 1);



-- Buenas prácticas

-- Usar SELECT * FROM solo si es necesario
-- Usar la cláusula ORDER BY sólo si es necesario
-- Usar UNION ALL en vez de UNION (UNION ALL busca filas duplicadas, mientras que la declaración UNION lo hace independientemente de si existen o no)
-- Usar la cláusula EXISTS donde sea necesario
	-- Si deseamos comprobar la existencia de datos, no es recomendable utilizar:
	-- IF (SELECT COUNT(*) FROM  TABLA WHERE Columna=’Algun Valor’)>0
	-- En su lugar, podemos usar la cláusula EXISTS:
	-- IF EXISTS (SELECT COUNT(*) FROM  TABLA WHERE Columna=’Algun Valor’)
	-- Es más rápido en tiempo de respuesta.

-- EJERCICIOS Subconsultas SQL

-- Llevemos todos los ejemplos hasta aquí aprendidos, a la base de datos GAMER. 
-- Trabajamos con las tablas  combinando consultas y subconsultas que cumplan con el uso de:

-- Juegos jugados por jugador
SELECT sy.first_name, sy.last_name, g.name AS Game_Name FROM system_user sy
JOIN ( SELECT id_system_user, id_game FROM play ) AS played_games ON sy.id_system_user = played_games.id_system_user
JOIN game g ON g.id_game = played_games.id_game;

-- Condicionales en el nombre de los usuarios
SELECT first_name, last_name
FROM system_user
WHERE first_name LIKE 'A%' AND last_name LIKE '%z';

-- Integración de HAVING
SELECT sy.first_name, sy.last_name, COUNT(cm.id_commentary) AS NumberOfComments
FROM system_user sy
JOIN commentary cm ON cm.id_system_user = sy.id_system_user
GROUP BY sy.id_system_user
HAVING COUNT(cm.id_commentary) > 5;

-- Funciones de agregación y GROUP BY
SELECT g.name, AVG(v.value) AS AverageVote
FROM game g
JOIN vote v ON v.id_game = g.id_game
GROUP BY g.id_game;




-- Sublenguaje DDL

-- Las sentencias disponibles a través de DDL, son:
-- CREATE | ALTER | DROP | TRUNCATE
-- Con ellas creamos, modificamos, alteramos y eliminamos objetos.

-- DDL: CREATE
-- La sentencia CREATE cumple la función de crear nuevos objetos en la base de datos.
-- Los tipos de objetos a crear pueden ser: tablas, índices, stored procedures y hasta nuevas bases de datos, además, usuarios específicos. 
-- EJEMPLO
-- CREATE TABLE [nombre de la tabla]([definiciones de columnas]), ([parámetros de la tabla]);

-- DDL: CREATE definición de campos

CREATE TABLE pay (
id_pay 			INT NOT NULL AUTO_INCREMENT,
amount 			REAL NOT NULL,
currency 		VARCHAR(20) NOT NULL,
date_pay 		DATE NOT NULL,
pay_type 		VARCHAR(50),
id_system_user INT NOT NULL,
id_game 		INT NOT NULL),
([parámetros de la tabla]));

-- Sentencia DDL ALTER
-- Veamos a continuación cómo podemos agregar un campo a la una tabla ya creada 
-- ALTER TABLE [nombre de la tabla] ADD [definiciones de columnas];
-- Agreguemos a continuación un campo en nuestra tabla friend. El mismo se llamará age y será del tipo INT.
ALTER TABLE friend ADD age INT;
-- DDL: ALTER [modify]
-- Si deseamos modificar los valores para un campo existente, debemos reemplazar la instrucción ADD por MODIFY.
ALTER TABLE friend MODIFY email VARCHAR(50) NOT NULL;
-- Otras operaciones con ALTER TABLE
-- CHANGE COLUMN: podemos cambiar el nombre de una columna previamente definida.
-- RENAME TO: podemos cambiar el nombre inicial de una tabla por uno nuevo.
-- DROP COLUMN: podemos eliminar una columna o campo.

-- DDL: DROP (table)
-- La sentencia DROP, del inglés “borrar”, nos permite eliminar una tabla.
DROP TABLE friend;
-- Dado que este tipo de actividad es poco frecuente, recomendamos siempre contemplar estas dos opciones:
-- utilizar la sentencia USE “schema”.
-- clonar la tabla si tiene datos y luego eliminarla.

-- DDL: use SCHEMA
-- En entornos de trabajo muchas veces saltamos entre diferentes ambientes de DB de forma constante, 
-- lo que puede ocasionar que nos encontremos en el ambiente erróneo al momento de eliminar la tabla.
USE GAMER;
DROP TABLE [tabla a eliminar];

-- DDL: clonar tabla
-- Si no estamos 100% seguros de si eliminar la tabla no afectará la necesidad de su información, 
-- podemos clonar, previamente, usando la sentencia:
CREATE TABLE friend_backup LIKE friend;

-- Tablas y relaciones
-- Las relaciones entre tablas son un factor dominante al momento del uso de DROP TABLE. 
-- Si la tabla tiene definida una o más relaciones con otras, primero deberemos eliminarlas para luego proceder con DROP.
-- El motor de base de datos impedirá que podamos borrarla a menos que utilicemos la cláusula de DROP CASCADE

-- Sentencia DDL TRUNCATE
-- La sentencia TRUNCATE TABLE elimina todos los datos que estén almacenados dentro de la tabla definida.
-- Si bien existe la sentencia DELETE, propia de DML, TRUNCATE garantiza una mayor velocidad de borrado de datos. 
USE “schema”; 
TRUNCATE TABLE friend;

-- Tablas y relaciones
-- Al igual que lo visto con la sentencia DROP, las relaciones entre tablas son un factor dominante al momento del uso de TRUNCATE TABLE.
-- No podremos borrar datos que estén vinculados a otros datos de otra tabla


-- Buenas prácticas 

-- 1. Utilizar tipo de datos adecuado
-- 2. Usar CHAR (1) sobre VARCHAR (1)
-- 3. Usar el tipo de datos CHAR para almacenar solo datos de longitud fija
-- 4. Evitar el uso de formatos de fecha regionales


-- Funciones escalares
-- Al igual que los lenguajes de programación en general, SQL incluye una serie de funciones denominadas Funciones Escalares.
-- Permiten manipular datos cuando los recuperamos o antes de guardarlos, 
-- mediante operaciones predeterminadas, devolviendo un resultado específico acorde a lo esperado.
-- Algunas ventajas de implementarlas, son:
-- Reducir el re-trabajo de la lógica comercial.
-- Evitar la inconsistencia de datos que provenga de un software.
-- Ayudar a reducir el tráfico de red de aplicaciones cliente/servidor.
-- Mejorar en gran medida el rendimiento de los sistemas.
-- Existen dos tipos de funciones escalares en Mysql:
-- Funciones integradas
-- Funciones almacenadas
-- Trabajaremos en esta instancia con las funciones integradas.
-- Se clasifican bajo las siguientes categorías:
-- Funciones de cadenas.
-- Funciones numéricas.
-- Funciones de fecha.
-- Funciones agregadas.

-- Funciones de cadena
-- Nos permiten operar con cualquier tipo de cadena de caracteres almacenada en una tabla (o por almacenarse).
-- Podemos, entre otras cosas: convertir el texto a mayúsculas, minúsculas, concatenar strings, 
-- cortar una porción del texto, eliminar espacios, revertir el texto, contar caracteres, entre decenas de más funciones.

-- Ejemplos: CONCAT()
-- Fusiona cadenas de caracteres en un único bloque de datos.
-- Podemos, por ejemplo, unificar en un campo llamado complete_name, los campos first_name y last_name de la tabla SYSTEM_USER.
SELECT concat(first_name, last_name) AS complete_name FROM system_user;

-- Ejemplos:  UCASE() / LCASE()
-- Convierte a mayúsculas o minúsculas (respectivamente) una cadena de texto.
SELECT UCASE(description) FROM class; -- devolverá, por ejemplo: “ACTION”
SELECT LCASE(description) FROM class; -- devolverá, por ejemplo: “action”

-- Ejemplos: REVERSE()
-- Revierte el orden de los caracteres de una cadena de texto.
SELECT REVERSE(description) FROM class; -- devolverá, por ejemplo: “noticia”

-- Aquí tienes otras opciones para el manejo de caracteres:
-- TRIM(): elimina los espacios vacíos en los extremos de un texto.
-- SPACE(): cuenta la cantidad de espacios en un bloque de texto.
-- CHAR_LENGTH(): cuenta los caracteres de un bloque de texto.
-- SUBSTRING(): extrae uno o más caracteres de un bloque de texto.

-- Funciones numéricas
-- Nos permiten operar con cualquier tipo de número, a su vez, se subdividen en dos segmentos:
-- Operadores aritméticos: para realizar operaciones matemáticas básicas.
-- Funciones matemáticas: para realizar conversiones y otras operaciones con números de mayor complejidad.

-- Ejemplo: operaciones aritméticas

-- División
SELECT (21 / 3) AS resultado;
-- Multiplicación
SELECT (7 * 3) AS resultado;
-- Suma
SELECT (18 + 3) AS resultado;
-- Resta
SELECT (30 - 9) AS resultado;

-- Ejemplo: funciones matemáticas

-- log(), log2(), log10(): cálculo de logaritmos, base 2 y base 10.
-- round(): redondeo estándar de un número.
-- floor(): redondeo de un número hacia abajo.
-- ceiling(): redondeo de un número hacia arriba.
-- truncate(): elimina los decimales de un número.


-- Funciones de fechas

-- Podemos manipular cualquier tipo de cálculo con fechas:
-- Obtener los días ocurridos entre determinadas fechas.
-- El número del día de un año.
-- Extraer el mes, el año, o día de la fecha actual.
-- Saber qué día de la semana fue una determinada fecha.

-- Algunas funciones de fechas
-- curdate(): devuelve la fecha actual.
-- curtime(): devuelve la hora actual.
-- now(): combina los dos anteriores en un resultado.
-- datediff(): obtiene la diferencia de tiempo entre dos fechas.
-- dayname(): Retorna el nombre del día de semana de una fecha determinada.


-- EJERCICIOS
-- Implementar funciones escalares
-- Abrir una pestaña de consulta (query tab), y ejecuta las siguientes funciones:

-- concatena tu nombre completo (respetando los espacios)
SELECT CONCAT('Thayrov', ' ', 'García') AS NombreCompleto;

-- convierte tu nombre completo a minúsculas, luego a mayúsculas
SELECT LOWER('Thayrov García') AS NombreEnMinusculas, UPPER('Thayrov García') AS NombreEnMayusculas;

-- Divide tu año de nacimiento por tu día y mes (ej: 1975 / 2103)
SELECT (1990 / 1504) AS ResultadoDivision;

-- Convierte en un entero absoluto el resultado anterior
SELECT ABS(1990 / 1504) AS EnteroAbsoluto;

-- Calcula los días que pasaron desde tu nacimiento hasta hoy
SELECT DATEDIFF(CURDATE(), '1990-04-15') AS DiasDesdeNacimiento;

-- Averiguar qué día de semana era cuando naciste
SELECT ELT(DAYOFWEEK('1990-04-15'), 'Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado') AS DiaDeLaSemana;


