DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT4
);

CREATE TABLE films (
  film_id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  director VARCHAR(255)
);

CREATE TABLE tickets (
  ticket_id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(customer_id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(film_id) ON DELETE CASCADE,
  price INT4
);