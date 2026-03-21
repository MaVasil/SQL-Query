SELECT (
    SELECT MAX(salary)
    FROM employee
    WHERE salary < (SELECT MAX(salary) FROM employee)
) AS SecondHighestSalary
FROM dual;