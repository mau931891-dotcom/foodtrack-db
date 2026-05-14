INSERT INTO foodtrucks (foodtruck_id, name, cuisine_type, city) VALUES
(1, 'Taco Loco',   'Mexicana',  'Ciudad de México'),
(2, 'Burger Bros', 'Americana', 'Buenos Aires');

INSERT INTO locations (location_id, foodtruck_id, location_date, zone) VALUES
(1, 1, '2023-09-01', 'Centro'),
(2, 2, '2023-09-01', 'Parque');

INSERT INTO products (product_id, foodtruck_id, name, price, stock) VALUES
(101, 1, 'Taco al pastor', 50.00, 100),
(102, 1, 'Quesadilla',     40.00,  80),
(103, 2, 'Cheeseburger',   70.00, 120),
(104, 2, 'Papas fritas',   30.00, 150);

INSERT INTO or