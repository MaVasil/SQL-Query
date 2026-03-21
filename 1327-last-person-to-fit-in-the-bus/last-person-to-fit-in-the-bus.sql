SELECT *
FROM (
    SELECT person_name
    FROM (
        SELECT 
            person_name,
            SUM(weight) OVER (ORDER BY turn) AS total_weight
        FROM Queue
    )
    WHERE total_weight <= 1000
    ORDER BY total_weight DESC
)
WHERE ROWNUM = 1;