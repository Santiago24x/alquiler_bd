# ALQUILER DE AUTOS 
![banner](./images/banner.jpg)

## MODELO CONCEPTUAL
El usuario podra realizar el alquiler de un vehiculo al llegar a las instalaciones, podra filtrar los autos segun su presupuesto, este mismo usuario podra rentar la cantidad de vehiculos que desee, hay vehiculos que poseen un seguro y este solo sera para vehiculos de gama media y alta, si el auto se renta a un amigo del dueño se puede omitir el cobro de este seguro, los alquileres se realizaran por dias, y si el usuario se pasa de los dias sera multado, el cliente al elegir el auto genera una orden la cual pasara a preparacion y sera entregado al cliente, esta orden tendra 2 estados, pendiente y completada, completada la orden se emitira una factura para que el usuario realice el pago del alquiler y pueda disfrutar de su auto.

Los valores de las multas seran definidos atraves de consultas, segun el porcentaje que el dueño desee.

Las multas se referenciaran junto con la factura inicial de alquiler. 

Tambien se debe manejar el estado fisico del vehiculo en un texto descriptivo de salida y un texto descriptivo de vuelta al lugar de rentado, llego el caso que hayan daños se emitira tambien una factura de cobro de loa arreglos del vehiculo si este es de gama baja, ya que no paga seguro.


## MODELO FISICO
![ImagenModelo](./images/modeloRentcar.png)


## DESCRIPCION DE LAS TABLAS

## Tabla estadosVehiculo
- `id` (INT): Identificador único.
- `tipoEstado` (CHAR, NOT NULL): Tipo de estado del vehículo.

## Tabla marcas
- `id` (INT): Identificador único.
- `nombre` (VARCHAR(45), NOT NULL): Nombre de la marca.

## Tabla gamas
- `id` (INT): Identificador único.
- `tipo` (VARCHAR(6), NOT NULL): Tipo de gama.

## Tabla colores
- `id` (INT): Identificador único.
- `nombre` (VARCHAR(45), NOT NULL): Nombre del color.
- `variacion` (VARCHAR(45), NULL): Variación del color (opcional).

## Tabla modelo
- `id` (INT): Identificador único.
- `anio` (YEAR, NOT NULL): Año del modelo.

## Tabla tipoLicencias
- `id` (VARCHAR(2)): Identificador único.
- `descripcion` (VARCHAR(50), NOT NULL): Descripción del tipo de licencia.

## Tabla clientes
- `id` (INT): Identificador único.
- `nombre` (VARCHAR(50), NOT NULL): Nombre del cliente.
- `apellido` (VARCHAR(50), NOT NULL): Apellido del cliente.
- `direccion` (VARCHAR(50), NOT NULL): Dirección del cliente.

## Tabla telefonos
- `clientes_id` (INT, NOT NULL): ID del cliente relacionado.
- `telefono` (VARCHAR(45), NOT NULL): Número de teléfono.

## Tabla correos
- `clientes_id` (INT, NOT NULL): ID del cliente relacionado.
- `correo` (VARCHAR(100), NOT NULL): Dirección de correo electrónico.

## Tabla licenciasCliente
- `clientes_id` (INT, NOT NULL): ID del cliente relacionado.
- `tipoLicencia` (VARCHAR(2), NOT NULL): Tipo de licencia.
- `idLicencia` (VARCHAR(45), NOT NULL): Identificador de la licencia.

## Tabla vehiculos
- `id` (INT): Identificador único.
- `modelo` (INT, NOT NULL): ID del modelo relacionado.
- `marca` (VARCHAR(50), NOT NULL): Marca del vehículo.
- `gama` (CHAR, NOT NULL): Gama del vehículo.
- `placa` (VARCHAR(6), NOT NULL): Número de placa.
- `color` (VARCHAR(45), NOT NULL): Color del vehículo.
- `precioSeguro` (FLOAT, NOT NULL): Precio del seguro.
- `precio` (FLOAT, NOT NULL): Precio del vehículo.
- `estados_id` (INT, NOT NULL): ID del estado del vehículo.
- `modelo_id` (INT, NOT NULL): ID del modelo relacionado.
- `marca_id` (INT, NOT NULL): ID de la marca relacionada.
- `gama_id` (INT, NOT NULL): ID de la gama relacionada.
- `colores_id` (INT, NOT NULL): ID del color relacionado.


