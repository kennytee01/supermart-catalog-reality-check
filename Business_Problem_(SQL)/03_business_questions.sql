-- Question 3: Is the catalog's assortment actually "grocery-first," as the brand claims?
-- 3a — What share of total tagged inventory is Grocery-Core vs Non-Grocery vs Imported?

SELECT
    department_type,
    SUM(category_page_count) AS total_tagged_products,
    ROUND(SUM(category_page_count) * 100.0 / (SELECT SUM(category_page_count) FROM dim_department), 2) AS pct_of_tagged_total
FROM dim_department
GROUP BY department_type
ORDER BY total_tagged_products DESC;

-- 3b — Which single departments dominate catalog depth, and are they grocery?

SELECT
    department_name,
    category_page_count,
    department_type,
    RANK() OVER (ORDER BY category_page_count DESC) AS depth_rank
FROM dim_department
ORDER BY category_page_count DESC
LIMIT 5;