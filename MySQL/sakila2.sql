-- 1. Get all the list of customers.  
SELECT * FROM sakila.customer;

-- 2. Get all the list of customers, as well as their address.\
SELECT CONCAT(c.first_name, " " , c.last_name)  as "Customer Name", CONCAT(a.address, " ", a.district, " " , a.postal_code) AS "Address"  FROM sakila.customer c 
	JOIN sakila.address a ON
		c.address_id = a.address_id;
        
--  3. Get all the list of customers as well as their address and the city name.
SELECT CONCAT(cust.first_name, " ", cust.last_name) AS "Customer Name", CONCAT(a.address, " ", a.district, " " , a.postal_code) AS "Address", c.city FROM sakila.customer cust
	JOIN sakila.address a ON
		cust.address_id = a.address_id
	JOIN sakila.city c ON
		a.city_id = c.city_id;
        
-- 4. Get all the list of customers as well as their address, city name, and the country :
SELECT CONCAT(cust.first_name, " ", cust.last_name) AS "Customer Name", 
	CONCAT(a.address, " ", a.district, " " , a.postal_code) AS "Address", 
	c.city, 
    cy.country FROM sakila.customer cust
		JOIN sakila.address a ON
			cust.address_id = a.address_id
		JOIN sakila.city c ON
			a.city_id = c.city_id
		JOIN sakila.country cy ON
			cy.country_id = c.country_id;
            
-- 5. Get all the list of customers who live in Bolivia:
SELECT CONCAT(cust.first_name, " ", cust.last_name) AS "Customer Name", 
	CONCAT(a.address, " ", a.district, " " , a.postal_code) AS "Address", 
	c.city AS "City", 
    cy.country AS "Country" FROM sakila.customer cust
		JOIN sakila.address a ON
			cust.address_id = a.address_id
		JOIN sakila.city c ON
			a.city_id = c.city_id
		JOIN sakila.country cy ON
			cy.country_id = c.country_id
		WHERE cy.country = "Bolivia";
 
 -- 6. Get all the list of customers who live in Bolivia, Germany and Greece:
 SELECT CONCAT(cust.first_name, " ", cust.last_name) AS "Customer Name", 
	CONCAT(a.address, " ", a.district, " " , a.postal_code) AS "Address", 
	c.city AS "City", 
    cy.country AS "Country" FROM sakila.customer cust
		JOIN sakila.address a ON
			cust.address_id = a.address_id
		JOIN sakila.city c ON
			a.city_id = c.city_id
		JOIN sakila.country cy ON
			cy.country_id = c.country_id
		WHERE cy.country IN ("Bolivia", "Germany", "Greece");
        
-- 7.  Get all the list of customers who live in the city of Baku:
SELECT CONCAT(cust.first_name, " ", cust.last_name) AS "Customer Name", 
	CONCAT(a.address, " ", a.district, " " , a.postal_code) AS "Address", 
	c.city AS "City", 
    cy.country AS "Country" FROM sakila.customer cust
		JOIN sakila.address a ON
			cust.address_id = a.address_id
		JOIN sakila.city c ON
			a.city_id = c.city_id
		JOIN sakila.country cy ON
			cy.country_id = c.country_id
		WHERE c.city = "Baku";
        
-- 8.  Get all the list of customers who live in the city of Baku, Beira, and Bergamo:
SELECT CONCAT(cust.first_name, " ", cust.last_name) AS "Customer Name", 
	CONCAT(a.address, " ", a.district, " " , a.postal_code) AS "Address", 
	c.city AS "City", 
    cy.country AS "Country" FROM sakila.customer cust
		JOIN sakila.address a ON
			cust.address_id = a.address_id
		JOIN sakila.city c ON
			a.city_id = c.city_id
		JOIN sakila.country cy ON
			cy.country_id = c.country_id
		WHERE c.city IN ("Baku", "Beira", "Bergamo");
        
-- 9. Get all the list of customers who live in a country where the country name's length is
-- less than 5. Show the customer with the longest full name first. (Hint: Look into how you can concatenate a
-- string in SQL). 
SELECT CONCAT(cust.first_name, " ", cust.last_name) AS "Customer Name",
	cy.country AS "Country", char_length(cy.country) AS "Country Name Length"
    FROM sakila.customer cust
    JOIN sakila.address a ON
		cust.address_id = a.address_id
	JOIN sakila.city c ON
		a.city_id = c.city_id
	JOIN sakila.country cy ON
		cy.country_id = c.country_id
	WHERE char_length(cy.country) < 5
    ORDER BY char_length(concat(cust.first_name, " ", cust.last_name)) DESC;
    
-- 10.  Get all the list of customers who live in a city name whose length is more than 10. Order the result so that the
-- customers who live in the same country are shown together.
SELECT concat(cust.first_name, " ", cust.last_name) AS "Customer's Name",
	cy.country AS "Country",
    c.city AS "City",
    char_length(c.city) AS "City Name's Length"
    FROM sakila.customer cust
    JOIN sakila.address a ON
		cust.address_id = a.address_id
	JOIN sakila.city c ON
		a.city_id = c.city_id
	JOIN sakila.country cy ON
		cy.country_id = c.country_id
	WHERE char_length(c.city) > 10
    ORDER BY cy.country;
    
-- 11. Get all the list of customers who live in a city where the city name includes the word 'ba'. For example
-- Arratuba or Baiyin should show up in your result.
SELECT concat(cust.first_name, " ", cust.last_name) AS "Customer's Name",
	c.city AS "City"
    FROM sakila.customer cust
		JOIN sakila.address a ON
			a.address_id = cust.address_id
        JOIN sakila.city c ON 
			c.city_id = a.city_id
        WHERE c.city LIKE '%ba%' OR '%Ba%';
        
-- 12. Get all the list of customers where the city name includes a space. Order the result so that customers who live
-- in the longest city are shown first
SELECT concat(cust.first_name, " ", cust.last_name) AS "Customer's name",
	c.city AS "City",
    char_length(c.city) AS "City Name Length"
    FROM sakila.customer cust 
		JOIN sakila.address a ON
			a.address_id = cust.address_id
        JOIN sakila.city c ON 
			c.city_id = a.city_id
		WHERE c.city LIKE '% %'
        ORDER BY char_length(c.city) DESC;
        
-- 13. Get all the customers where the country name is longer than the city name.
SELECT concat(cust.first_name, " ", cust.last_name) AS "Customer's Name",
	c.city AS "City",
    cy.country AS "Country",
    char_length(c.city) AS "City Name Length",
    char_length(cy.country) AS "Country Name Length"
    FROM sakila.customer cust 
		JOIN sakila.address a ON
			a.address_id = cust.address_id
		JOIN sakila.city c ON
			c.city_id = a.city_id
		JOIN sakila.country cy ON 
			cy.country_id = c.country_id
		WHERE char_length(cy.country) > char_length(c.city);