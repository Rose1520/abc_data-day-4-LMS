USE ABC_DATA;

-- which customer has the most orders
SELECT * FROM orders;
-- temporary table
WITH order_counts AS (
SELECT customer_id ,count(order_id) AS order_count
FROM orders
GROUP BY customer_id),
-- another temp table
max_order_count AS (
SELECT max(order_count) as max_count
FROM order_counts)
SELECT c.first_name, c.last_name
FROM customers AS c
JOIN order_counts oc ON c.customer_id = oc.customer_id
JOIN max_order_count moc ON oc.order_count = moc.max_count
LIMIT 1;


-- total revenue per product
SELECT p.product_name,
        p.price * sum(oi.quantity) AS total_revenue
        FROM products as p
        JOIN order_items oi ON oi.product_id = p.product_id
        GROUP BY p.price, p.product_id
        ORDER BY 2 desc;