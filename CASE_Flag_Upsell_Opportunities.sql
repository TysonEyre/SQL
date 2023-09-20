-- Example SQL for flagging potential current customers for an upsell opportunity for the sales team
-- Business Case: The sales team needs help identifying who they should target for the upsell opportunities. This SQL query creates a binary column that flags the customers that meet these conditions.
-- The target customer meets the following conditions
-- 1. Have >= 5000 registered users
-- 2. Only have 1 product subscription

-- SQL request(s)​​​​​​‌​‌​​‌​​‌​​​​‌‌​​​‌‌​​‌​​ below
-- SELECT customerid, count(products), count(users), flagColumn
SELECT 
    customerid, 
    COUNT(PRODUCTID) as num_products, 
    SUM(NUMBEROFUSERS) as total_users,
    CASE 
        WHEN SUM(NUMBEROFUSERS) >= 5000 OR COUNT(PRODUCTID) = 1 THEN 1
        ELSE 0
    END AS upsell_opportunity
-- FROM subscriptions
FROM subscriptions
-- GROUP BY customerid
GROUP BY customerid;