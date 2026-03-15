CREATE TABLE customers (
customer_id SERIAL PRIMARY KEY,
customer_name VARCHAR(100),
country VARCHAR(50)
);

CREATE TABLE products (
product_id SERIAL PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
price NUMERIC(10,2)
);

CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT,
order_date DATE
);

CREATE TABLE order_items (
order_item_id SERIAL PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT
);