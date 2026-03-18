/* Write your PL/SQL query statement below */
SELECT project_id,ROUND(AVG(experience_years),2) AS average_years
FROM PROJECT p INNER JOIN EMPLOYEE e ON p.employee_id=e.employee_id 
GROUP BY project_id;
