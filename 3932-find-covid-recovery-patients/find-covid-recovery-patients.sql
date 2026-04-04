WITH first_positive AS (
    SELECT 
        patient_id,
        MIN(test_date) AS first_positive_date
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
),
first_negative AS (
    SELECT 
        ct.patient_id,
        MIN(ct.test_date) AS first_negative_date
    FROM covid_tests ct
    JOIN first_positive fp 
        ON ct.patient_id = fp.patient_id
    WHERE 
        ct.result = 'Negative'
        AND ct.test_date > fp.first_positive_date
    GROUP BY ct.patient_id
)
SELECT 
    p.patient_id,
    p.patient_name,
    p.age,
    (fn.first_negative_date - fp.first_positive_date) AS recovery_time
FROM patients p
JOIN first_positive fp 
    ON p.patient_id = fp.patient_id
JOIN first_negative fn 
    ON p.patient_id = fn.patient_id
ORDER BY recovery_time ASC, p.patient_name ASC;