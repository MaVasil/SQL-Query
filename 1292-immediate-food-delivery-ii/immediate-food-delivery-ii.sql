SELECT 
    ROUND(
        AVG(
            CASE 
                WHEN order_date = customer_pref_delivery_date THEN 1 
                ELSE 0 
            END
        ) * 100, 2
    ) AS immediate_percentage
FROM delivery d
WHERE order_date = (
    SELECT MIN(order_date)
    FROM delivery
    WHERE customer_id = d.customer_id
);