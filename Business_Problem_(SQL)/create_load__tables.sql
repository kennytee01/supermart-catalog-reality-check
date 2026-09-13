SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

DROP TABLE IF EXISTS dim_department;
Drop table if exists supermart_catalog_composition;
Drop table if exists supermart_delivery_logs;
Drop table if exists fact_sales;
Drop table if exists fact_deliveries;
Drop table if exists fact_inventory;
Drop table if exists fact_products;

CREATE TABLE dim_department (
    department_id         SERIAL PRIMARY KEY,
    department_name       VARCHAR(50) UNIQUE NOT NULL,
    category_page_count   INTEGER NOT NULL,   -- raw count shown on the department's own page (includes cross-tagging)
    fulfillment_type       VARCHAR(25) NOT NULL,
    department_type        VARCHAR(30) NOT NULL  -- 'Grocery-Core', 'Non-Grocery', 'Imported'
);

INSERT INTO dim_department (department_name, category_page_count, fulfillment_type, department_type) VALUES
('Toiletries',        10704, 'Same-Day',           'Non-Grocery'),
('UK Groceries',        7035, '7-10 Days',          'Imported'),
('Snacks',              6247, 'Same-Day',           'Grocery-Core'),
('Food Cupboard',       3944, 'Same-Day',           'Grocery-Core'),
('Drinks',              3625, 'Same-Day',           'Grocery-Core'),
('Health & Wellness',   2858, 'Same-Day',           'Non-Grocery'),
('Office Supplies',     2847, 'Same-Day',           'Non-Grocery'),
('Electronics',         2674, 'Same-Day',           'Non-Grocery'),
('Alcohol',             2146, 'Same-Day',           'Grocery-Core'),
('Cleaning',            1640, 'Same-Day',           'Non-Grocery'),
('Kitchen & Dining',    1485, 'Same-Day',           'Non-Grocery'),
('Oil & Sauces',        1467, 'Same-Day',           'Grocery-Core'),
('Baby & Kids',         1438, 'Same-Day',           'Non-Grocery'),
('Household',           1391, 'Same-Day',           'Non-Grocery'),
('Fresh Food',          1358, 'Same-Day',           'Grocery-Core'),
('Frozen',               508, 'Same-Day',           'Grocery-Core'),
('Naija Ingredients',    175, 'Under 3 Hours',      'Grocery-Core'),
('Mile 12 Market',       149, 'Same-Day',           'Grocery-Core');

CREATE TABLE fact_products (
    product_id       SERIAL PRIMARY KEY,
    product_name     VARCHAR(150) NOT NULL,
    department_name  VARCHAR(50) REFERENCES dim_department(department_name),
    price_naira      NUMERIC(10,2) NOT NULL,
    on_sale          BOOLEAN DEFAULT FALSE,
    delivery_flag    VARCHAR(25) DEFAULT 'Same-Day'
    -- Real observed values: 'Same-Day', 'Under 3 Hours', '7-10 Days', 'Shipped From Abroad'
);

