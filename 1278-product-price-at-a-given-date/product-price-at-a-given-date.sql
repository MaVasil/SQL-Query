SELECT 
    p.product_id,
    COALESCE(p2.new_price, 10) AS price
FROM (
    SELECT DISTINCT product_id FROM products
) p
LEFT JOIN (
    SELECT product_id, MAX(change_date) AS change_date
    FROM products
    WHERE change_date <= DATE '2019-08-16'
    GROUP BY product_id
) t
ON p.product_id = t.product_id
LEFT JOIN products p2
ON p2.product_id = t.product_id 
AND p2.change_date = t.change_date;