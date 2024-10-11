-- 1.  Get all the list of countries that are in the continent of Europe:
SELECT * FROM world.country 
	WHERE Continent = 'Europe';
    
-- 2. Get all the list of countries that are in the continent of North America and Africa:
SELECT * FROM world.country 
	WHERE Continent IN ('North America', 'Africa');
    
-- 3. Get all the list of cities that are part of a country with population greater than 100 millions.
SELECT cy.Code as "Country Code",
	cy.Name AS "Country Name",
    cy.Continent,
    cy.Population AS "Country Population",
    c.Name AS "City"
    FROM world.city c
		RIGHT JOIN world.country cy ON 
			c.CountryCode = cy.Code
	WHERE cy.Population > 100000000;
    
-- 4.  Get all the list of countries (display the full country name) who speak 'Spanish' as their language.
SELECT cy.Name AS "Country", cl.Language FROM world.country cy
	JOIN world.countrylanguage cl ON 
		cl.CountryCode = cy.Code
	WHERE cl.Language = 'Spanish';
    
-- 5. Get all the list of countries (display the full country name) who speak 'Spanish' as their official language.
SELECT cy.Name AS "Country", cl.Language, cl.IsOfficial FROM world.country cy
	JOIN world.countrylanguage cl ON 
		cl.CountryCode = cy.Code
	WHERE cl.Language = 'Spanish'
    AND cl.IsOfficial = 'T';
    
-- 6.  Get all the list of countries (display the full country name) who speak either 'Spanish' or 'English' as their official language
SELECT cy.Name AS "Country", cl.Language FROM world.country cy
	JOIN world.countrylanguage cl ON 
		cl.CountryCode = cy.Code 
	WHERE cl.Language IN ('Spanish', 'English')
    AND cl.IsOfficial = 'T';
    
-- 7.  . Get all the list of countries (display the full country name) where 'Arabic' is spoken by more than 30% of the
-- population but where it's not the country's official language.
SELECT cy.Name AS "Country", cl.Language, cl.Percentage, cl.IsOfficial FROM world.country cy
	JOIN world.countrylanguage cl ON 
		cl.CountryCode = cy.Code
	WHERE cl.Percentage > 30.0
		AND cl.Language = 'Arabic'
        AND cl.IsOfficial = 'F';
        
-- 8.  Get all the list of countries (display the full country name) where 'French' is the official language but where less
-- than 50% of the population in that country actually speaks that language.
SELECT cy.Name AS "Country", cl.Language, cl.IsOfficial, cl.Percentage  FROM world.country cy
	JOIN world.countrylanguage cl ON 
		cl.CountryCode = cy.Code
	WHERE cl.Language = 'French'
		AND cl.IsOfficial = 'T'
        AND cl.Percentage < 50.0;
        
-- 9. Get all the list of countries (display the full country name and the full language name) and their official
-- language. Order the result so that those with the same official language are shown together. 
SELECT cy.Name AS "Country", cl.Language, cl.IsOfficial FROM world.country cy
	JOIN world.countrylanguage cl ON 
		cl.CountryCode = cy.Code
	WHERE cl.IsOfficial = 'T'
    ORDER BY cl.Language;
    
-- 10. . Get the top 100 cities with the most population. Display the city's full country name also as well as their official language. 
SELECT cy.Name AS "Country", c.Name AS "City", cl.Language, cl.IsOfficial FROM world.country cy
	JOIN world.city c ON 
		c.CountryCode = cy.Code
	JOIN world.countrylanguage cl ON
		cl.CountryCode = cy.Code
	WHERE cl.IsOfficial = 'T'
	ORDER BY c.Population DESC
    LIMIT 100;
    
-- 11. Get the top 100 cities with the most population where the life_expectancy for the country is less than 40.
SELECT cy.Name AS "Country", cy.LifeExpectancy, c.Name AS "City", c.Population FROM world.country cy
	JOIN world.city c ON 
		c.CountryCode = cy.Code
	WHERE cy.LifeExpectancy < 40.0
    ORDER BY c.Population DESC
    LIMIT 100;
    
-- 12. Get the top 100 countries who speak English and where life expectancy is highest. Show the country with the highest life expectancy first.
SELECT cy.Name as "Country", c.Name as "City", cy.LifeExpectancy FROM world.country cy
	JOIN world.city c ON 
		c.CountryCode = cy.Code
	JOIN world.countrylanguage cl ON 
		cl.CountryCode = cy.Code
	WHERE cl.Language = 'English'
    ORDER BY cy.LifeExpectancy DESC
    LIMIT 100;