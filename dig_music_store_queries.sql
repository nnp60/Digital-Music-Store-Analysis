-- Questions & Queries 

-- Q1. Who are the 5 most popular artists? 
--     We can define the most popular artist as the artist with the most quantity of tracks bought. 

SELECT ar.name AS artist_name, COUNT(il.quantity) AS total_tracks_bought 
FROM artist ar
	INNER JOIN album al
		ON ar.artist_id = al.artist_id
	INNER JOIN track t
		ON al.album_id = t.album_id 
	INNER JOIN invoice_line il 
		ON t.track_id = il.track_id
GROUP BY ar.name
ORDER BY total_tracks_bought DESC
LIMIT 5; 	

-- Q2. What are the 10 most popular songs and their genres? 
--     We can define the most popular songs as the tracks that were bought the most. 

SELECT t.name AS track_name, COUNT(il.quantity) AS total_tracks_bought, g.name AS genre_name
FROM invoice_line il
	INNER JOIN track t
		ON il.track_id = t.track_id
	INNER JOIN genre g
		ON t.genre_id = g.genre_id 
GROUP BY t.name, g.name
ORDER BY total_tracks_bought DESC
LIMIT 10;

-- Q3. What are the average prices of different types of music? 

SELECT g.name AS genre_name, ROUND(AVG(il.unit_price):: numeric, 6) AS avg_price
FROM invoice_line il
	INNER JOIN track t
		ON il.track_id = t.track_id
	INNER JOIN genre g
		ON t.genre_id = g.genre_id 
GROUP BY g.name
ORDER BY avg_price DESC; 

-- Q4. Which countries made the most money from music purchases? 

SELECT billing_country, ROUND(SUM(total):: numeric, 2) AS total_rev
FROM invoice
GROUP BY billing_country
ORDER BY total_rev DESC
LIMIT 5;

-- Q5. Which genres have the shortest and longest tracks? 

SELECT g.name AS genre_name, ROUND(AVG(t.milliseconds):: numeric, 2) AS length_in_millisecs
FROM genre g 
	INNER JOIN track t
		ON g.genre_id = t.genre_id
GROUP BY g.name
ORDER BY length_in_millisecs ASC;

-- Q6. Who is the senior most employee based on job title?

SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1; 

-- Q7. Which countries have the most invoices?

SELECT billing_country, COUNT(*) AS total_quantity
FROM invoice 
GROUP BY billing_country
ORDER BY total_quantity DESC
LIMIT 5; 

-- Q8. What are top 3 values of total invoice?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3; 

-- Q9. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--     Write a query that returns one city that has the highest sum of invoice totals. 
--     Return both the city name & sum of all invoice totals.

SELECT billing_city, SUM(total) AS total_money
FROM invoice
GROUP BY billing_city
ORDER BY total_money DESC
LIMIT 1; 

-- Q10. Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--      Write a query that returns the person who has spent the most money.

SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_money
FROM invoice i 
	INNER JOIN customer c
		ON i.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_money DESC
LIMIT 1; 

-- Q11. Write a query to return the email, first name, last name, & genre of all Rock music listeners. 
--      Return your list ordered alphabetically by email starting with A

SELECT c.email, c.first_name, c.last_name, g.name
FROM customer c
	INNER JOIN invoice i
		ON c.customer_id = i.customer_id
	INNER JOIN invoice_line il
		ON i.invoice_id = il.invoice_id
	INNER JOIN track t
		ON il.track_id = t.track_id
	INNER JOIN genre g
		ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY c.email, c.first_name, c.last_name, g.name
ORDER BY c.email ASC;

-- Q12. Let's invite the artists who have written the most rock music in our dataset. 
--      Write a query that returns the artist name and total track count of the top 10 rock bands.

SELECT ar.name, COUNT(t.track_id) AS total_songs
FROM artist ar
	INNER JOIN album al
		ON ar.artist_id = al.artist_id
	INNER JOIN track t
		ON al.album_id = t.album_id
	INNER JOIN genre g
		ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY ar.name
ORDER BY total_songs DESC
LIMIT 10; 

-- Q13. Return all the track names that have a song length longer than the average song length. 
--      Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

SELECT name AS song_name, milliseconds 
FROM track 
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER by milliseconds DESC; 

-- Q14. Find the amount is spent by each customer on artists. 
--      Write a query to return the customer name, artist name, and total spent.

SELECT c.first_name || ' ' || c.last_name AS customer_name, ar.name, 
	ROUND(SUM(il.unit_price*il.quantity):: numeric, 2) as total_spent
FROM customer c 
	INNER JOIN invoice i 
		ON c.customer_id = i.customer_id
	INNER JOIN invoice_line il
		ON i.invoice_id = il.invoice_id
	INNER JOIN track t
		ON il.track_id = t.track_id
	INNER JOIN album al
		ON t.album_id = al.album_id
	INNER JOIN artist ar
		ON al.artist_id = ar.artist_id
GROUP BY customer_name, ar.name
ORDER BY total_spent DESC;

-- Q15. We want to find out the most popular music Genre for each country. 
--      We determine the most popular genre as the genre with the highest amount of purchases. 
--      Write a query that returns each country along with the top Genre. 
--      For countries where the maximum number of purchases is shared return all Genres.

WITH popular_genres AS (
	SELECT c.country, g.name AS genre_name, COUNT(il.quantity) AS purchases, 
		DENSE_RANK() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS rank
	FROM customer c
		INNER JOIN invoice i
			ON c.customer_id = i.customer_id
		INNER JOIN invoice_line il
			ON i.invoice_id = il.invoice_id
		INNER JOIN track t
			ON il.track_id = t.track_id
		INNER JOIN genre g
			ON t.genre_id = g.genre_id
	GROUP BY c.country, genre_name
	ORDER BY purchases DESC
)

SELECT *
FROM popular_genres
WHERE rank = 1; 

-- Q16. Write a query that determines the customer that has spent the most on music for each country. 
--      Write a query that returns the country along with the top customer and how much they spent. 
--      For countries where the top amount spent is shared, provide all customers who spent this amount.

WITH customer_spend AS (
	SELECT i.billing_country AS country, c.first_name || ' ' || c.last_name AS customer_name, ROUND(SUM(i.total):: numeric, 2)
		AS total_spent, DENSE_RANK() OVER(PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC) AS rank
	FROM customer c
		INNER JOIN invoice i
			ON c.customer_id = i.customer_id
	GROUP BY i.billing_country, customer_name
	ORDER BY country ASC, total_spent DESC
)

SELECT *
FROM customer_spend
WHERE rank = 1; 
