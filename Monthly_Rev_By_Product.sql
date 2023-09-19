-- Example SQL for calculating descriptive statistics for monthly revenue by product
-- Business Case: The leadership team is making 2023 goals and wants to understand how much revenue each of the product subscriptions, basic and expert, are generating each month.
-- They have asked the following questions
-- 1. How much revenue does each product usually generate each month?
-- 2. Which product had the most success throughout all of last year?
-- 3. Did either product fluctuate greatly each month or was the month-to-month trend fairly consistent?
-- Example of using a CTE to calculate the SUM and consequently the MIN, the MAX, the AVG, and the STDDEV

-- Create MonthlyProduct CTE
WITH MonthlyProduct AS (
    -- SELECT ProductName, Sum of Revenue, Standardized Order Date by Month
    SELECT 
        p.productname, 
        SUM(s.revenue) as revenue, 
        date_trunc('month', s.ORDERDATE) AS Monthly_Order
    -- JOIN Products p and Subscritions s  on ProductID
    FROM Products p JOIN Subscriptions s
    ON p.PRODUCTID = s.PRODUCTID
    -- Filter results for only 2022
    WHERE s.ORDERDATE BETWEEN '2022-01-01' AND '2022-12-31'
    -- Group by ProductName and Order Month
    GROUP BY p.PRODUCTNAME, Monthly_Order
)

-- Query utilizing the CTE MonthlyProduct to calculate based on the Sum of Revenue
-- SELECT ProductName, Min Monthly Revenue, Max Monthly Revenue, Average Monthly Revenue, and the Standard Deviaiton of Monthly Revenue
SELECT 
    PRODUCTNAME, 
    MIN(MonthlyProduct.REVENUE) AS MIN_REV, 
    MAX(MonthlyProduct.REVENUE) AS MAX_REV, 
    AVG(MonthlyProduct.REVENUE) AS AVG_REV, 
    STDDEV(MonthlyProduct.REVENUE) AS STD_DEV_REV
-- FROM the MonthlyProduct CTE
FROM MonthlyProduct
-- Group by ProductName
GROUP BY PRODUCTNAME;