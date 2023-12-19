-- Crea la base de datos
CREATE DATABASE ecommerceSIG;

-- Crea la tabla de roles
CREATE TABLE roles (
  id serial PRIMARY KEY,
  name text NOT NULL
);
-- Crea la tabla de usuarios
CREATE TABLE users (
  id serial PRIMARY KEY,
  email text,
  password text NOT NULL,
  password_resset text NOT NULL,

);
-- Crea la tabla de administradores
CREATE TABLE administrators (
  id serial PRIMARY KEY,
  name text NOT NULL,
  phone text,
  user_id int NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Crea la tabla de clientes
CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  phone text,
  user_id int NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Crea la tabla de comerciales
CREATE TABLE commercials (
  id serial PRIMARY KEY,
  name text NOT NULL,
 );
-- Crea la tabla de ventas
CREATE TABLE sales_posts (
  id serial PRIMARY KEY,
  name text NOT NULL,
  longitude float NOT NULL
  latitude float NOT NULL,
  commercial_id INT NOT NULL
  administrator_id integer NOT NULL,
  FOREIGN KEY administrator_id REFERENCES administrators (id),
  category_id integer NOT NULL,
  FOREIGN KEY commercial_id REFERENCES commercials(id),
 );

-- Crea la tabla de categorías
CREATE TABLE categories (
  id serial PRIMARY KEY,
  name text NOT NULL,
  sales_posts_id INT NOT NULL,
  FOREIGN KEY sales_posts_id REFERENCES sales_posts(id)
);

-- Crea la tabla de productos
CREATE TABLE products (
  id serial PRIMARY KEY,
  commercial_id integer NOT NULL REFERENCES commercials (id),
  name text NOT NULL,
  price float NOT NULL,
  sales_posts_id INT NOT NULL,
  category_id INT NOT NULL,
  FOREIGN KEY sales_posts_id REFERENCES sales_posts(id),
  FOREIGN KEY category_id REFERENCES categories(id)
);

