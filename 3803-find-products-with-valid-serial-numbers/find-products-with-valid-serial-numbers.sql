SELECT * 
FROM products 
WHERE REGEXP_LIKE(description, '(^| )SN[0-9]{4}-[0-9]{4}( |$)') order by product_id;