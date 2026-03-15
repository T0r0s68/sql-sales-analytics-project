-- ======================================
-- MARKET BASKET ANALYSIS
-- ======================================

-- Product Pairs Bought Together

SELECT
p1.product_name AS product_1,
p2.product_name AS product_2,
COUNT() AS times_bought_together
FROM order_items oi1
JOIN order_items oi2
ON oi1.order_id = oi2.order_id
AND oi1.product_id < oi2.product_id
JOIN products p1 ON oi1.product_id = p1.product_id
JOIN products p2 ON oi2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
ORDER BY times_bought_together DESC
LIMIT 20;


-- Products Frequently Bought with a Specific Product

SELECT
p2.product_name,
COUNT() AS times_bought_together
FROM order_items oi1
JOIN order_items oi2
ON oi1.order_id = oi2.order_id
AND oi1.product_id <> oi2.product_id
JOIN products p1 ON oi1.product_id = p1.product_id
JOIN products p2 ON oi2.product_id = p2.product_id
WHERE p1.product_name = 'Product_1'
GROUP BY p2.product_name
ORDER BY times_bought_together DESC
LIMIT 10;