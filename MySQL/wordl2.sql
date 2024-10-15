-- 1.  How many countries in each continent, have a life expectancy greater than 70?
SELECT 
    cy.Continent, 
    COUNT(cy.Name) AS "Total Countries", 
    (SELECT cy2.LifeExpectancy 
        FROM world.country cy2 
        WHERE cy2.Continent = cy.Continent AND cy2.LifeExpectancy > 70 
        LIMIT 1) AS LifeExpectancy 
    FROM world.country cy
        WHERE cy.LifeExpectancy > 70.0
        GROUP BY cy.Continent
;

-- 2. How many countries in each continent have a life expectancy between 60 and 70?.
SELECT
    cy.Continent,
    COUNT(cy.Name) AS "Total Countries",
    (SELECT cy2.LifeExpectancy
        FROM world.country cy2
        WHERE cy2.Continent = cy.Continent AND cy2.LifeExpectancy BETWEEN 60 AND 70
        LIMIT 1) AS LifeExpectancy
    FROM world.country cy
        WHERE cy.LifeExpectancy BETWEEN 60.0 AND 70.0
        GROUP BY cy.Continent
;

-- 3. How many countries have life expectancy greater than 75?
SELECT 
    cy.Name AS "Country",
    cy.LifeExpectancy
    FROM world.country cy
        WHERE cy.LifeExpectancy > 75.0
        GROUP BY cy.Name, cy.LifeExpectancy
;

-- 4. How many countries have life expectancy less than 40?
SELECT 
    cy.Name AS "Country",
    cy.LifeExpectancy
    FROM world.country cy
        WHERE cy.LifeExpectancy < 40.0
        GROUP BY cy.Name, cy.LifeExpectancy
;

-- 5. How many people live in the top 10 countries with the most population?
SELECT
    cy.Name AS "Country",
    cy.Population AS "Populations"
    FROM world.country cy
        GROUP BY cy.Name, cy.Population
        ORDER BY cy.Population DESC
        LIMIT 10
;

-- 6. According to the world database, how many people are there in the world?
SELECT
    SUM(cy.Population) AS "Total Population"
    FROM world.country cy
;

-- 7. Show results for continents where it shows the continent name and the total population. Only show results where the total_population for the continent is more than 500,00,000. If. the continent doesn't have 500,000,000 people, do NOT show the result.
SELECT
    cy.Continent,
    SUM(cy.Population) AS "Total Population"
    FROM world.country cy
        GROUP BY cy.Continent
        HAVING SUM(cy.Population) > 500000000
;

-- 8. Show results of all continents that has average life expectancy for the continent to be less than 71. Show each of these continent name, how many countries there are in each of the continent, total population for the continent, as well as the life expectancy of this continent. For example, as Europe and North America both have continent life expectancy greater than 71, these continents shouldn't show up in your sql results.
SELECT 
    cy.Continent,
    COUNT(cy.Name) AS "Total Countries",
    SUM(cy.Population) AS "Total Population",
    AVG(cy.LifeExpectancy) AS "Average LifeExpectancy"
        FROM world.country cy
            GROUP BY cy.Continent
            HAVING AVG(cy.LifeExpectancy) < 71.0
;

-- Now that you've used the group by a bit, let's now have you use this together with other records that were joined from multiple tables. Now, write a SQL query to obtain answers to the following questions:

-- 1. How many cities are there for each of the country? Show the total city count for each country where you display the full country name.
SELECT 
    cy.Name AS "Country",
    COUNT(c.Name) AS "Number of Cities"
    FROM world.country cy
        LEFT JOIN world.city c ON 
            cy.Code = c.CountryCode 
        GROUP BY cy.Name
;

-- 2. For each language, find out how many countries speak each language.
SELECT 
    cy.Name AS "Country",
    cl.Language,
    lc.number_of_countries
FROM 
    world.countrylanguage cl
RIGHT JOIN 
    world.country cy ON cy.Code = cl.CountryCode
JOIN (
    SELECT 
        cl.Language,
        COUNT(DISTINCT cl.CountryCode) AS number_of_countries
    FROM 
        world.countrylanguage cl
    GROUP BY 
        cl.Language
) lc ON cl.Language = lc.Language
;

-- 3. For each language, find out how many countries use that language as the official language.
SELECT
    cl.Language,
    COUNT(cy.Name) AS "Total Countries",
    cl.IsOfficial
        FROM world.countrylanguage cl
            JOIN world.country cy ON 
                cy.Code = cl.CountryCode
			WHERE cl.IsOfficial = 'T'
			GROUP BY cl.Language, cl.IsOfficial
;

-- 4. For each continent, find out how many cities there are (according to this database) and the average population of the cities for each continent. For example, for continent A, have it state the number of cities for that continent, and the average city population for that continent.
SELECT 
    cy.Continent,
    COUNT(c.Name) AS "Total Cities",
    AVG(c.Population) AS "Average Cities Population"
        FROM world.city c
            JOIN world.country cy ON 
                cy.code = c.CountryCode
            GROUP BY cy.Continent
;

-- 5. . (Advanced) Find out how many people in the world speak each language. Make sure the total sum of. this number is comparable to the total population in the world.
SELECT 
    cl.Language,
    SUM(cy.Population / lang_count.language_count) AS "Total Speakers"
FROM 
    world.countrylanguage cl
JOIN 
    world.country cy ON cy.Code = cl.CountryCode
JOIN (
    SELECT 
        CountryCode,
        COUNT(Language) AS language_count
    FROM 
        world.countrylanguage
    GROUP BY 
        CountryCode
) lang_count ON lang_count.CountryCode = cy.Code
GROUP BY 
    cl.Language
;
