-- ============================================================
-- EDA Question 11
-- What are the demographics and preferences of the highest-spending customers?
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Identify the highest-spending customers
-- Purpose: Calculate total spending by each customer.
-- ------------------------------------------------------------

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(p.amount), 2) AS total_spending
FROM customer c
JOIN payment p
    ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    total_spending DESC
LIMIT 10;


-- ------------------------------------------------------------
-- Step 2: Analyze demographics of highest-spending customers
-- Purpose: Retrieve city and country information.
-- ------------------------------------------------------------

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ci.city,
    co.country,
    ROUND(SUM(p.amount), 2) AS total_spending
FROM customer c
JOIN payment p
    ON c.customer_id = p.customer_id
JOIN address a
    ON c.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
JOIN country co
    ON ci.country_id = co.country_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    ci.city,
    co.country
ORDER BY
    total_spending DESC
LIMIT 10;


-- ------------------------------------------------------------
-- Step 3: Identify preferred film categories
-- Purpose: Analyze category preferences of top customers.
-- ------------------------------------------------------------

SELECT
    cat.name AS category_name,
    COUNT(*) AS total_rentals
FROM
(
    SELECT
        customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 10
) top_customers
JOIN rental r
    ON top_customers.customer_id = r.customer_id
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category cat
    ON fc.category_id = cat.category_id
GROUP BY
    cat.name
ORDER BY
    total_rentals DESC;