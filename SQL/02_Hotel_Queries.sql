-- ==========================================================
-- 02_Hotel_Queries.sql
-- Solutions for Part A (Questions 1-5)
-- ==========================================================

-- 1. For every user in the system, get the user_id and last booked room_no
SELECT user_id, room_no
FROM (
    SELECT user_id, room_no,
           ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY booking_date DESC) as rn
    FROM bookings
) t
WHERE rn = 1;


-- 2. Get booking_id and total billing amount of every booking created in November, 2021
SELECT b.booking_id, SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE b.booking_date >= '2021-11-01' AND b.booking_date < '2021-12-01'
GROUP BY b.booking_id;


-- 3. Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount > 1000
SELECT bc.bill_id, SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date >= '2021-10-01' AND bc.bill_date < '2021-11-01'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;


-- 4. Determine the most ordered and least ordered item of each month of year 2021
WITH MonthlyOrders AS (
    SELECT EXTRACT(MONTH FROM bill_date) as month_num, 
           item_id, 
           SUM(item_quantity) as total_qty
    FROM booking_commercials
    WHERE EXTRACT(YEAR FROM bill_date) = 2021
    GROUP BY 1, 2
),
RankedItems AS (
    SELECT month_num, item_id, total_qty,
           RANK() OVER(PARTITION BY month_num ORDER BY total_qty DESC) as most_rank,
           RANK() OVER(PARTITION BY month_num ORDER BY total_qty ASC) as least_rank
    FROM MonthlyOrders
)
SELECT month_num, item_id, total_qty,
       CASE WHEN most_rank = 1 THEN 'Most Ordered' ELSE 'Least Ordered' END as status
FROM RankedItems
WHERE most_rank = 1 OR least_rank = 1;


-- 5. Find the customers with the second highest bill value of each month of year 2021
WITH MonthlyUserBills AS (
    SELECT EXTRACT(MONTH FROM bc.bill_date) as month_num,
           b.user_id,
           SUM(bc.item_quantity * i.item_rate) as total_bill_value
    FROM bookings b
    JOIN booking_commercials bc ON b.booking_id = bc.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE EXTRACT(YEAR FROM bc.bill_date) = 2021
    GROUP BY 1, 2
),
RankedBills AS (
    SELECT month_num, user_id, total_bill_value,
           DENSE_RANK() OVER(PARTITION BY month_num ORDER BY total_bill_value DESC) as rnk
    FROM MonthlyUserBills
)
SELECT month_num, user_id, total_bill_value
FROM RankedBills
WHERE rnk = 2;