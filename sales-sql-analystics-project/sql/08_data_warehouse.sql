-- ======================================
-- DATA WAREHOUSE STRUCTURE (STAR SCHEMA)
-- ======================================

-- Customer Dimension

CREATE TABLE dim_customer AS
SELECT
customer_id,
country
FROM customers;


-- Product Dimension

CREATE TABLE dim_product AS
SELECT
product_id,
product_name,
category,
price
FROM products;


-- Date Dimension

CREATE TABLE dim_date AS
SELECT DISTINCT
order_date AS date,
EXTRACT(YEAR FROM order_date) AS year,
EXTRACT(MONTH FROM order_date) AS month,
DATE_TRUNC('month', order_date) AS month_start
FROM orders;


-- Sales Fact Table

CREATE TABLE fact_sales AS
SELECT
o.order_id,
o.order_date,
o.customer_id,
oi.product_id,
oi.quantity,
p.price,
(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;


-- Example Analytical Query

SELECT
d.month_start,
SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_date d ON f.order_date = d.date
GROUP BY d.month_start
ORDER BY d.month_start;