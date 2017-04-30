DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
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

CREATE TABLE screenings (
  screening_id SERIAL4 PRIMARY KEY,
  film_id INT4 REFERENCES films(film_id) ON DELETE CASCADE,
  screening_time TIME,
  max_seats INT4
);

CREATE TABLE tickets (
  ticket_id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(customer_id) ON DELETE CASCADE,
  screening_id INT4 REFERENCES screenings(screening_id) ON DELETE CASCADE,
  price INT4
);

INSERT INTO customers (name, funds) VALUES ('Rupert', 50);
INSERT INTO customers (name, funds) VALUES ('Wallace', 60);
INSERT INTO customers (name, funds) VALUES ('Nigel', 70);
INSERT INTO customers (name, funds) VALUES ('Hubert', 80);

INSERT INTO films (title, director) VALUES ('Predator','John McTiernan'); --1
INSERT INTO films (title, director) VALUES ('Love Actually','Richard Curtis'); --2
INSERT INTO films (title, director) VALUES ('The Devil Wears Prada','David Frankel'); --3
INSERT INTO films (title, director) VALUES ('Lethal Weapon 2','Richard Donner'); --4

--The cineman is showing three screenings of Preadtor and two of Love Actually.
INSERT INTO screenings (film_id, screening_time, max_seats) VALUES (1, TIME '15:00', 100); --1
INSERT INTO screenings (film_id, screening_time, max_seats) VALUES (1, TIME '18:00', 125); --2
INSERT INTO screenings (film_id, screening_time, max_seats) VALUES (1, TIME '21:00', 150); --3 
INSERT INTO screenings (film_id, screening_time, max_seats) VALUES (2, TIME '18:00', 175); --4
INSERT INTO screenings (film_id, screening_time, max_seats) VALUES (2, TIME '21:00', 200); --5

--customer one's purchases...
INSERT INTO tickets (customer_id, screening_id, price) VALUES (1, 3, 10); -- film 1
INSERT INTO tickets (customer_id, screening_id, price) VALUES (1, 4, 10); -- film 2

--customer two's purchases...
INSERT INTO tickets (customer_id, screening_id, price) VALUES (2, 1, 10); -- film 1
INSERT INTO tickets (customer_id, screening_id, price) VALUES (2, 3 ,10); -- film 1

--customer three's purchases...
INSERT INTO tickets (customer_id, screening_id, price) VALUES (3, 3 ,10); -- film 1



