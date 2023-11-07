
use alquiler;

/* Tabla estadosVehiculo */
CREATE TABLE IF NOT EXISTS estadosVehiculo (
  id INT,
  tipoEstado CHAR NOT NULL
);

ALTER TABLE estadosVehiculo 
ADD CONSTRAINT PK_estadosVehiculo PRIMARY KEY (id),
ADD CONSTRAINT unique_estados UNIQUE (tipoEstado);

/* Tabla marcas */
CREATE TABLE IF NOT EXISTS marcas (
  id INT,
  nombre VARCHAR(45) NOT NULL
);
ALTER TABLE marcas 
ADD CONSTRAINT PK_marcas PRIMARY KEY (id),
ADD CONSTRAINT unique_marcas UNIQUE (nombre);

CREATE TABLE IF NOT EXISTS gamas (
  id INT ,
  tipo VARCHAR(6) NOT NULL
);
ALTER TABLE gamas 
ADD CONSTRAINT PK_gamas PRIMARY KEY (id),
ADD CONSTRAINT unique_gamas UNIQUE (tipo);

/* Tabla colores */
CREATE TABLE IF NOT EXISTS colores (
  id INT ,
  nombre VARCHAR(45) NOT NULL,
  variacion VARCHAR(45) NULL
);
ALTER TABLE colores
ADD CONSTRAINT PK_colores PRIMARY KEY (id),
ADD CONSTRAINT unique_nombreColor UNIQUE (nombre);

/* Tablas modelo */
CREATE TABLE IF NOT EXISTS modelo (
  id INT ,
  anio YEAR NOT NULL
);
ALTER TABLE modelo
ADD CONSTRAINT PK_modelo PRIMARY KEY (id);



/* Tablas tipoLicencias */
CREATE TABLE IF NOT EXISTS tipoLicencias (
  id VARCHAR(2) ,
  descripcion VARCHAR(50) NOT NULL
);
ALTER TABLE tipoLicencias
ADD CONSTRAINT PK_tipoLicencias PRIMARY KEY (id);


/* Tabla clientes */
CREATE TABLE IF NOT EXISTS clientes (
  id INT ,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL
);
ALTER TABLE clientes
ADD CONSTRAINT PK_clientes PRIMARY KEY (id);

/* Tabla telefonos */
CREATE TABLE IF NOT EXISTS telefonos (
  clientes_id INT NOT NULL,
  telefono VARCHAR(45) NOT NULL
);

ALTER TABLE telefonos 
ADD CONSTRAINT FK_telefonos PRIMARY KEY (clientes_id),
ADD CONSTRAINT unique_telefono UNIQUE (telefono);


/* Tabla correos */
CREATE TABLE IF NOT EXISTS correos (
  clientes_id INT NOT NULL,
  correo VARCHAR(100) NOT NULL
);

ALTER TABLE correos 
ADD CONSTRAINT FK_correos PRIMARY KEY (clientes_id),
ADD CONSTRAINT unique_correo UNIQUE (correo);

/* Tablas licencias */
CREATE TABLE IF NOT EXISTS licenciasCliente (
  clientes_id INT NOT NULL,
  tipoLicencia VARCHAR(2) NOT NULL,
  idLicencia VARCHAR(45) NOT NULL
);

ALTER TABLE licenciasCliente 
ADD CONSTRAINT FK_licenciasCliente FOREIGN KEY (clientes_id) REFERENCES clientes (id),
ADD CONSTRAINT FK_tipoLicencia FOREIGN KEY (tipoLicencia) REFERENCES tipoLicencias (id),
ADD CONSTRAINT unique_idLicencia UNIQUE (idLicencia);

/* Tablas vehiculos */
CREATE TABLE IF NOT EXISTS vehiculos (
  id INT ,
  modelo INT NOT NULL,
  marca VARCHAR(50) NOT NULL,
  gama CHAR NOT NULL,
  placa VARCHAR(6) NOT NULL,
  color VARCHAR(45) NOT NULL,
  precioSeguro FLOAT NOT NULL,
  precio FLOAT NOT NULL,
  estados_id INT NOT NULL,
  modelo_id INT NOT NULL,
  marca_id INT NOT NULL,
  gama_id INT NOT NULL,
  colores_id INT NOT NULL
);

ALTER TABLE vehiculos
ADD CONSTRAINT PK_vehiculos PRIMARY KEY (id),
ADD CONSTRAINT unique_placa UNIQUE (placa),
ADD CONSTRAINT FK_modelo FOREIGN KEY (modelo_id) REFERENCES modelo (id),
ADD CONSTRAINT FK_marca FOREIGN KEY (marca_id) REFERENCES marcas (id),
ADD CONSTRAINT FK_gama FOREIGN KEY (gama_id) REFERENCES gamas (id),
ADD CONSTRAINT FK_colores FOREIGN KEY (colores_id) REFERENCES colores (id),
ADD CONSTRAINT FK_estadosVehiculo FOREIGN KEY (estados_id) REFERENCES estadosVehiculo (id);

