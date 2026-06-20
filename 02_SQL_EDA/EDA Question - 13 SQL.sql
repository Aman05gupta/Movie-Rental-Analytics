-- ============================================================
-- EDA Question 13
-- What are the busiest hours or days for each store location,
-- and how does it impact staffing requirements?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Find the busiest days for each store
-- Purpose: Count rentals by day of the week.
-- ------------------------------------------------------------

SELECT
    c.store_id,
    DAYNAME(r.rental_date) AS rental_day,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN customer c
    ON r.customer_id = c.customer_id
GROUP BY
    c.store_id,
    DAYNAME(r.rental_date)
ORDER BY
    c.store_id,
    total_rentals DESC;
    
    
-- ------------------------------------------------------------
-- Step 2: Find the busiest hours for each store
-- Purpose: Count rentals by hour.
-- ------------------------------------------------------------

SELECT
    c.store_id,
    HOUR(r.rental_date) AS rental_hour,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN customer c
    ON r.customer_id = c.customer_id
GROUP BY
    c.store_id,
    HOUR(r.rental_date)
ORDER BY
    c.store_id,
    total_rentals DESC;
    
 -- ------------------------------------------------------------
-- Step 3: Compare overall rental workload
-- Purpose: Calculate total rentals by store.
-- ------------------------------------------------------------

SELECT
    c.store_id,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN customer c
    ON r.customer_id = c.customer_id
GROUP BY
    c.store_id
ORDER BY
    total_rentals DESC;   