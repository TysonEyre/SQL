-- Example SQL for performing analysis on the payment funnel
-- Business Case: The product manager wants to know how far users are getting in the process and when they are falling out
-- There are 6 stages to consider as the user moves through the payment funnel
-- 0. Error 1. PaymentWidgetOpened 2. PaymentEntered 3. PaymentSubmitted 4. PaymentSuccess 5. Complete

-- Create CTE maxstatusreached to grab the max status of each subscriptionID
WITH maxstatusreached AS (
	SELECT 
        subscriptionid, 
        MAX(STATUSID) as maxstatus
	FROM paymentstatuslog
	GROUP BY subscriptionid
)
,
-- Create 2nd CTE paymentfunnelstages which joins CTE maxstatusreached to the subscriptions table and maps status IDs to business acumen
paymentfunnelstages AS (
	SELECT s.subscriptionid,
        -- CASE statements to map IDs to Business Acumen
	    case when maxstatus = 1 then 'PaymentWidgetOpened'
			when maxstatus = 2 then 'PaymentEntered'
			when maxstatus = 3 and currentstatus = 0 then 'User Error with Payment Submission'
			when maxstatus = 3 and currentstatus != 0 then 'Payment Submitted'
			when maxstatus = 4 and currentstatus = 0 then 'Payment Processing Error with Vendor'
			when maxstatus = 4 and currentstatus != 0 then 'Payment Success'
			when maxstatus = 5 then 'Complete'
			when maxstatus is null then 'User did not start payment process'
			end as paymentfunnelstage
	FROM subscriptions s 
    LEFT JOIN maxstatusreached m 
    ON s.subscriptionid = m.subscriptionid
)

SELECT 
    paymentfunnelstage, 
    COUNT(subscriptionid) AS subscriptions
FROM paymentfunnelstages
GROUP BY paymentfunnelstage