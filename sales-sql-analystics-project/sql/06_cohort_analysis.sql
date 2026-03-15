-- ======================================
-- COHORT ANALYSIS
-- ======================================

-- Cohort Retention Analysis

WITH cohort_data AS (
SELECT
o.customer_id,
DATE_TRUNC('month', MIN(o.order_date) OVER (PARTITION BY o.customer_id)) AS cohort_month,
DATE_TRUNC('month', o.order_date) AS order_month
FROM orders o
)

SELECT
cohort_month,
(order_month - cohort_month) / 30 AS month_number,
COUNT(DISTINCT customer_id) AS customers
FROM cohort_data
GROUP BY cohort_month, month_number
ORDER BY cohort_month, month_number;


-- Customers per Cohort

SELECT
DATE_TRUNC('month', MIN(order_date)) AS cohort_month,
COUNT(DISTINCT customer_id) AS total_customers
FROM orders
GROUP BY cohort_month
ORDER BY cohort_month;