CREATE TABLE foodtrucks (
    foodtruck_id    INT             PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    cuisine_type    VARCHAR(50)     NOT NULL,
    city            VARCHAR(100)    NOT NULL
);

CREATE TABLE locations (
    location_id     INT             PRIMARY KEY,
    foodtruck_id    INT             NOT NULL,
    location_date   DATE            NOT NULL,
    zone            VARCHAR(100)    NOT NULL,
    CONSTRAINT fk_locations_foodtruck
        FOREIGN KEY (foodtruck_id) REFERENCES foodtrucks(foodtruck_id)
);

CREATE TABLE products (
    product_id      INT             PRIMARY KEY,
    foodtruck_id    INT             NOT NULL,
    name            VARCHAR(100)    NOT NULL,
    price           DECIMAL(10,2)   NOT NULL,
    stock           INT             NOT NULL DEFAULT 0,
    CONSTRAINT fk_products_foodtruck
        FOREIGN KEY (foodtruck_id) REFERENCES foodtrucks(foodtruck_id)
);

CREATE TABLE orders (
    order_id        INT             PRIMARY KEY,
    foodtruck_id    INT             NOT NULL,
    order_date      DATE            NOT NULL,
    status          VARCHAR(50)     NOT NULL,
    total           DECIMAL(10,2)   NOT NULL,
    CONSTRAINT fk_orders_foodtruck
        FOREIGN KEY (foodtruck_id) REFERENCES foodtrucks(foodtruck_id)
);

CREATE TABLE order_items (
    order_item_id   INT             PRIMARY KEY,
    order_id        INT             NOT NULL,
    product_id      INT             NOT NULL,
    quantity        INT             NOT NULL DEFAULT 1,
    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_orderitems_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);