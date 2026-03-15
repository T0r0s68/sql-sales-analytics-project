-- ======================================
-- ADVANCED SALES ANALYSIS
-- ======================================


-- 1. CUMULATIVE REVENUE (Running Total)

SELECT
month,
revenue,
SUM(revenue) OVER (ORDER BY month) AS cumulative_revenue
FROM (
SELECT
DATE_TRUNC('month', o.order_date) AS month,
SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY DATE_TRUNC('month', o.order_date)
) t
ORDER BY month;


-- 2. RANK PRODUCTS BY REVENUE

SELECT
p.product_name,
SUM(p.price * oi.quantity) AS revenue,
RANK() OVER (ORDER BY SUM(p.price * oi.quantity) DESC) AS revenue_rank
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
LIMIT 20;


-- 3. TOP CATEGORY PER MONTH

SELECT
month,
category,
revenue
FROM (
SELECT
DATE_TRUNC('month', o.order_date) AS month,
p.category,
SUM(p.price * oi.quantity) AS revenue,
RANK() OVER (
PARTITION BY DATE_TRUNC('month', o.order_date)
ORDER BY SUM(p.price * oi.quantity) DESC
) AS rank
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month, p.category
) ranked
WHERE rank = 1
ORDER BY month;


-- 4. CUSTOMER SPENDING DISTRIBUTION

SELECT
CASE
WHEN total_spent > 10000 THEN 'VIP'
WHEN total_spent > 5000 THEN 'Loyal'
WHEN total_spent > 2000 THEN 'Regular'
ELSE 'Low Value'
END AS customer_segment,
COUNT(*) AS customers
FROM (
SELECT
c.customer_id,
SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id
) t
GROUP BY customer_segment
ORDER BY customers DESC;