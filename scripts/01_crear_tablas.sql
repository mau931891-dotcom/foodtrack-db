-- ============================================================
-- FoodTrack - Script 01: Creación de tablas
-- ============================================================

-- TABLA 1: LOCATIONS
CREATE TABLE locations (
    location_id  INT IDENTITY(1,1) PRIMARY KEY,
    name         NVARCHAR(150) NOT NULL,
    address      NVARCHAR(300) NOT NULL,
    city         NVARCHAR(100) NOT NULL,
    latitude     DECIMAL(9,6),
    longitude    DECIMAL(9,6),
    capacity     INT,
    status       NVARCHAR(20) NOT NULL DEFAULT 'active'
                 CHECK (status IN ('active', 'inactive'))
);

-- TABLA 2: FOODTRUCKS
CREATE TABLE foodtrucks (
    foodtruck_id  INT IDENTITY(1,1) PRIMARY KEY,
    name          NVARCHAR(150) NOT NULL,
    owner_name    NVARCHAR(200) NOT NULL,
    phone         NVARCHAR(20),
    email         NVARCHAR(200) UNIQUE,
    cuisine_type  NVARCHAR(100) NOT NULL,
    license_plate NVARCHAR(20) UNIQUE,
    status        NVARCHAR(20) NOT NULL DEFAULT 'active'
                  CHECK (status IN ('active','inactive','suspended')),
    registered_at DATETIME2 DEFAULT GETDATE()
);

-- TABLA 3: PRODUCTS
CREATE TABLE products (
    product_id   INT IDENTITY(1,1) PRIMARY KEY,
    foodtruck_id INT NOT NULL REFERENCES foodtrucks(foodtruck_id),
    name         NVARCHAR(200) NOT NULL,
    description  NVARCHAR(500),
    price        DECIMAL(10,2) NOT NULL CHECK (price > 0),
    category     NVARCHAR(100),
    is_available BIT NOT NULL DEFAULT 1,
    created_at   DATETIME2 DEFAULT GETDATE()
);

-- TABLA 4: ORDERS
CREATE TABLE orders (
    order_id       INT IDENTITY(1,1) PRIMARY KEY,
    foodtruck_id   INT NOT NULL REFERENCES foodtrucks(foodtruck_id),
    location_id    INT REFERENCES locations(location_id),
    customer_name  NVARCHAR(200) NOT NULL,
    customer_phone NVARCHAR(20),
    order_datetime DATETIME2 NOT NULL DEFAULT GETDATE(),
    total_amount   DECIMAL(10,2) CHECK (total_amount >= 0),
    status         NVARCHAR(20) NOT NULL DEFAULT 'pending'
                   CHECK (status IN ('pending','preparing','ready',
                                     'delivered','cancelled'))
);

-- TABLA 5: ORDER_ITEMS
CREATE TABLE order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id      INT NOT NULL REFERENCES orders(order_id),
    product_id    INT NOT NULL REFERENCES products(product_id),
    quantity      INT NOT NULL CHECK (quantity > 0),
    unit_price    DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    subtotal      AS (quantity * unit_price)
);

-- MODIFICACIÓN: agregar columna comments a orders
ALTER TABLE orders
    ADD comments NVARCHAR(500);