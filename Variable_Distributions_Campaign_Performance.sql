-- Example SQL for exploring variable distributions with CTEs
-- Business Case: A manager on the marketing team wants to understand the performance of their recent email campaign. The manager wants to know how many users clicked the link in the email.
-- How many users clicked the email link one time, two times, three times, and so on?
-- Example of using a CTE to COUNT instances of one value and then subsequently use that column as a GROUP BY with the COUNT of the other desired column

-- Create USER_LINK_CLICKS CTE
WITH USER_LINK_CLICKS AS (
    -- SELECT USERID and a COUNT of EVENTID aliased as NUM_LINK_CLICKS
    SELECT 
        USERID, 
        COUNT(EVENTID) AS NUM_LINK_CLICKS
    FROM frontendeventlog
    -- FILTER results by the EVENTID = 5 meaning the user reached a unique landing page only accessbile through campaign email
    WHERE EVENTID = 5
    -- GROUP BY USERID
    GROUP BY USERID
)

-- Query utilizing CTE to GROUP BY the aggregated column from above
-- SELECT CTE Column NUM_LINK_CLICKS, and a COUNT of USERID aliased as NUM_USERS
SELECT 
    NUM_LINK_CLICKS, 
    COUNT(USERID) AS NUM_USERS
FROM USER_LINK_CLICKS
-- GROUP BY aggregated CTE column
GROUP BY NUM_LINK_CLICKS;