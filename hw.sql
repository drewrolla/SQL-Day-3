-- 1. List all customers who live in Texas (use JOINs)
-- Kim Cruz, Jennifer Davis, Bryan Hardison, Ian Still, Richard Mccrary

SELECT first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';


-- 2. Get all payments above $6.99 with the Customer's Full Name
--
SELECT first_name, last_name
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;


-- 3. Show all customers names who have made payments over $175(use
-- subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
    ORDER BY SUM(amount) DESC
);


-- 4. List all customers that live in Nepal 
--(use the city table)
-- Kevin Schuler
SELECT first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON country.country_id = city.country_id
WHERE country = 'Nepal';


-- 5. Which staff member had the most
-- transactions?
-- Jon Stephens
SELECT first_name, last_name, COUNT(payment.staff_id)
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(payment.staff_id) DESC;


-- 6. How many movies of each rating are there?
-- PG13 - 223, NC-17 - 209, R - 195, PG - 194, G - 179
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC;


-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount IN (
    SELECT amount
    FROM payment
    WHERE amount > 6.99
    GROUP BY amount
)
-- above code shows every purchase over 6.99 made by someone

GROUP BY first_name, last_name
HAVING COUNT(amount) = 1;


-- 8. How many free rentals did our stores give away?
SELECT * FROM payment
WHERE amount = 0;
-- In case it's not that simple, here's another answer
SELECT amount
FROM payment
INNER JOIN rental
ON payment.rental_id = rental.rental_id
WHERE amount = 0;


