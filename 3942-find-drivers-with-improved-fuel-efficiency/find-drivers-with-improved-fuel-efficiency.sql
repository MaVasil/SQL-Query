WITH avg_per_half AS (
    SELECT 
        driver_id,
        MAX(CASE WHEN half = 'first' THEN avg_eff END) AS first_half_avg,
        MAX(CASE WHEN half = 'second' THEN avg_eff END) AS second_half_avg
    FROM (
        SELECT driver_id, half, AVG(efficiency) AS avg_eff
        FROM (
            SELECT 
                driver_id,
                distance_km / fuel_consumed AS efficiency,
                CASE 
                    WHEN EXTRACT(MONTH FROM trip_date) <= 6 THEN 'first'
                    ELSE 'second'
                END AS half
            FROM trips
        ) t1
        GROUP BY driver_id, half
    ) t2
    GROUP BY driver_id
)
SELECT 
    d.driver_id,
    d.driver_name,
    ROUND(a.first_half_avg, 2) AS first_half_avg,
    ROUND(a.second_half_avg, 2) AS second_half_avg,
    ROUND(a.second_half_avg - a.first_half_avg, 2) AS efficiency_improvement
FROM avg_per_half a
JOIN drivers d 
    ON a.driver_id = d.driver_id
WHERE 
    a.first_half_avg IS NOT NULL
    AND a.second_half_avg IS NOT NULL
    AND a.second_half_avg - a.first_half_avg>0
ORDER BY 
    efficiency_improvement DESC,
    d.driver_name ASC;