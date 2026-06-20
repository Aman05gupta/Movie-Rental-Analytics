-- ============================================================
-- EDA Question 7
-- Are certain film categories more popular in specific locations?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Analyze film category popularity by country
-- Purpose: Count rentals for each film category in every country.
-- ------------------------------------------------------------

SELECT co.country, c.name AS category_name,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
JOIN customer cu
    ON r.customer_id = cu.customer_id
JOIN address a
    ON cu.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
JOIN country co
    ON ci.country_id = co.country_id
GROUP BY co.country, c.name
ORDER BY co.country, total_rentals DESC;
    
    
    
-- ------------------------------------------------------------
-- Step 2: Analyze film category popularity by city
-- Purpose: Count rentals for each film category in every city.
-- ------------------------------------------------------------

SELECT
    ci.city,
    c.name AS category_name,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
JOIN customer cu
    ON r.customer_id = cu.customer_id
JOIN address a
    ON cu.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
GROUP BY
    ci.city,
    c.name
ORDER BY
    ci.city,
    total_rentals DESC;    
    
    
    
-- ------------------------------------------------------------
-- Step 3: Identify the most popular film categories overall
-- Purpose: Rank categories based on total rentals.
-- ------------------------------------------------------------

SELECT
    c.name AS category_name,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
GROUP BY
    c.name
ORDER BY
    total_rentals DESC;    