/* Tablas estadosOrdenes */
CREATE TABLE IF NOT EXISTS estadosOrdenes (
  id INT NOT NULL,
  tipo VARCHAR(13) NULL
);

ALTER TABLE estadosOrdenes
ADD CONSTRAINT PK_estadosOrdenes PRIMARY KEY (id),
ADD CONSTRAINT unique_estadosOrdenes UNIQUE (tipo);



/* Tablas ordenes */
CREATE TABLE IF NOT EXISTS ordenes (
  id INT ,
  fecha DATE NOT NULL,
  estado CHAR NOT NULL,
  clientes_id INT NOT NULL,
  vehiculos_id INT NOT NULL,
  estadosOrdenes_id INT NOT NULL
);

ALTER TABLE ordenes
ADD CONSTRAINT PK_ordenes PRIMARY KEY (id),
ADD CONSTRAINT FK_clientes FOREIGN KEY (clientes_id) REFERENCES clientes (id),
ADD CONSTRAINT FK_vehiculos FOREIGN KEY (vehiculos_id) REFERENCES vehiculos (id),
ADD CONSTRAINT FK_estadosOrdenes FOREIGN KEY (estadosOrdenes_id) REFERENCES estadosOrdenes (id);


/* Tablas tipoFactura */
CREATE TABLE IF NOT EXISTS tipoFactura (
  id INT NOT NULL,
  razon VARCHAR(45) NULL
);

ALTER TABLE tipoFactura
ADD CONSTRAINT PK_tipoFactura PRIMARY KEY (id),
ADD CONSTRAINT unique_razon UNIQUE (razon);

/* Tablas facturas */
CREATE TABLE IF NOT EXISTS facturas (
  id INT NOT NULL,
  ordenes_id INT NOT NULL,
  fechaEmisionFactura DATE NOT NULL,
  observaciones VARCHAR(150) NULL,
  tipoFactura_id INT NOT NULL
);

ALTER TABLE facturas
ADD CONSTRAINT PK_facturas PRIMARY KEY (id),
ADD CONSTRAINT FK_ordenes FOREIGN KEY (ordenes_id) REFERENCES ordenes (id),
ADD CONSTRAINT FK_tipoFactura FOREIGN KEY (tipoFactura_id) REFERENCES tipoFactura (id);

/* Tablas tipoPago */
CREATE TABLE IF NOT EXISTS tipoPago (
  id INT NOT NULL,
  nombre VARCHAR(45) NOT NULL
);

ALTER TABLE tipoPago 
ADD CONSTRAINT PK_tipoPago PRIMARY KEY (id),
ADD CONSTRAINT unique_nombre UNIQUE (nombre);

/* Tablas pagos */
CREATE TABLE IF NOT EXISTS pagos (
  id INT NOT NULL ,
  fechaPago VARCHAR(45) NOT NULL,
  facturas_id INT NOT NULL,
  tipoPago_id INT NOT NULL,
  pagoTotal FLOAT NOT NULL
);

ALTER TABLE pagos
ADD CONSTRAINT PK_pagos PRIMARY KEY (id),
ADD CONSTRAINT FK_facturas FOREIGN KEY (facturas_id) REFERENCES facturas (id),
ADD CONSTRAINT FK_tipoPago FOREIGN KEY (tipoPago_id) REFERENCES tipoPago (id);

/* Tablas alquileres */
CREATE TABLE IF NOT EXISTS alquileres (
  id INT NOT NULL ,
  fechaEntrega DATE NOT NULL,
  fechaDevolucion DATE NOT NULL,
  fechaDevolucionTardia DATE NULL,
  facturas_id INT NOT NULL
);

ALTER TABLE alquileres
ADD CONSTRAINT PK_alquileres PRIMARY KEY (id),
ADD CONSTRAINT FK_alquileres_facturas FOREIGN KEY (facturas_id) REFERENCES facturas (id);

/* Tablas multas */
CREATE TABLE IF NOT EXISTS multas (
  id INT NOT NULL ,
  valorMulta FLOAT NOT NULL,
  alquileres_id INT NOT NULL
);

ALTER TABLE multas
ADD CONSTRAINT PK_multas PRIMARY KEY (id),
ADD CONSTRAINT FK_alquileres FOREIGN KEY (alquileres_id) REFERENCES alquileres (id);
