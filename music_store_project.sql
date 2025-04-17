CREATE DATABASE music_store;
USE music_store;

-- import the files from folder to the sql server by python files

-- Beginner
-- 1 Who is the senior most employee based on job title

SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;

-- 2 Which country has the most invoices

SELECT billing_country,count(invoice_id) AS number_of_invoices
FROM invoice
GROUP BY invoice.billing_country
ORDER BY number_of_invoices DESC
LIMIT 1;

-- 3 What are the top 3 values of total invoice

SELECT invoice.total AS total_invoice FROM invoice
ORDER BY invoice.total DESC
LIMIT 3;

-- 4 Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that 
--   has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

SELECT invoice.billing_city AS city, ROUND(SUM(total),2) AS invoice_total
FROM invoice
GROUP BY city
ORDER BY invoice_total DESC
LIMIT 1;

-- 5 Who is the best customer? The customer who has spent the most money will be declared the best customer.
--   Write a query that returns the person who has spent the most money

SELECT * FROM customer;
SELECT customer.customer_id, customer.first_name, customer.last_name, ROUND(SUM(invoice.total),2) AS total_invoice
FROM customer JOIN invoice
ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_invoice DESC
LIMIT 1;

-- Intermediate
-- 1 Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
--   Return your list ordered alphabetically by email starting with A

# Method-1
SELECT DISTINCT customer.customer_id, customer.first_name, customer.last_name, customer.email
FROM customer JOIN invoice
ON customer.customer_id = invoice.customer_id
JOIN invoice_line
ON invoice.invoice_id = invoice_line.invoice_id
JOIN track
ON invoice_line.track_id = track.track_id
JOIN genre
ON track.genre_id = genre.genre_id
WHERE genre.genre_id = 1
ORDER BY customer.email ASC;

# Method-2
SELECT DISTINCT customer.customer_id, customer.first_name, customer.last_name, customer.email
FROM customer JOIN invoice
ON customer.customer_id = invoice.customer_id
JOIN invoice_line
ON invoice.invoice_id = invoice_line.invoice_id
JOIN track
ON invoice_line.track_id = track.track_id
JOIN genre
ON track.genre_id = genre.genre_id
WHERE genre.name LIKE "ROCK"  
ORDER BY customer.email ASC;
      
-- 2 Let's invite the artists who have written the most rock music in our dataset.
--   Write a query that returns the Artist name and total track count of the top 10 rock bands

# Method-1
SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track JOIN album
ON track.album_id = album.album_id
JOIN artist
ON album.artist_id = artist.artist_id
JOIN genre
ON genre.genre_id = track.genre_id
WHERE genre.name LIKE "ROCK"
GROUP BY artist.name, artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

# Method-2
SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track JOIN album
ON album.album_id = track.album_id
JOIN artist
ON artist.artist_id = album.artist_id
JOIN genre
ON genre.genre_id = track.genre_id
WHERE genre.genre_id = 1
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC
LIMIT 10;

-- 3 Return all the track names that have a song length longer than the average song length. 
--   Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first 

SELECT track.name, track.milliseconds
FROM track
WHERE track.milliseconds > (SELECT avg(track.milliseconds) FROM track) 
ORDER BY track.milliseconds DESC;

-- ADVANCE
-- 1 Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent

WITH best_selling_artist AS( 
	SELECT 
	artist.artist_id AS artist_id, artist.name AS artist_name, 
    SUM(invoice_line.unit_price * invoice_line.quantity) AS total_spent
	FROM invoice_line JOIN track 
    ON invoice_line.track_id = track.track_id
	JOIN album 
    ON track.album_id = album.album_id
	JOIN artist 
    ON album.artist_id = artist.artist_id
	GROUP BY artist_id, artist_name
	ORDER BY total_spent DESC
    LIMIT 1)

SELECT CONCAT(c.first_name, " ", c.last_name) AS c_name , bsa.artist_name, SUM(il.unit_price * il.quantity) AS total_spent
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY c_name, bsa.artist_name
ORDER BY total_spent;
 

-- 2 We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. 
--   Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres

WITH 
GenreSales AS 
	(SELECT customer.country, genre.name AS genre_name, SUM(invoice_line.quantity) AS total_purchases
    FROM invoice
    JOIN customer 
    ON invoice.customer_id = customer.customer_id
    JOIN invoice_line 
    ON invoice.invoice_id = invoice_line.invoice_id
    JOIN track 
    ON invoice_line.track_id = track.track_id
    JOIN genre 
    ON track.genre_id = genre.genre_id
    GROUP BY customer.country, genre_name
),
RankedGenres AS 
	(SELECT country, genre_name, total_purchases, RANK() OVER (PARTITION BY country ORDER BY total_purchases DESC) AS rnk
    FROM GenreSales
)
SELECT country, genre_name, total_purchases
FROM RankedGenres
WHERE rnk = 1
ORDER BY country;

-- 3 Write a query that determines the customer that has spent the most on music for each country. 
--   Write a query that returns the country along with the top customer and how 
--   much they spent. For countries where the top amount spent is shared, provide all 
--   customers who spent this amount

WITH 
CustomerSpending AS 
	(SELECT 
	customer.country, customer.customer_id,
	CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
	SUM(invoice.total) AS total_spent
    FROM customer JOIN invoice 
    ON customer.customer_id = invoice.customer_id
    GROUP BY customer.country, customer.customer_id, customer_name
),
RankedCustomers AS 
	(SELECT country, customer_name, total_spent,
	RANK() OVER (PARTITION BY country ORDER BY total_spent DESC) AS rnk
    FROM CustomerSpending
)
SELECT country, customer_name, total_spent
FROM RankedCustomers
WHERE rnk = 1
ORDER BY country;

