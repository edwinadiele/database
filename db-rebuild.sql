-- =========================
-- DATABASE REBUILD FILE
-- =========================

-- DROP TABLES (optional but safe)
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS classification;
DROP TABLE IF EXISTS account;

-- DROP TYPE
DROP TYPE IF EXISTS account_type_enum;

-- =========================
-- CREATE TYPE
-- =========================
CREATE TYPE account_type_enum AS ENUM ('Client', 'Employee', 'Admin');

-- =========================
-- CREATE TABLES
-- =========================

-- Account Table
CREATE TABLE account (
    account_id SERIAL PRIMARY KEY,
    account_firstname VARCHAR(50),
    account_lastname VARCHAR(50),
    account_email VARCHAR(100) UNIQUE,
    account_password VARCHAR(255),
    account_type account_type_enum DEFAULT 'Client'
);

-- Classification Table
CREATE TABLE classification (
    classification_id SERIAL PRIMARY KEY,
    classification_name VARCHAR(50)
);

-- Inventory Table
CREATE TABLE inventory (
    inv_id SERIAL PRIMARY KEY,
    inv_make VARCHAR(50),
    inv_model VARCHAR(50),
    inv_description TEXT,
    inv_image VARCHAR(255),
    inv_thumbnail VARCHAR(255),
    classification_id INT,
    FOREIGN KEY (classification_id) REFERENCES classification(classification_id)
);

-- =========================
-- INSERT DATA
-- =========================

-- Classification Data
INSERT INTO classification (classification_name) VALUES
('Sport'),
('SUV'),
('Truck'),
('Sedan');

-- Inventory Data
INSERT INTO inventory (inv_make, inv_model, inv_description, inv_image, inv_thumbnail, classification_id) VALUES
('GM', 'Hummer', 'A rugged vehicle with small interiors', '/images/hummer.jpg', '/images/hummer-thumb.jpg', 2),
('Ferrari', 'F8', 'A fast sports car', '/images/f8.jpg', '/images/f8-thumb.jpg', 1),
('Lamborghini', 'Huracan', 'Luxury sport vehicle', '/images/huracan.jpg', '/images/huracan-thumb.jpg', 1);

-- =========================
-- REQUIRED QUERIES (COPY FROM TASK 1)
-- =========================

-- Query 4
UPDATE inventory
SET inv_description = REPLACE(inv_description, 'small interiors', 'a huge interior')
WHERE inv_make = 'GM' AND inv_model = 'Hummer';

-- Query 6
UPDATE inventory
SET inv_image = REPLACE(inv_image, '/images/', '/images/vehicles/'),
    inv_thumbnail = REPLACE(inv_thumbnail, '/images/', '/images/vehicles/');