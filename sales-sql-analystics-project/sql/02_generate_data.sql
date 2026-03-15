TRUNCATE TABLE order_items, orders, products, customers RESTART IDENTITY;

INSERT INTO customers (customer_name, country)
SELECT
'Customer_' || g,
CASE
WHEN random() < 0.2 THEN 'USA'
WHEN random() < 0.4 THEN 'Germany'
WHEN random() < 0.6 THEN 'France'
WHEN random() < 0.8 THEN 'UK'
ELSE 'Canada'
END
FROM generate_series(1,2500) g;

INSERT INTO products (product_name, category, price)
SELECT
'Product_' || g,
CASE
WHEN random() < 0.3 THEN 'Electronics'
WHEN random() < 0.6 THEN 'Furniture'
ELSE 'Accessories'
END,
round((random()*900 + 50)::numeric,2)
FROM generate_series(1,500) g;

INSERT INTO orders (customer_id, order_date)
SELECT
floor(random()*2500 + 1),
date '2023-01-01' + (random()*365)::int
FROM generate_series(1,8000);

INSERT INTO order_items (order_id, product_id, quantity)
SELECT
floor(random()*8000 + 1),
floor(random()*500 + 1),
floor(random()*5 + 1)
FROM generate_series(1,20000);
