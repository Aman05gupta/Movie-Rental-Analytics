-- ============================================================
-- EDA Question 6
-- How does customer loyalty impact sales revenue over time?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Classify customers into segments based on rental count
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
-- Step 2: Analyze monthly revenue by customer segment
-- ------------------------------------------------------------

SELECT
    cs.customer_segment,
    YEAR(p.payment_date) AS payment_year,
    MONTH(p.payment_date) AS payment_month,
    ROUND(SUM(p.amount),2) AS total_revenue
FROM
(
    SELECT
        customer_id,
        CASE
            WHEN COUNT(rental_id) BETWEEN 12 AND 20 THEN 'Low Activity'
            WHEN COUNT(rental_id) BETWEEN 21 AND 30 THEN 'Regular Customer'
            ELSE 'Loyal Customer'
        END AS customer_segment
    FROM rental
    GROUP BY customer_id
) cs
JOIN payment p
    ON cs.customer_id = p.customer_id
GROUP BY
    cs.customer_segment,
    YEAR(p.payment_date),
    MONTH(p.payment_date)
ORDER BY
    payment_year,
    payment_month,
    customer_segment;

    
 -- ------------------------------------------------------------
-- Step 3: Compare overall revenue contribution
-- ------------------------------------------------------------

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_spent),2) AS total_revenue,
    ROUND(AVG(total_spent),2) AS average_spending
FROM
(
    SELECT
        c.customer_id,
        CASE
            WHEN COUNT(r.rental_id) BETWEEN 12 AND 20 THEN 'Low Activity'
            WHEN COUNT(r.rental_id) BETWEEN 21 AND 30 THEN 'Regular Customer'
            ELSE 'Loyal Customer'
        END AS customer_segment,
        SUM(p.amount) AS total_spent
    FROM customer c
    JOIN rental r
        ON c.customer_id = r.customer_id
    JOIN payment p
        ON r.rental_id = p.rental_id
    GROUP BY
        c.customer_id
) customer_summary
GROUP BY customer_segment
ORDER BY total_revenue DESC;   