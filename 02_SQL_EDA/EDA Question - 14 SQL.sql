-- ============================================================
-- EDA Question 14
-- What are the cultural or demographic factors that influence
-- customer preferences in different locations?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Analyze film category preference by country
-- Purpose: Identify category popularity across countries.
-- ------------------------------------------------------------

SELECT
    co.country,
    cat.name AS category_name,
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
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category cat
    ON fc.category_id = cat.category_id
GROUP BY
    co.country,
    cat.name
ORDER BY
    co.country,
    total_rentals DESC;
    
-- ------------------------------------------------------------
-- Step 2: Analyze film category preference by city
-- Purpose: Identify local customer preferences.
-- ------------------------------------------------------------

SELECT
    ci.city,
    cat.name AS category_name,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN customer c
    ON r.customer_id = c.customer_id
JOIN address a
    ON c.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category cat
    ON fc.category_id = cat.category_id
GROUP BY
    ci.city,
    cat.name
ORDER BY
    ci.city,
    total_rentals DESC;    