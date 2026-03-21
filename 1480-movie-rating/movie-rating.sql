SELECT MIN(u.name) AS results
FROM users u
JOIN (
    SELECT user_id, COUNT(*) AS rating_count
    FROM movieRating
    GROUP BY user_id
    HAVING COUNT(*) = (
        SELECT MAX(cnt)
        FROM (
            SELECT COUNT(*) AS cnt
            FROM movieRating
            GROUP BY user_id
        )
    )
) m
ON u.user_id = m.user_id

UNION ALL

SELECT MIN(mv.title) AS results
FROM movies mv
JOIN (
    SELECT movie_id, AVG(rating) AS avg_rating
    FROM movieRating
    WHERE TO_CHAR(created_at, 'YYYY-MM') = '2020-02'
    GROUP BY movie_id
    HAVING AVG(rating) = (
        SELECT MAX(avg_rating)
        FROM (
            SELECT movie_id, AVG(rating) AS avg_rating
            FROM movieRating
            WHERE TO_CHAR(created_at, 'YYYY-MM') = '2020-02'
            GROUP BY movie_id
        )
    )
) t
ON mv.movie_id = t.movie_id;