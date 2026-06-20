-- ============================================================
-- EDA Question 15
-- How does the availability of films in different languages
-- impact customer satisfaction and rental frequency?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Validate film distribution across languages
-- Purpose: Count films available in each language.
-- ------------------------------------------------------------

SELECT
    l.language_id,
    l.name AS language_name,
    COUNT(f.film_id) AS total_films
FROM language l
LEFT JOIN film f
    ON l.language_id = f.language_id
GROUP BY
    l.language_id,
    l.name
ORDER BY
    total_films DESC;
    
 -- ------------------------------------------------------------
-- Step 2: Analyze rental frequency by film language
-- Purpose: Count rentals for each language.
-- ------------------------------------------------------------

SELECT
    l.name AS language_name,
    COUNT(r.rental_id) AS total_rentals
FROM language l
LEFT JOIN film f
    ON l.language_id = f.language_id
LEFT JOIN inventory i
    ON f.film_id = i.film_id
LEFT JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY
    l.name
ORDER BY
    total_rentals DESC;   