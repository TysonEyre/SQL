-- Example SQL unpivoting columns into rows using UNION
-- Business Case: Analyzing Subscription Cancellation Reasons
-- Calculate percentage of responses marked as 'Expensive'

-- SQL request(s)​​​​​​‌​‌​​‌​​‌​​​​‌‌‌​​​​​​‌​‌ below
with all_cancelation_reasons as(
    SELECT subscriptionid, cancelationreason1 as cancelationreason
    FROM cancelations
    UNION
    SELECT subscriptionid, cancelationreason2 as cancelationreason
    FROM cancelations
    UNION
    SELECT subscriptionid, cancelationreason3 as cancelationreason
    FROM cancelations
)

select 
    cast(count(
        case when cancelationreason = 'Expensive' 
        then subscriptionid end) as float)
    /count(distinct subscriptionid) as percent_expensive
from    
    all_cancelation_reasons
;