## Tabla estadosOrdenes
- `id` (INT, NOT NULL): Identificador único.
- `tipo` (VARCHAR(13), NULL): Tipo de estado.

## Tabla ordenes
- `id` (INT): Identificador único.
- `fecha` (DATE, NOT NULL): Fecha de la orden.
- `estado` (CHAR, NOT NULL): Estado de la orden.
- `clientes_id` (INT, NOT NULL): ID del cliente asociado.
- `vehiculos_id` (INT, NOT NULL): ID del vehículo asociado.
- `estadosOrdenes_id` (INT, NOT NULL): ID del estado de la orden.

## Tabla tipoFactura
- `id` (INT, NOT NULL): Identificador único.
- `razon` (VARCHAR(45), NULL): Razón de la factura (opcional).

## Tabla facturas
- `id` (INT, NOT NULL): Identificador único.
- `ordenes_id` (INT, NOT NULL): ID de la orden asociada.
- `fechaEmisionFactura` (DATE, NOT NULL): Fecha de emisión de la factura.
- `observaciones` (VARCHAR(150), NULL): Observaciones sobre la factura (opcional).
- `tipoFactura_id` (INT, NOT NULL): ID del tipo de factura.

## Tabla tipoPago
- `id` (INT, NOT NULL): Identificador único.
- `nombre` (VARCHAR(45), NOT NULL): Nombre del tipo de pago.

## Tabla pagos
- `id` (INT, NOT NULL): Identificador único.
- `fechaPago` (VARCHAR(45), NOT NULL): Fecha del pago.
- `facturas_id` (INT, NOT NULL): ID de la factura asociada.
- `tipoPago_id` (INT, NOT NULL): ID del tipo de pago.
- `pagoTotal` (FLOAT, NOT NULL): Total del pago.

## Tabla alquileres
- `id` (INT, NOT NULL, AUTO_INCREMENT): Identificador único.
- `fechaEntrega` (DATE, NOT NULL): Fecha de entrega del vehículo.
- `fechaDevolucion` (DATE, NOT NULL): Fecha de devolución del vehículo.
- `fechaDevolucionTardia` (DATE, NULL): Fecha de devolución tardía del vehículo (opcional).
- `facturas_id` (INT, NOT NULL): ID de la factura asociada.

## Tabla multas
- `id` (INT, NOT NULL, AUTO_INCREMENT): Identificador único.
- `valorMulta` (FLOAT, NOT NULL): Valor de la multa.
- `alquileres_id` (INT, NOT NULL): ID del alquiler asociado.

Esta base de datos proporciona la estructura necesaria para administrar un sistema de alquiler de vehículos, incluyendo información sobre clientes, vehículos, órdenes, facturas, pagos, alquileres y multas.

## INSTRUCCIONES DE USO

## 1. Conectar al Servidor de Base de Datos

Abre un cliente de línea de comandos o una interfaz gráfica que te permita conectarte a tu servidor de bases de datos MySQL o MariaDB.

`mysql -u tu_usuario -p`

Reemplaza tu_usuario con el nombre de usuario de tu base de datos.

## 2. Crear la Base de Datos

`CREATE DATABASE nombre_de_tu_base_de_datos;`

Reemplaza nombre_de_tu_base_de_datos con el nombre que desees para tu base de datos.

## 3. Seleccionar la Base de Datos

`USE nombre_de_tu_base_de_datos;`

Esto te permitirá ejecutar comandos dentro de esa base de datos.

## Ejecutar el Script SQL

Puedes copiar el script contenido dentro `alquilerVehiculosCampus.sql` y pegarlo en tu consola para generar la ejecucion.


## INFORMACION ADICIONAL 

Para obtener más detalles sobre la estructura de las tablas y cómo utilizar la base de datos, consulta la sección correspondiente en este archivo.

Si surge algún problema durante estos pasos, asegúrate de que estás utilizando las credenciales y rutas correctas.




