-- Example SQL for pivoting rows of data into aggregated columns with CASE
-- Business Case: Tracking user activity with frontend events (AB Testing)
-- Tracking the following events
-- When a user views help center page, when a user clicks FAQs, when a user clicks contact support, when a user clicks submit

-- SELECT UserID and Aggregate CASE statements
SELECT 
    l.userid, 
    SUM(CASE WHEN l.eventid = 1 THEN 1 ELSE 0 END) AS viewedhelpcenterpage,
    SUM(CASE WHEN l.eventid = 2 THEN 1 ELSE 0 END) AS clickedfaqs,
    SUM(CASE WHEN l.eventid = 3 THEN 1 ELSE 0 END) AS clickedcontactsupport,
    SUM(CASE WHEN l.eventid = 4 THEN 1 ELSE 0 END) AS submittedticket
-- Join FrontendEventLog table and FrontendEventDefinitions table
FROM frontendeventlog l LEFT JOIN frontendeventdefinitions d ON l.eventid = d.eventid
-- Filter table for customer support
WHERE eventtype = 'Customer Support'
GROUP BY l.USERID;