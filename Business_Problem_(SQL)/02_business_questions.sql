-- Question 2: Is the "same-day delivery" promise actually consistent across the catalog?
-- 2a — What fulfillment types actually exist, and how common is each?

SELECT
    delivery_flag,
    COUNT(*) AS product_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_products), 2) AS pct_of_sample
FROM fact_products
GROUP BY delivery_flag
ORDER BY product_count DESC;

-- 2b — Which departments carry non-same-day risk, and how much of that department is affected?

SELECT
    department_name,
    COUNT(*) AS total_sampled,
    COUNT(*) FILTER (WHERE delivery_flag <> 'Same-Day' AND delivery_flag <> 'Under 3 Hours') AS slow_fulfillment_count,
    ROUND(COUNT(*) FILTER (WHERE delivery_flag <> 'Same-Day' AND delivery_flag <> 'Under 3 Hours') * 100.0 / COUNT(*), 2) AS pct_slow
FROM fact_products
GROUP BY department_name
HAVING COUNT(*) FILTER (WHERE delivery_flag <> 'Same-Day' AND delivery_flag <> 'Under 3 Hours') > 0
ORDER BY pct_slow DESC;