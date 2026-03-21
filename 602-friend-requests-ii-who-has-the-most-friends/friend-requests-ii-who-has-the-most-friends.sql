SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM requestaccepted
    UNION ALL
    SELECT accepter_id AS id FROM requestaccepted
) t
GROUP BY id
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT id, COUNT(*) AS cnt
        FROM (
            SELECT requester_id AS id FROM requestaccepted
            UNION ALL
            SELECT accepter_id AS id FROM requestaccepted
        )
        GROUP BY id
    )
);