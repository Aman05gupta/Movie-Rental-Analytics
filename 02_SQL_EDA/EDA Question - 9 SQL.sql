-- ============================================================
-- EDA Question 9
-- How does the proximity of stores to customers impact rental frequency?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Count customers assigned to each store
-- Purpose: Identify customer distribution across stores.
-- ------------------------------------------------------------

SELECT
    s.store_id,
    COUNT(c.customer_id) AS total_customers
FROM store s
JOIN customer c
    ON s.store_id = c.store_id
GROUP BY
    s.store_id
ORDER BY
    total_customers DESC;
    

-- ------------------------------------------------------------
-- Step 2: Calculate rental frequency for each store
-- Purpose: Measure customer rental activity by store.
-- ------------------------------------------------------------

SELECT
    s.store_id,
    COUNT(r.rental_id) AS total_rentals
FROM store s
JOIN customer c
    ON s.store_id = c.store_id
JOIN rental r
    ON c.customer_id = r.customer_id
GROUP BY
    s.store_id
ORDER BY
    total_rentals DESC;
    
    
-- ------------------------------------------------------------
-- Step 3: Calculate average rentals per customer for each store
-- Purpose: Compare customer engagement across stores.
-- ------------------------------------------------------------

SELECT
    s.store_id,
    ROUND(
        COUNT(r.rental_id) * 1.0 /
        COUNT(DISTINCT c.customer_id),
        2
    ) AS average_rentals_per_customer
FROM store s
JOIN customer c
    ON s.store_id = c.store_id
JOIN rental r
    ON c.customer_id = r.customer_id
GROUP BY
    s.store_id
ORDER BY
    average_rentals_per_customer DESC;    