SELECT 
    e1.student_id,
    e1.subject,
    e1.score AS first_score,
    e2.score AS latest_score
FROM scores e1
JOIN scores e2
ON e1.student_id = e2.student_id
AND e1.subject = e2.subject
WHERE e1.exam_date = (
    SELECT MIN(exam_date)
    FROM scores
    WHERE student_id = e1.student_id 
    AND subject = e1.subject
)
AND e2.exam_date = (
    SELECT MAX(exam_date)
    FROM scores
    WHERE student_id = e2.student_id 
    AND subject = e2.subject
)
AND e2.score > e1.score
order by e1.student_id,e1.subject;