SELECT p.product_name, SUM(o.unit) AS unit
FROM orders o
JOIN products p 
  ON p.product_id = o.product_id
WHERE to_char(o.order_date,'yyyy-mm') = '2020-02'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;