
-- CREACIÓN DE TABLAS 

CREATE TABLE friend( 
	id INT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    troop INT,
    PRIMARY KEY(id)
);

CREATE TABLE troops( 
	id INT,
    description VARCHAR(45),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES friend(id)
);

-- AGREGANDO DATOS

INSERT INTO friend(id, first_name, last_name, troop) VALUES
(1, 'Rick', 'Hunter', 2),
(2, 'Roy', 'Fokker', 2),
(3, 'Max', 'Sterling', 2),
(4, 'Kramer', 'Key', 2),
(5, 'Mirya', 'Sterling', 2),
(6, 'Ben', 'Dixon', 1);


INSERT INTO troops(id, description) VALUES
(1, 'Vermillion'),
(2, 'Skull');

-- CREANDO, CONSUMIENDO Y ELIMINANDO VISTAS

CREATE VIEW friends_view AS SELECT * FROM friend;
SELECT * FROM friends_view;
DROP VIEW friends_view;

-- FUNCIONES
	-- Aceptan sólo parámetros de entrada:
	-- Deben retornar siempre un valor con un tipo de dato definido.
	-- Pueden usarse en el contexto de una sentencia SQL.
	-- Retornan un valor individual, y nunca un conjunto de registros.

CREATE FUNCTION count_troops (id_troop INT)
RETURNS INT
DETERMINISTIC
RETURN (SELECT COUNT(*) FROM friend WHERE troop = id_troop);

SELECT count_troops(2);

-- Trigger
	-- Un trigger es una aplicación almacenada (stored program), 
    -- creado para ejecutarse cuando uno o más eventos ocurran 
    -- en nuestra base de datos.
	-- El trigger se dispara cuando ocurre un comando INSERT, UPDATE o DELETE, 
    -- ejecutando un bloque de instrucciones que proteja o prepare 
    -- la información de las tablas.
	-- La principal tarea de un trigger es la de mantener la integridad de una bb.dd. 
    -- aplicando los siguientes casos de uso:
		-- Validar la información
		-- Calcular atributos derivados
		-- Seguir movimientos y Logs

DELIMITER $$

CREATE TRIGGER tr_troops_default_description
BEFORE INSERT
ON troops FOR EACH ROW
BEGIN
  IF NEW.description is null THEN
    SET NEW.description = 'default description';
  END IF;
END$$

DELIMITER ;

INSERT INTO troops (id, description) VALUES (3, null);
SELECT * FROM troops;

-- STORE PROCEDURES
	-- Los procedimientos almacenados (stored procedures) son parte de MySql desde su versión 5.0.
	-- Conforman un conjunto de instrucciones escritas en Transact-SQL para realizar una tarea determinada,
	-- pudiendo ser esta una operación simple de resolver, o una serie encadenada de tareas complejas.
	-- Son especialmente útiles cuando:
		-- Varias aplicaciones deben realizar una misma consulta.
		-- Existen entornos donde la seguridad es importante.
		-- Los S.P. se almacenan en el apartado homónimo del esquema visible en MySql Workbench.
	-- La ejecución de un Stored Procedure no está disponible para cualquier usuario. 
    -- Es necesario que el perfil de éste, en el esquema de base de datos, 
    -- tenga habilitado el permiso de ejecución (Execute).
    -- Un SP puede contener y ejecutar en su interior cualquier consulta del tipo DML. 
    -- Incluso puede combinar varias de estas, aplicándolas en diferentes tablas.
    -- Estructura:
		-- Se inicia con el comando CREATE PROCEDURE nombre_sp. 
        -- Recibe parámetros del tipo IN, OUT e INOUT y soporta tipos de datos válidos.
		-- Y a su vez, los SP pueden tener dos tipos de denominación:
        -- Determinista.
        -- No determinista.
    -- Ingresa aquí tu teléfono, da clic en Enviar [ 4432037355 ] y en breve uno de nuestros ejecutivos te contactará.

DELIMITER $$
CREATE PROCEDURE country_hos (d VARCHAR(45))
  BEGIN
  SELECT *
  FROM troops
  WHERE description = d;
END $$
DELIMITER ;

CALL country_hos('Skull');

-- TABLAS TRANSACCIONALES    


-- Crear una tabla transaccional con el motor InnoDB
CREATE TABLE ejemplo_transaccional (
    id INT PRIMARY KEY,
    dato VARCHAR(100),
    cantidad INT
) ENGINE=InnoDB;

-- Iniciar una transacción
START TRANSACTION;

-- Insertar un registro en la tabla
INSERT INTO ejemplo_transaccional (id, dato, cantidad) VALUES (1, 'Test', 100);

-- Actualizar un registro en la tabla
UPDATE ejemplo_transaccional SET cantidad = cantidad + 50 WHERE id = 1;

-- Si todo está correcto, se confirman los cambios
COMMIT;

-- Si hay un error y queremos revertir los cambios, usamos ROLLBACK
-- ROLLBACK;

