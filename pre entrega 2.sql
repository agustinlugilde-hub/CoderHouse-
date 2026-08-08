ROLLBACK;

CREATE DATABASE retail_project;

CREATE SCHEMA IF NOT EXISTS core_negocio;

CREATE TABLE core_negocio.clientes (
	clientes_id SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	email VARCHAR(150) UNIQUE NOT NULL,
	edad INT NOT NULL,
	fecha_de_registro DATE DEFAULT CURRENT_DATE,
	CONSTRAINT check_cliente_edad CHECK (edad >= 18)
);
CREATE TABLE core_negocio.productos (
	producto_id SERIAL PRIMARY KEY,
	nombre VARCHAR (200) NOT NULL,
	categoria VARCHAR (75) NOT NULL,
	precio_unitario DECIMAL(10, 2) NOT NULL,
	stock INT NOT NULL DEFAULT 0,
	CONSTRAINT check_producto_precio CHECK (precio_unitario > 0),
	CONSTRAINT check_producto_stock CHECK (stock >= 0)
);
CREATE TABLE core_negocio.ventas(
	venta_id SERIAL PRIMARY KEY,
	clientes_id INT NOT NULL,
	producto_id INT NOT NULL,
	cantidad INT NOT NULL,
	monto_total DECIMAL(10, 2) NOT NULL,
	fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_ventas_clientes FOREIGN KEY (clientes_id) REFERENCES core_negocio.clientes(clientes_id) ON DELETE RESTRICT,
	CONSTRAINT fk_ventas_productos FOREIGN KEY (producto_id) REFERENCES core_negocio.productos(producto_id) ON DELETE RESTRICT,
	CONSTRAINT check_venta_cantidad CHECK (cantidad > 0)
);

BEGIN;

INSERT INTO core_negocio.clientes (nombre, email, edad) VALUES
('Carlos Gomez', 'carlos.gomez@gmail.com', 68),
('Maria Rodriguez', 'mariarodriguez@hotmail.com', 45),
('Juan Martinez', 'juan.martinez@gmail.com', 25),
('Ana Maria Lopez', 'ana.maria.lopez@hotmail.com', 34),
('Martin Palermo', 'martingoleador@gmail.com', 52);

INSERT INTO core_negocio.productos (nombre, categoria, precio_unitario, stock) VALUES
('Smart TV Samsung QLED 4K UHD 55', 'Televisores', 949.99, 20),
('Cafetera Espresso Suono 20 Bar Espumador', 'Cafeteras', 109.99, 10),
('Notebook HP 14 Intel Core 5 8GB 512GB OmniBook 3', 'Notebooks', 1500.00, 15),
('TV Led Noblex HD 40', 'Televisores', 379.99, 35),
('Notebook Exo 14 Intel N4020 4GB 128GB eMMC Smart XR2', 'Notebooks', 339.99, 45);

INSERT INTO core_negocio.ventas (clientes_id, producto_id, cantidad, monto_total) VALUES
(1, 1, 1, 949.99),
(2, 3, 2, 3000.00),
(3, 2, 2, 219.98),
(4, 4, 1, 379.99),
(5, 5, 2, 679.98);

COMMIT;

UPDATE core_negocio.productos
SET precio_unitario = precio_unitario * 1.10
WHERE categoria = 'Televisores';

DELETE FROM core_negocio.ventas
WHERE venta_id = 3;

