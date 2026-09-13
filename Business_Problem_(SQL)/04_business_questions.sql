-- Question 4: What does real pricing look like across departments, and where might averages mislead?
-- 4a — Average vs median price by department (catches outlier distortion)

SELECT
    department_name,
    COUNT(*) AS sample_size,
    ROUND(AVG(price_naira), 2) AS avg_price,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price_naira)::numeric, 2) AS median_price,
    MIN(price_naira) AS min_price,
    MAX(price_naira) AS max_price
FROM fact_products
GROUP BY department_name
ORDER BY median_price DESC;

-- 4b — Where is the average most distorted by outliers? (gap between avg and median)

SELECT
    department_name,
    ROUND(AVG(price_naira), 2) AS avg_price,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price_naira)::numeric, 2) AS median_price,
    ROUND((AVG(price_naira) - PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price_naira))::numeric, 2) AS avg_minus_median_gap
FROM fact_products
GROUP BY department_name
ORDER BY avg_minus_median_gap DESC
LIMIT 5;