SELECT 
    e.employee_id,
    e.name,
    t.reports_count,
    t.average_age
FROM employees e
JOIN (
    SELECT 
        reports_to,
        COUNT(*) AS reports_count,
        round(AVG(age)) AS average_age
    FROM employees
    WHERE reports_to IS NOT NULL
    GROUP BY reports_to
) t
ON e.employee_id = t.reports_to
order by e.employee_id;