-- Notas:
-- COMMIT hace que los cambios sean permanentes.
-- ROLLBACK deshace todos los cambios desde el inicio de la transacción.




-- TABLAS DE HECHO 

-- Crear una tabla de hecho para almacenar datos transaccionales para análisis de BI
CREATE TABLE ventas_hecho (
    -- Claves foráneas de las dimensiones
    fecha_id INT,
    producto_id INT,
    tienda_id INT,
    empleado_id INT,
    
    -- Métricas numéricas de la transacción
    unidades_vendidas INT,
    ventas_brutas DECIMAL(10, 2),
    coste_producto DECIMAL(10, 2),
    ganancia DECIMAL(10, 2),
    
    -- Definir las claves foráneas (suponiendo que las tablas de dimensiones ya existen)
    FOREIGN KEY (fecha_id) REFERENCES fechas_dimension(id),
    FOREIGN KEY (producto_id) REFERENCES productos_dimension(id),
    FOREIGN KEY (tienda_id) REFERENCES tiendas_dimension(id),
    FOREIGN KEY (empleado_id) REFERENCES empleados_dimension(id)
    
    -- Otras configuraciones podrían incluir índices para mejorar el rendimiento de las consultas
) ENGINE=InnoDB;

-- Notas:
-- Las tablas de hecho son parte de un modelo de datos dimensional utilizado en el almacenamiento de datos.
-- Contienen claves foráneas que apuntan a tablas de dimensiones y campos que contienen las métricas para análisis.
-- Las métricas son típicamente numéricas, como cantidades vendidas, ingresos, etc.
-- Los motores de almacenamiento como InnoDB son adecuados para asegurar la integridad referencial a través de claves foráneas.

-- Tablas de hecho: tipos de columnas

-- Las columnas que entregan medidas aditivas son aquellas que agregamos con el fin de obtener totales, como ser (salarios que se pagaron, total de ventas realizadas, etcétera).
-- Las columnas que entrega medidas semi-aditivas son las que se usan en las variables de existencia o inventario (total de empleados, total de facturas de venta realizadas, etcétera). También pueden entrar en esta categoría columnas como ser (período mensual de la venta, período mensual de salario pagado).
-- Las columnas del tipo medidas no-aditivas no se deben agregar usualmente, a menos que sea un trabajo enteramente técnico. Bajo este paradigma se agregarían columnas como impuestos (TAX, IVA, etc.). Calcular este tipo de columnas y presentarlas en una tabla de hecho no es lo que se recomienda.
-- Puede haber excepciones para aquellos casos donde el área contable de una empresa pida informes totales que requieran discriminar los TAXES de las ganancias, por fuera de lo que se conoce en el mundo contable como ESTADO DE RESULTADOS.

-- Tablas de hecho: aplicación

-- Su principal beneficio surge cuando debemos obtener métricas para armar, por ejemplo, reportes utilizando Power BI, Tableau, u otra herramienta similar. 
-- Nuestra DB podría incluir tablas de hecho sin relación alguna con el Schema, albergando sólo los “números importantes”.


-- TABLAS DIMENSIONALES

-- Son utilizadas para describir las dimensiones de negocio y usualmente contienen un conjunto de atributos que describen las entidades de negocio en un modelo de Data Warehouse.

-- Crear una tabla dimensional para productos
CREATE TABLE productos_dimension (
    -- Clave primaria única para cada producto
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Atributos descriptivos del producto
    nombre VARCHAR(255),           -- Nombre del producto
    categoria VARCHAR(255),        -- Categoría a la que pertenece el producto
    precio DECIMAL(10, 2),         -- Precio estándar del producto
    proveedor VARCHAR(255),        -- Nombre del proveedor o fabricante
    descripcion TEXT,              -- Descripción detallada del producto
    
    -- Pueden incluirse más atributos relevantes para el negocio
    color VARCHAR(50),             -- Color del producto
    tamaño VARCHAR(50),            -- Tamaño del producto
    peso DECIMAL(10, 2)            -- Peso del producto
    
    -- Otras configuraciones podrían incluir índices para atributos frecuentemente buscados
) ENGINE=InnoDB;

-- Notas:
  -- producto_id es una clave surrogate que identifica de manera única cada fila en la tabla.
  -- Los atributos descriptivos son detallados y están diseñados para ser fácilmente entendidos por los usuarios del negocio.
  -- Las tablas dimensionales son optimizadas para las consultas, no para las transacciones.


-- Modelo Estrella
  -- En este modelo, una tabla de hecho central está rodeada por tablas de dimensiones. La tabla de hecho central contiene las métricas clave del negocio y claves foráneas que apuntan a las tablas de dimensiones. Las tablas de dimensiones contienen atributos descriptivos relacionados con las dimensiones del negocio.

