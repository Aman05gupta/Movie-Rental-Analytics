-- ============================================================
-- EDA Question 2
-- Which films have the highest rental rates and are most in demand?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Count the total number of rentals for each film
-- Purpose: Identify the demand for each film based on rental count.
-- ------------------------------------------------------------

SELECT
    f.film_id,
    f.title AS film_title,
    COUNT(r.rental_id) AS total_rentals
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title
ORDER BY total_rentals DESC;


-- ------------------------------------------------------------
-- Step 2: Retrieve the Top 10 most rented films
-- Purpose: Identify the highest-demand films.
-- ------------------------------------------------------------

SELECT
    f.film_id,
    f.title AS film_title,
    COUNT(r.rental_id) AS total_rentals
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title
ORDER BY total_rentals DESC
LIMIT 10; 


-- ------------------------------------------------------------
-- Step 3: Compare rental demand with rental rates
-- Purpose: Display rental rate along with total rentals.
-- ------------------------------------------------------------

SELECT
    f.film_id,
    f.title AS film_title,
    f.rental_rate,
    COUNT(r.rental_id) AS total_rentals
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title,
    f.rental_rate
ORDER BY total_rentals DESC;