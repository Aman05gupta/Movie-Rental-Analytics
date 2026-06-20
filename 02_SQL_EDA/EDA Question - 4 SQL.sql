-- =========================================================================
-- EDA Question 4
-- Are there seasonal trends in customer behavior across different locations?
-- ==========================================================================

-- ------------------------------------------------------------
-- Step 1: Analyze monthly rental trends by country
-- Purpose: Count total rentals for each month in every country.
-- ------------------------------------------------------------

SELECT
    co.country,
    MONTH(r.rental_date) AS rental_month,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN customer c
    ON r.customer_id = c.customer_id
JOIN address a
    ON c.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
JOIN country co
    ON ci.country_id = co.country_id
GROUP BY co.country, MONTH(r.rental_date)
ORDER BY co.country, rental_month;
    
    
-- ------------------------------------------------------------
-- Step 2: Analyze monthly rental trends by city
-- Purpose: Compare customer rental activity across cities.
-- ------------------------------------------------------------

SELECT
    ci.city,
    MONTH(r.rental_date) AS rental_month,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN customer c
    ON r.customer_id = c.customer_id
JOIN address a
    ON c.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
GROUP BY ci.city, MONTH(r.rental_date)
ORDER BY ci.city, rental_month;    
    
    
-- ------------------------------------------------------------
-- Step 3: Identify peak rental months
-- Purpose: Determine seasonal rental demand.
-- ------------------------------------------------------------

SELECT
    MONTH(rental_date) AS rental_month,
    COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY MONTH(rental_date)
ORDER BY total_rentals DESC;    