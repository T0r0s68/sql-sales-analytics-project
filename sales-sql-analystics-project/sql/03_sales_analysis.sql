-- ======================================
-- SALES ANALYSIS
-- ======================================

-- Total Revenue

SELECT
SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;


-- Revenue by Month

SELECT
DATE_TRUNC('month', o.order_date) AS month,
SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;


-- Monthly Revenue Growth

WITH monthly_revenue AS (
SELECT
DATE_TRUNC('month', o.order_date) AS month,
SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
)

SELECT
month,
revenue,
LAG(revenue) OVER (ORDER BY month) AS previous_month,
(revenue - LAG(revenue) OVER (ORDER BY month)) /
LAG(revenue) OVER (ORDER BY month) AS growth_rate
FROM monthly_revenue
ORDER BY month;


-- Average Order Value

SELECT
SUM(p.price * oi.quantity) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;