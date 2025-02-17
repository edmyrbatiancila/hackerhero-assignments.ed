-- 1. How many customers are there for each country? Have your result display the full country name and the number of customers for each country.

SELECT c.country as COUNTRY, COUNT(cust.customer_id) as "total_no_of_customer"
	FROM sakila.country c 
    JOIN sakila.city cy ON cy.country_id = c.country_id
    JOIN sakila.address a ON a.city_id = cy.city_id
    JOIN sakila.customer cust ON cust.address_id = a.address_id
    GROUP BY c.country
    ;
    

-- 2. How many customers are there for each city?  Have your result display the full city name, the full country name, as well as the number of customers for each city.

SELECT cy.city as City, c.country as Country, COUNT(cust.customer_id) as "total_no_of_customer"
	FROM sakila.country c 
    JOIN sakila.city cy ON cy.country_id = c.country_id
    JOIN sakila.address a ON a.city_id = cy.city_id
    JOIN sakila.customer cust ON cust.address_id = a.address_id
    GROUP BY c.country
    ;

-- Now, look at the payment table where it has information about the customer as well as how much the customer paid to rent the item. Based on this,

-- 1. Retrieve both the average rental amount, the total rental amount, as well as the total number of transactions for each month of each year.

SELECT concat(monthname(p.payment_date), '-', 
	year(p.payment_date)) AS month_and_year, 
    sum(p.amount) AS total_rental_amount, 
    COUNT(p.payment_id) AS total_transactions, 
    avg(p.amount) AS average_rental_amount
FROM sakila.payment p
	GROUP BY monthname(p.payment_date)
	ORDER BY p.payment_date
    ;

-- 2. Your manager comes and asks you to pull payment report based on the hour of the day. The managers wants to know which hour the company earns the most money/payment. Have your sql query generate the top 10 hours of the day with the most sales. Have the first row of your result be the hour with the most payments received.

SELECT time_format(p.payment_date, '%h %p') AS hour_of_the_day, sum(p.amount) AS total_payments_received FROM sakila.payment p
-- WHERE time_format(p.payment_date, '%h %p') = '03 PM'
GROUP BY hour_of_the_day
ORDER BY total_payments_received DESC
LIMIT 10
;