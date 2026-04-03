WITH season_data AS (
    SELECT 
        CASE 
            WHEN TO_CHAR(s.sale_date, 'MM') IN ('12','01','02') THEN 'Winter'
            WHEN TO_CHAR(s.sale_date, 'MM') IN ('03','04','05') THEN 'Spring'
            WHEN TO_CHAR(s.sale_date, 'MM') IN ('06','07','08') THEN 'Summer'
            ELSE 'Fall'
        END AS season,
        p.category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue
    FROM Sales s
    JOIN Products p 
    ON s.product_id = p.product_id
    GROUP BY 
        CASE 
            WHEN TO_CHAR(s.sale_date, 'MM') IN ('12','01','02') THEN 'Winter'
            WHEN TO_CHAR(s.sale_date, 'MM') IN ('03','04','05') THEN 'Spring'
            WHEN TO_CHAR(s.sale_date, 'MM') IN ('06','07','08') THEN 'Summer'
            ELSE 'Fall'
        END,
        p.category
),
ranked_data AS (
    SELECT 
        season,
        category,
        total_quantity,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY season
            ORDER BY 
                total_quantity DESC,
                total_revenue DESC,
                category ASC
        ) AS rn
    FROM season_data
)

SELECT 
    season,
    category,
    total_quantity,
    total_revenue
FROM ranked_data
WHERE rn = 1
ORDER BY season;