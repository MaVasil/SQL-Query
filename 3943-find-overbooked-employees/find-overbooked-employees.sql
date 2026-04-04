with heavy_weeks as (SELECT 
    employee_id,
    COUNT(*) AS meeting_heavy_weeks
FROM (
    SELECT 
        employee_id,
        TO_CHAR(meeting_date, 'IYYY') AS year,
        TO_CHAR(meeting_date, 'IW') AS week,
        SUM(duration_hours) AS total_duration
    FROM meetings
    GROUP BY 
        employee_id,
        TO_CHAR(meeting_date, 'IYYY'),
        TO_CHAR(meeting_date, 'IW')
) t
WHERE total_duration > 20
GROUP BY employee_id having count(*)>=2)

select h.employee_id,e.employee_name,e.department,h.meeting_heavy_weeks from heavy_weeks h join employees e on 
h.employee_id=e.employee_id order by h.meeting_heavy_weeks desc,e.employee_name asc;