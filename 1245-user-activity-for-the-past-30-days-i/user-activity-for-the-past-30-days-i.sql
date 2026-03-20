SELECT 
    TO_CHAR(TRUNC(activity_date), 'YYYY-MM-DD') AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM activity
WHERE activity_date >= DATE '2019-06-28'
  AND activity_date <= DATE '2019-07-27'
GROUP BY TRUNC(activity_date)
ORDER BY day;