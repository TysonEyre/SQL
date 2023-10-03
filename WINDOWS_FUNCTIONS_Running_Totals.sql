-- Example SQL calculating running totals using window functions
-- Business Case:  
-- Window Functions are designed to rank values within a certain group, or windows withing rows.
-- Window Funcitons to Rank Values. 1. row_number() 2. rank() 3. dense_rank()

WITH sale_ranks as (
    SELECT
        salesemployeeid,
        saleamount,
        SaleDate,
        row_number() over(partition by salesemployeeid order by saledate desc) AS most_recent_sale
    FROM
        sales
)

SELECT *
FROM sale_ranks
WHERE most_recent_sale = 1;