-- ======================================
-- PRODUCT ANALYSIS
-- ======================================

-- Top Products by Units Sold

SELECT
p.product_name,
SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 20;


-- Top Products by Revenue

SELECT
p.product_name,
SUM(p.price * oi.quantity) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 20;


-- Category Performance by Revenue

SELECT
p.category,
SUM(p.price * oi.quantity) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- Average Price per Category

SELECT
category,
AVG(price) AS average_price
FROM products
GROUP BY category
ORDER BY average_price DESC;