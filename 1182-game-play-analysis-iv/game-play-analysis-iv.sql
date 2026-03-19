WITH total_info AS (
    -- Step 1: Get the total count of distinct players once
    SELECT COUNT(DISTINCT player_id) AS total_players 
    FROM activity
),
consecutive_logins AS (
    -- Step 2: Count players who logged in the day after their first login
    SELECT COUNT(DISTINCT player_id) AS matching_players
    FROM activity
    WHERE (player_id, TRUNC(event_date) - 1) IN (
        SELECT player_id, MIN(TRUNC(event_date))
        FROM activity
        GROUP BY player_id
    )
)
-- Step 3: Simply divide the two numbers
SELECT 
    ROUND(matching_players / total_players, 2) AS fraction
FROM consecutive_logins, total_info;