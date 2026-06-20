-- ============================================================
-- EDA Question 12
-- How does the availability of inventory impact customer
-- satisfaction and repeat business?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Calculate inventory availability for each film
-- Purpose: Count available inventory copies.
-- ------------------------------------------------------------

SELECT
    f.film_id,
    f.title,
    COUNT(i.inventory_id) AS total_inventory
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
GROUP BY
    f.film_id,
    f.title
ORDER BY
    total_inventory DESC;

    
-- ------------------------------------------------------------
-- Step 2: Compare inventory availability with rental demand
-- ------------------------------------------------------------

SELECT
    f.film_id,
    f.title,
    COUNT(DISTINCT i.inventory_id) AS total_inventory,
    COUNT(r.rental_id) AS total_rentals
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
LEFT JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title
ORDER BY
    total_rentals DESC;
    


