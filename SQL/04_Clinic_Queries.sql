-- ==========================================================
-- 04_Clinic_Queries.sql
-- Solutions for Part B (Questions 1-5)
-- ==========================================================

-- 1. Find the revenue we got from each sales channel in a given year (e.g., 2021)
SELECT sales_channel, SUM(amount) AS total_revenue
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime) = 2021
GROUP BY sales_channel;


-- 2. Find top 10 the most valuable customers for a given year (e.g., 2021)
SELECT uid, SUM(amount) AS total_spent
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;


-- 3. Find month wise revenue, expense, profit, status (profitable / not-profitable) for a given year
WITH MonthlyRev AS (
    SELECT EXTRACT(MONTH FROM datetime) as mth, SUM(amount) as revenue
    FROM clinic_sales 
    WHERE EXTRACT(YEAR FROM datetime) = 2021 
    GROUP BY 1
),
MonthlyExp AS (
    SELECT EXTRACT(MONTH FROM datetime) as mth, SUM(amount) as expense
    FROM expenses 
    WHERE EXTRACT(YEAR FROM datetime) = 2021 
    GROUP BY 1
)
SELECT COALESCE(r.mth, e.mth) as month,
       COALESCE(revenue, 0) as revenue,
       COALESCE(expense, 0) as expense,
       (COALESCE(revenue, 0) - COALESCE(expense, 0)) as profit,
       CASE WHEN (COALESCE(revenue, 0) - COALESCE(expense, 0)) >= 0 
            THEN 'Profitable' ELSE 'Not-Profitable' END as status
FROM MonthlyRev r
FULL OUTER JOIN MonthlyExp e ON r.mth = e.mth
ORDER BY month;


-- 4. For each city find the most profitable clinic for a given month (e.g., Month 9)
WITH ClinicProfit AS (
    SELECT c.city, c.cid, 
           (SUM(COALESCE(s.amount, 0)) - SUM(COALESCE(e.amount, 0))) as profit
    FROM clinics c
    LEFT JOIN clinic_sales s ON c.cid = s.cid AND EXTRACT(MONTH FROM s.datetime) = 9
    LEFT JOIN expenses e ON c.cid = e.cid AND EXTRACT(MONTH FROM e.datetime) = 9
    GROUP BY c.city, c.cid
)
SELECT city, cid, profit
FROM (
    SELECT *, RANK() OVER(PARTITION BY city ORDER BY profit DESC) as rnk
    FROM ClinicProfit
) t 
WHERE rnk = 1;


-- 5. For each state find the second least profitable clinic for a given month (e.g., Month 9)
WITH StateProfit AS (
    SELECT c.state, c.cid, 
           (SUM(COALESCE(s.amount, 0)) - SUM(COALESCE(e.amount, 0))) as profit
    FROM clinics c
    LEFT JOIN clinic_sales s ON c.cid = s.cid AND EXTRACT(MONTH FROM s.datetime) = 9
    LEFT JOIN expenses e ON c.cid = e.cid AND EXTRACT(MONTH FROM e.datetime) = 9
    GROUP BY c.state, c.cid
)
SELECT state, cid, profit
FROM (
    SELECT *, DENSE_RANK() OVER(PARTITION BY state ORDER BY profit ASC) as rnk
    FROM StateProfit
) t 
WHERE rnk = 2;