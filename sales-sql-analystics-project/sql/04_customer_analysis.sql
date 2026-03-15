-- ======================================
-- CUSTOMER ANALYSIS
-- ======================================

-- Top Customers by Revenue

SELECT
c.customer_id,
SUM(p.price * oi.quantity) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY total_revenue DESC
LIMIT 20;


-- Repeat Customers (customers with more than one order)

SELECT
customer_id,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;


-- Customer Lifetime Value

SELECT
c.customer_id,
SUM(p.price * oi.quantity) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY lifetime_value DESC
LIMIT 20;


-- Customer Segmentation by Revenue

SELECT
customer_id,
revenue,
CASE
WHEN revenue > 5000 THEN 'High Value'
WHEN revenue > 2000 THEN 'Medium Value'
ELSE 'Low Value'
END AS customer_segment
FROM (
SELECT
c.customer_id,
SUM(p.price * oi.quantity) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id
) t
ORDER BY revenue DESC;