--Question 5: What's the highest-value risk sitting inside a "same-day" promise?
--5a — Most expensive individual products, and their delivery promise

SELECT product_name, department_name, price_naira, delivery_flag
FROM fact_products
ORDER BY price_naira DESC
LIMIT 5;

-- 5b — Price spread within same-day-only departments (proves risk isn't just about UK Groceries)

SELECT
    department_name,
    MAX(price_naira) - MIN(price_naira) AS price_range_naira,
    MAX(price_naira) AS most_expensive_item
FROM fact_products
WHERE delivery_flag = 'Same-Day'
GROUP BY department_name
ORDER BY price_range_naira DESC
LIMIT 5;