-- Características del Modelo Estrella:
  -- Simplicidad: El diseño es intuitivamente comprensible y refleja las consultas de negocios de manera directa.
  -- Rendimiento: Las consultas suelen ser más rápidas debido a la menor complejidad de las uniones.
  -- Tabla de Hecho: Típicamente tiene una gran cantidad de registros y contiene claves foráneas que se refieren a las tablas de dimensiones.
  -- Tablas de Dimensiones: Generalmente son des-normalizadas, es decir, tienen un gran número de atributos descriptivos en una sola tabla, lo que facilita el análisis.


-- Modelo de Copo de Nieve (Snowflake Schema)
  -- El modelo de copo de nieve es una variante más compleja del modelo estrella. En el modelo de copo de nieve, las tablas de dimensiones están normalizadas, lo que significa que se descomponen en tablas más pequeñas y normalizadas, que se relacionan entre sí.

-- Características del Modelo de Copo de Nieve:
  -- Normalización: Las tablas de dimensiones pueden estar normalizadas en múltiples niveles, lo que reduce la redundancia pero aumenta el número de tablas.
  -- Complejidad: Las consultas pueden ser más complejas debido a la mayor cantidad de uniones requeridas.
  -- Integridad de Datos: Puede mejorar la integridad de los datos debido a la normalización.
  -- Mantenimiento: A menudo requiere un mantenimiento más complejo debido a la estructura más intricada.


-- Implementación de las diferentes claves e índices
-- Índices
-- Claves primarias
-- Primary key: AUTOINCREMENT
-- Primary key: ejemplo
-- Claves foráneas
-- Claves foráneas: ejemplo
-- Condicionales en foregin key
-- Claves foráneas: restricciones
-- Restricciones ON UPDATE y ON DELETE
-- CASCADE, NO ACTION, RESTRICT
-- Restricciones ON INSERT
-- Claves candidatas
-- Claves concatenadas


-- Crear una tabla de ejemplo con una clave primaria que se auto-incrementa
CREATE TABLE empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,  -- Primary key que se auto-incrementa
    nombre VARCHAR(100),
    departamento_id INT
);

-- Crear una tabla de ejemplo con una clave primaria explícita
CREATE TABLE departamentos (
    departamento_id INT PRIMARY KEY,  -- Primary key definida explícitamente
    nombre VARCHAR(100)
);

-- Crear una tabla con una clave foránea
CREATE TABLE proyectos (
    proyecto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    lider_empleado_id INT,
    FOREIGN KEY (lider_empleado_id) REFERENCES empleados(empleado_id)
    -- La clave foránea referencia a empleado_id en la tabla empleados
);

-- Crear una tabla con claves foráneas y restricciones condicionales
CREATE TABLE asignaciones (
    asignacion_id INT AUTO_INCREMENT PRIMARY KEY,
    proyecto_id INT,
    empleado_id INT,
    horas_asignadas INT,
    FOREIGN KEY (proyecto_id) REFERENCES proyectos(proyecto_id),
    FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
    -- Las claves foráneas referencia a las tablas proyectos y empleados
);


-- Agregar restricciones ON UPDATE y ON DELETE a una clave foránea
ALTER TABLE asignaciones
ADD CONSTRAINT fk_empleado
FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
ON DELETE CASCADE  -- Al borrar un empleado, se borran sus asignaciones
ON UPDATE NO ACTION;  -- Al actualizar un empleado_id, no se realiza ninguna acción en cascada

-- CASCADE: Borra o actualiza el registro en la tabla padre y automáticamente borra o actualiza los registros coincidentes en la tabla hija.
-- NO ACTION: No se permite borrar o actualizar ningún valor de clave primaria si en la tabla hija hay un valor de clave foránea relacionada.
-- RESTRICT: Rechaza la operación de eliminación o actualización en la tabla padre. NO ACTION y RESTRICT son similares en tanto omiten la cláusula ON DELETE u ON UPDATE.

-- Sintaxis
-- FOREIGN KEY(Campo1)  REFERENCES tablapadre (campo2)
-- ON DELETE [CASCADE NO ACTION RESTRICT]
-- ON UPDATE [CASCADE NO ACTION RESTRICT]


-- Nota: NO ACTION y RESTRICT son muy similares en que ambos impiden la operación si hay una dependencia.

-- Las restricciones en INSERT no son aplicables de la misma manera que ON UPDATE y ON DELETE
-- ya que INSERT no afecta a las filas que ya existen.


-- Crear una tabla con claves candidatas (única pero no necesariamente una clave primaria)
CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    -- El email es una clave candidata, debe ser único pero no es la clave primaria
    nombre VARCHAR(100)
);

-- Crear una tabla con claves concatenadas (compuesta por dos o más columnas)
CREATE TABLE ordenes (
    orden_id INT,
    cliente_id INT,
    fecha_orden DATE,
    PRIMARY KEY (orden_id, cliente_id),
    -- La combinación de orden_id y cliente_id forma una clave primaria compuesta
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
    -- La clave foránea referencia a cliente_id en la tabla clientes
);
