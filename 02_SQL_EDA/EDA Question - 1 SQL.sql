-- ============================================================
-- EDA Question 1
-- What are the purchasing patterns of new customers versus repeat customers?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Calculate the total number of rentals made by each customer
-- Purpose: To identify how many times each customer has rented a film.
-- ------------------------------------------------------------

SELECT
    customer_id,
    COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY customer_id
ORDER BY total_rentals DESC;


-- ------------------------------------------------------------
-- Step 2: Classify customers into different segments
-- Purpose: Categorize customers based on their rental frequency.
--
-- Low Activity     : 12 - 20 Rentals
-- Regular Customer : 21 - 30 Rentals
-- Loyal Customer   : 31+ Rentals
-- ------------------------------------------------------------

SELECT
    customer_id,
    COUNT(rental_id) AS total_rentals,
    CASE
        WHEN COUNT(rental_id) BETWEEN 12 AND 20 THEN 'Low Activity'
        WHEN COUNT(rental_id) BETWEEN 21 AND 30 THEN 'Regular Customer'
        ELSE 'Loyal Customer'
    END AS customer_segment
FROM rental
GROUP BY customer_id;

-- ------------------------------------------------------------
-- Step 3: Compare total spending across customer segments
-- Purpose:
-- 1. Count total customers in each segment.
-- 2. Calculate total revenue generated.
-- 3. Calculate average spending per customer.
-- ------------------------------------------------------------

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS average_spending
FROM
(
    SELECT c.customer_id,
        CASE
            WHEN COUNT(r.rental_id) BETWEEN 12 AND 20 THEN 'Low Activity'
            WHEN COUNT(r.rental_id) BETWEEN 21 AND 30 THEN 'Regular Customer'
            ELSE 'Loyal Customer'
        END AS customer_segment, SUM(p.amount) AS total_spent
    FROM customer c
    JOIN rental r
        ON c.customer_id = r.customer_id
    JOIN payment p
        ON r.rental_id = p.rental_id
    GROUP BY c.customer_id
) AS customer_summary
GROUP BY customer_segment
ORDER BY total_revenue DESC;

-- ------------------------------------------------------------
-- Step 4: Compare rental frequency across customer segments
-- Purpose:
-- Calculate the average number of rentals for each customer segment
-- to understand customer engagement levels.
-- ------------------------------------------------------------

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(total_rentals), 2) AS average_rentals
FROM
(
    SELECT
        customer_id,
        COUNT(rental_id) AS total_rentals,
        CASE
            WHEN COUNT(rental_id) BETWEEN 12 AND 20 THEN 'Low Activity'
            WHEN COUNT(rental_id) BETWEEN 21 AND 30 THEN 'Regular Customer'
            ELSE 'Loyal Customer'
        END AS customer_segment
    FROM rental
    GROUP BY customer_id
) AS customer_summary
GROUP BY customer_segment
ORDER BY average_rentals DESC;