--Question 1: Does Supermart's advertised catalog size match reality?
--1a — Compare marketed claim, category-page sum, and true unique count

SELECT
    10000 AS marketed_claim,
    (SELECT SUM(category_page_count) FROM dim_department) AS category_page_sum,
    25001 AS true_unique_catalog,
    ROUND(25001.0 / 10000, 2) AS true_vs_marketed_ratio,
    ROUND((SELECT SUM(category_page_count)
	FROM dim_department) / 25001.0, 2) AS avg_collections_per_product;

-- 1b — Prove why the category-page sum is inflated (direct evidence)
SELECT
    product_name,
    price_naira,
    COUNT(DISTINCT department_name) AS department_appearances,
    STRING_AGG(DISTINCT department_name, ', ') AS departments
FROM fact_products
GROUP BY product_name, price_naira
HAVING COUNT(DISTINCT department_name) > 1
ORDER BY department_appearances DESC;

