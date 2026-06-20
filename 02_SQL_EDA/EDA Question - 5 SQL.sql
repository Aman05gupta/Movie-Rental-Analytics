-- ============================================================
-- EDA Question 5
-- Are certain language films more popular among specific customer segments?
-- ============================================================

-- --------------------------------------------------------------------------------------------------------------------
-- Step 1: Classify customers into segments based on rental count
-- Purpose: Categorize customers into Low Activity, Regular Customer, and Loyal Customer based on their rental frequency.
-- ---------------------------------------------------------------------------------------------------------------------

SELECT customer_id, COUNT(rental_id) AS total_rentals,
    CASE
        WHEN COUNT(rental_id) BETWEEN 12 AND 20 THEN 'Low Activity'
        WHEN COUNT(rental_id) BETWEEN 21 AND 30 THEN 'Regular Customer'
        ELSE 'Loyal Customer'
    END AS customer_segment
FROM rental
GROUP BY customer_id;


-- --------------------------------------------------------------------------------
-- Step 2: Analyze film language popularity by customer segment
-- Purpose: Analyze which language films are rented by different customer segments.
-- ----------------------------------------------------------------------------------

SELECT customer_segment, l.name AS language_name, COUNT(*) AS total_rentals
FROM (SELECT customer_id,
		CASE
            WHEN COUNT(rental_id) BETWEEN 12 AND 20 THEN 'Low Activity'
            WHEN COUNT(rental_id) BETWEEN 21 AND 30 THEN 'Regular Customer'
            ELSE 'Loyal Customer'
        END AS customer_segment
    FROM rental
    GROUP BY customer_id) cs

JOIN rental r
    ON cs.customer_id = r.customer_id
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
JOIN language l
    ON f.language_id = l.language_id
GROUP BY customer_segment, l.name
ORDER BY customer_segment, total_rentals DESC;
    
-- -------------------------------------------------------------------------------------------------    
-- Step 3: Calculate Percentage Distribution (Optional – Bonus Analysis)
-- Purpose: Determine the percentage share of rentals for each language within every customer segment.    
-- ---------------------------------------------------------------------------------------------------

SELECT customer_segment, l.name AS language_name, COUNT(*) AS total_rentals,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY customer_segment),
        2
    ) AS percentage_share
FROM (SELECT customer_id,
        CASE
            WHEN COUNT(rental_id) BETWEEN 12 AND 20 THEN 'Low Activity'
            WHEN COUNT(rental_id) BETWEEN 21 AND 30 THEN 'Regular Customer'
            ELSE 'Loyal Customer'
        END AS customer_segment
    FROM rental
    GROUP BY customer_id ) cs
JOIN rental r
    ON cs.customer_id = r.customer_id
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
JOIN language l
    ON f.language_id = l.language_id
GROUP BY customer_segment, l.name
ORDER BY customer_segment, percentage_share DESC;

    
    
    
    
    
    
    

    
    
    