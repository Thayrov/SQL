# Coderhouse

## Curso SQL

### Pre entrega 2

**REALIZADO POR THAYROV GARCÍA**

---

### Administración de la Relación con el Cliente (CRM)

**Objetivo Principal:** Diseñar una base de datos para rastrear interacciones con los clientes, preferencias y retroalimentación. Esto incluirá detalles personales, historial de servicios adquiridos, preferencias por vendedor o productos específicos y niveles de satisfacción.

**Objetivo Secundario:** Habilitar marketing personalizado, mejorar el servicio al cliente y aumentar la retención, utilizando los datos para informar estrategias de fidelización y promociones dirigidas.

**Diagrama de entidad relación:** ![Imagen](https://res.cloudinary.com/dhjlbf6xs/image/upload/v1706413954/SQL/CRM_d2vbpo.png)

Creado en dbdiagram.io, puedes ver más de este diagrama en [dbdiagram.io/d/CRM-65624ae53be1495787ba0867](https://dbdiagram.io/d/CRM-65624ae53be1495787ba0867)

---

#### DESCRIPCIÓN DE TABLAS

---

| Tabla | customer_dim |
| --- | --- |
| Descripción | Almacena información básica de los clientes. Esta tabla es clave para identificar a los clientes y es utilizada por otras tablas para relacionar información específica del cliente como interacciones, compras y preferencias. |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | customer_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada cliente |
|  | first_name | VARCHAR | 255 | VERDADERO | FALSO | \- | Nombre del cliente |
|  | last_name | VARCHAR | 255 | VERDADERO | FALSO | \- | Apellido del cliente |
|  | email | VARCHAR | 255 | VERDADERO | VERDADERO | \- | Correo electrónico del cliente, debe ser único |
|  | phone | VARCHAR | 20 | FALSO | VERDADERO | Not available | Número de teléfono del cliente, 'Not available' si no se proporciona |

---

| Tabla | employee_dim |
| --- | --- |
| Descripción | Contiene información de los empleados que interactúan con los clientes. Los empleados registrados en esta tabla son referenciados por las interacciones con los clientes y pueden ser preferidos por clientes específicos. |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | employee_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada empleado |
|  | first_name | VARCHAR | 255 | VERDADERO | FALSO | \- | Nombre del empleado |
|  | last_name | VARCHAR | 255 | VERDADERO | FALSO | \- | Apellido del empleado |
|  | role | VARCHAR | 255 | VERDADERO | FALSO | \- | Rol o posición del empleado dentro de la empresa |
|  | email | VARCHAR | 255 | VERDADERO | VERDADERO | \- | Correo electrónico del empleado, debe ser único |
|  | phone | VARCHAR | 20 | FALSO | VERDADERO | Not available | Número de teléfono del empleado, 'Not available' si no se proporciona |

---

| Tabla | service_dim |
| --- | --- |
| Descripción | Lista de servicios que la empresa ofrece a los clientes. Representa los servicios que los clientes pueden comprar o sobre los que pueden dejar comentarios. |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | customer_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada cliente |
| FK | service_category_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada categoría de servicio |
|  | description | TEXT | \- | VERDADERO | FALSO | \- | Descripción detallada de la categoría de servicio |
|  | price | INT |  | VERDADERO | FALSO | \- | Precio del servicio |

---

| Tabla | service_category_dim |
| --- | --- |
| Descripción | Categorías a las que pertenecen los servicios. Esta tabla clasifica los servicios en diferentes categorías para una mejor organización y análisis |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | service_category_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada categoría de servicio |
|  | category_name | VARCHAR | 255 | VERDADERO | VERDADERO | \- | Nombre de la categoría de servicio, debe ser único |
|  | description | TEXT | \- | VERDADERO | FALSO | \- | Descripción detallada de la categoría de servicio |

---

| Tabla | time_dim |
| --- | --- |
| Descripción | Dimensiones de tiempo para el análisis de tendencias y patrones en las interacciones, compras y comentarios de los clientes. |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | id_time_dim | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada registro temporal |
|  | date_time | DATETIME | \- | VERDADERO | VERDADERO | \- | Fecha y hora específicas |
|  | year | INT |  | VERDADERO | FALSO | \- | Año de la fecha y hora |
|  | month | INT |  | VERDADERO | FALSO | \- | Mes de la fecha y hora |
|  | day | INT |  | VERDADERO | FALSO | \- | Día de la fecha y hora |
|  | hour | INT |  | VERDADERO | FALSO | \- | Hora de la fecha y hora |
|  | minute | INT |  | VERDADERO | FALSO | \- | Minuto de la fecha y hora |
|  | second | INT |  | VERDADERO | FALSO | \- | Segundo de la fecha y hora |

---

| Tabla | interaction_fact |
| --- | --- |
| Descripción | Registra cada interacción de los clientes con empleados. Las relaciones con las tablas de dimensión permiten un seguimiento completo de todas las interacciones de los clientes con la empresa. |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | interaction_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada interacción |
| FK | customer_id | INT |  | VERDADERO | FALSO | \- | Referencia al cliente involucrado en la interacción |
| FK | employee_id | INT |  | VERDADERO | FALSO | \- | Referencia al empleado involucrado en la interacción |
| FK | service_id | INT |  | VERDADERO | FALSO | \- | Referencia al servicio discutido o proporcionado durante la interacción |
| FK | id_time_dim | INT | \- | VERDADERO | FALSO | \- | Referencia al momento exacto de la interacción |
|  | type | VARCHAR | 255 | VERDADERO | FALSO | \- | Tipo de interacción (consulta, venta, soporte, etc.) |

---

| Tabla | purchase_fact |
| --- | --- |
| Descripción | Registra las compras realizadas por los clientes. Esta tabla es fundamental para el análisis de ventas y tendencias de compra. |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | purchase_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada compra |
| FK | customer_id | INT |  | VERDADERO | FALSO | \- | Referencia al cliente que realizó la compra |
| FK | date_time_purchase | INT | \- | VERDADERO | FALSO | \- | Fecha y hora de cuando se realizó la compra |
|  | total | INT |  | VERDADERO | FALSO | \- | Monto total de la compra |

---

| Tabla | purchase_detail_fact |
| --- | --- |
| Descripción | Detalles específicos de cada compra. Proporciona un desglose detallado de las compras, permitiendo un análisis a nivel de producto o servicio |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | id_purchase_detail | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada detalle de compra |
| FK | purchase_id | INT |  | VERDADERO | FALSO | \- | Referencia a la compra general a la que este detalle pertenece |
| FK | service_id | INT |  | VERDADERO | FALSO | \- | Referencia al servicio específico comprado |
|  | purchase_price | INT |  | VERDADERO | FALSO | \- | Precio de compra del servicio específico |

---

| Tabla | customer_preferences_dim |
| --- | --- |
| Descripción | Preferencias personales de los clientes. Ayuda a personalizar la experiencia del cliente y dirigir acciones de marketing más efectivas |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | preference_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada preferencia registrada |
| FK | customer_id | INT |  | VERDADERO | FALSO | \- | Referencia al cliente que tiene la preferencia |
| FK | service_category_id | INT |  | VERDADERO | FALSO | \- | Referencia a la categoría de servicio preferida por el cliente |
| FK | preferred_employee_id | INT |  | VERDADERO | FALSO | \- | Referencia al empleado preferido por el cliente |
|  | notes | TEXT | \- | FALSO | FALSO | NULL | Notas adicionales sobre las preferencias del cliente |

---

| Tabla | customer_feedback_fact |
| --- | --- |
| Descripción | Feedback y calificaciones proporcionadas por los clientes. Crucial para el análisis de la satisfacción del cliente y la mejora de los servicios. |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | feedback_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único para cada entrada de retroalimentación |
| FK | customer_id | INT |  | VERDADERO | FALSO | \- | Referencia al cliente que proporciona la retroalimentación |
| FK | service_id | INT |  | VERDADERO | FALSO | \- | Referencia al servicio sobre el cual se da la retroalimentación |
|  | rating | INT |  | VERDADERO | FALSO | \- | Calificación numérica dada al servicio |
|  | comment | TEXT | \- | VERDADERO | FALSO | \- | Comentario o retroalimentación textual proporcionada por el cliente |
| FK | id_time_dim | INT | \- | VERDADERO | FALSO | \- | Fecha y hora cuando se proporcionó la retroalimentación |

---

| Tabla       | purchase_log                                                  |
| ----------- | ------------------------------------------------------------- |
| Descripción | Registra las operaciones realizadas en la tabla purchase_fact |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | log_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único del registro log |
|  | operation_type | VARCHAR | 10 | VERDADERO | FALSO | \- | Tipo de operación (INSERT, UPDATE, etc.) |
|  | operation_timestamp | DATETIME |  | VERDADERO | FALSO | \- | Fecha y hora de la operación |
|  | user | VARCHAR | 100 | VERDADERO | FALSO | \- | Usuario que realizó la operación |
| FK | purchase_id | INT |  | VERDADERO | FALSO | \- | ID de la compra relacionada |
|  | details | TEXT |  | VERDADERO | FALSO | \- | Detalles de la operación |

---

| Tabla       | feedback_log                                                            |
| ----------- | ----------------------------------------------------------------------- |
| Descripción | Registra las operaciones realizadas en la tabla customer_feedback_fact. |

| KEY | COLUMN | COLUMN TYPE | LENGTH | NOT NULL | UNIQUE | DEFAULT | NOTES |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PK | log_id | INT |  | VERDADERO | VERDADERO | \- | Identificador único del registro log |
|  | operation_type | VARCHAR | 10 | VERDADERO | FALSO | \- | Tipo de operación (INSERT, DELETE, etc.) |
|  | operation_timestamp | DATETIME |  | VERDADERO | FALSO | \- | Fecha y hora de la operación |
|  | user | VARCHAR | 100 | VERDADERO | FALSO | \- | Usuario que realizó la operación |
| FK | feedback_id | INT |  | VERDADERO | FALSO | \- | ID de la retroalimentación relacionada |
|  | details | TEXT |  | VERDADERO | FALSO | \- | Detalles de la operación |

---

#### Listado de Vistas

**Vista: CustomerDetails**

- **Descripción:** Proporciona una vista unificada de los detalles de los clientes, sus preferencias y su retroalimentación.
- **Objetivo:** Facilitar el acceso rápido a información completa del cliente para análisis y soporte al cliente.
- **Tablas que la componen:** customer_dim, customer_preferences_dim, customer_feedback_fact.

**Vista: EmployeeInteractions**

- **Descripción:** Agrega las interacciones que han tenido los empleados, incluyendo el tipo y el conteo de interacciones.
- **Objetivo:** Analizar la carga de trabajo y el rendimiento de los empleados basado en las interacciones con clientes.
- **Tablas que la componen:** employee_dim, interaction_fact.

**Vista: SalesSummary**

- **Descripción:** Resume las ventas realizadas, mostrando el detalle de los servicios adquiridos y los precios de compra.
- **Objetivo:** Ofrecer una visión consolidada de las ventas para el análisis de ingresos y tendencias de compra.
- **Tablas que la componen:** purchase_fact, purchase_detail_fact, service_dim.

**Vista: ServicesByCategory**

- **Descripción:** Muestra los servicios ofrecidos organizados por categoría, con descripción y precio.
- **Objetivo:** Permitir una visualización clara de los servicios por categoría para facilitar la toma de decisiones de marketing y ventas.
- **Tablas que la componen:** service_dim, service_category_dim.

**Vista: CustomerFeedback**

- **Descripción:** Recopila la retroalimentación de los clientes y la relaciona con la información del cliente y el servicio.
- **Objetivo:** Entender la satisfacción del cliente y obtener insights para la mejora de servicios.
- **Tablas que la componen:** customer_feedback_fact, customer_dim.

---

#### Listado de Funciones

**Función: TotalVentasCliente**

- **Descripción:** Calcula el total de ventas asociadas a un cliente específico.
- **Objetivo:** Proporcionar una suma rápida de todas las ventas para un cliente individual, útil para análisis de clientes y generación de reportes.
- **Datos o tablas que manipula:** Utiliza datos de ventas, probablemente interactuando con tablas como purchase_fact y sus detalles.

**Función: CantidadInteraccionesPorTipo**

- **Descripción:** Calcula el número total de interacciones de un tipo específico.
- **Objetivo:** Proporcionar un recuento rápido de las interacciones por tipo para análisis y reportes.
- **Datos o tablas que manipula:** Consulta la tabla interaction_fact y cuenta las entradas que coinciden con el tipo de interacción proporcionado.

---

#### Listado de Stored Procedures

**Stored Procedure: OrdenarTabla**

- **Descripción:** Ordena los registros de una tabla especificada por el usuario.
- **Objetivo o beneficio:** Facilitar el reordenamiento de los datos para optimizar consultas posteriores o simplemente para mejorar la visualización en aplicaciones frontend.
- **Tablas que lo componen y/o con las que interactúa:** Interactúa con cualquier tabla cuyo nombre se pase como parámetro.

**Stored Procedure: InsertarEliminarCliente**

- **Descripción:** Realiza acciones de inserción o eliminación sobre registros de clientes.
- **Objetivo o beneficio:** Automatizar y encapsular las operaciones de inserción y eliminación para mantener la integridad de datos y simplificar las operaciones CRUD en la tabla de clientes.
- **Tablas que lo componen y/o con las que interactúa:** Interactúa con la tabla de clientes, posiblemente customer_dim o una similar.

---

#### Listado de Triggers

**Trigger: before_purchase_insert**

- **Descripción:** Actúa antes de insertar un nuevo registro en purchase_fact.
- **Objetivo:** Registrar la acción de intento de inserción para auditoría y seguimiento.
- **Tablas que lo componen y/o con las que interactúa:** Inserta un registro en purchase_log antes de que se inserte en purchase_fact.

**Trigger: after_purchase_update**

- **Descripción:** Se ejecuta después de que un registro en purchase_fact es actualizado.
- **Objetivo:** Registrar el detalle de la actualización para mantener un histórico de cambios.
- **Tablas que lo componen y/o con las que interactúa:** Inserta un registro en purchase_log después de que se actualice un registro en purchase_fact.

**Trigger: before_feedback_delete**

- **Descripción:** Se invoca antes de eliminar un registro en customer_feedback_fact.
- **Objetivo:** Capturar la acción de eliminación para auditoría y seguimiento de retroalimentación eliminada.
- **Tablas que lo componen y/o con las que interactúa:** Inserta un registro en feedback_log antes de que se elimine un registro de customer_feedback_fact.

**Trigger: after_feedback_insert**

- **Descripción:** Se activa después de insertar un nuevo registro en customer_feedback_fact.
- **Objetivo:** Registrar la acción de inserción de retroalimentación para auditoría y seguimiento de nueva retroalimentación.
- **Tablas que lo componen y/o con las que interactúa:** Inserta un registro en feedback_log después de que se inserte un nuevo registro en customer_feedback_fact.
