USE sakila;

-- Challenge 1

-- 1) You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1) Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MAX(length) AS max_duration,
	   MIN(length) AS min_duration
FROM sakila.film;

-- 1.2) Express the average movie duration in hours and minutes. Don't use decimals.

SELECT FLOOR(AVG(length/60)) AS hours,
	ROUND(AVG(length%60), 0) AS minutes
FROM sakila.film;

-- 2) You need to gain insights related to rental dates:
-- 2.1) Calculate the number of days that the company has been operating.

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_difference
FROM sakila.rental;

-- 2.2) Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT DATE_FORMAT(CONVERT(rental_date, DATE), '%M') AS month,
CASE 
		WHEN WEEKDAY(rental_date) = 0 THEN 'Monday'
		WHEN WEEKDAY(rental_date) = 1 THEN 'Tuesday'
		WHEN WEEKDAY(rental_date) = 2 THEN 'Tuesday'
		WHEN WEEKDAY(rental_date) = 3 THEN 'Thursday'
		WHEN WEEKDAY(rental_date) = 4 THEN 'Friday'
        WHEN WEEKDAY(rental_date) = 5 THEN 'Saturday'
		ELSE WEEKDAY(rental_date) = 'Sunday'
END AS 'weekday'
FROM sakila.rental
LIMIT 20;

-- 3) You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and 
-- their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order. 

SELECT title, IFNULL(rental_duration, "Not Available") AS rental_duration
FROM sakila.film
ORDER BY rental_duration ASC;

-- Challenge 2

-- 1) Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1) The total number of films that have been released.

SELECT COUNT(release_year) AS 'number_of_films'
FROM sakila.film;

-- 1.2) The number of films for each rating.

SELECT rating, COUNT(title) AS 'number_of_films'
FROM sakila.film
GROUP BY rating;

-- 1.3) The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.alter

SELECT rating, COUNT(title) AS 'number_of_films'
FROM sakila.film
GROUP BY rating
ORDER BY COUNT(title) DESC;

-- 2) Using the film table, determine:
-- 2.1) The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, round(AVG(length),2) AS 'mean_film_duration'
FROM sakila.film
GROUP BY rating
ORDER BY AVG(length) DESC;

-- 2.2) Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, round(AVG(length),2) AS 'mean_film_duration'
FROM sakila.film
GROUP BY rating
HAVING AVG(length) >= (60*2)
ORDER BY AVG(length) DESC;