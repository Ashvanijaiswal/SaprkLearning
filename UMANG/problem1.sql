/*
Table-1 : Drivers : []List of drivers with Id as primary key]
Id : int
Name : varchar

Table-2 : Details of drivers opening drvier app (No primary key): []Just a logging table with logs of Ids and their open timestamps]
Id : int
open_ts : timestamp

Question: Find drivers who have logged in for 5 or more consecutive dates ordered by Id

*/

SQL
WITH ConsecutiveLogins AS (
    SELECT
        d.Id,
        d.Name,
        DATE_DIFF(l.open_ts, LAG(l.open_ts) OVER (PARTITION BY d.Id ORDER BY l.open_ts), DAY) AS days_diff
    FROM
        Drivers d
    JOIN
        Details l ON d.Id = l.Id
)
SELECT
    Id,
    Name
FROM
    ConsecutiveLogins
GROUP BY
    Id
HAVING
    COUNT(*) >= 5
ORDER BY
    Id;
