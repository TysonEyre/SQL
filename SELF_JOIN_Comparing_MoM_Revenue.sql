-- Example SQL for using a SELF JOIN to compare rows within the same table
-- Business Case: It's time for end-of-year reporting. Highlight months where revenue was up month-over-month (MoM)
-- Using CTE of monthly_revenue, self join and compare rows to get a view of month-over-month

-- SQL request(s)​​​​​​‌​‌​​‌​‌​​​‌‌‌‌​‌​​​​​​​‌ below
with monthly_revenue as (
select 
    date_trunc('month', orderdate) as order_month, 
    sum(revenue) as monthly_revenue
from 
    subscriptions
group by 
    date_trunc('month', orderdate)
)

SELECT 
    current.order_month as Current_Month, previous.order_month as Previous_Month,
    current.monthly_revenue as Current_Revenue, previous.monthly_revenue as Previous_Revenue
FROM monthly_revenue current
JOIN monthly_revenue previous
WHERE datediff('month', previous.order_month, current.order_month) = 1 AND current.monthly_revenue > previous.monthly_revenue