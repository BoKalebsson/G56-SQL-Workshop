/* 
SQL Join query exercise

World database layout:
To use this database from a default MySQL install, type: use world;

Table: City
Columns: Id, Name, CountryCode, District, Population

Table: Country
Columns: Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, Capital

Table: CountryLanguage
Columns: CountryCode, Language, IsOfficial, Percentage
*/

-- 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT * FROM city
WHERE Name LIKE 'Ping%'
ORDER BY Population ASC;


-- 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT * FROM city
WHERE Name LIKE 'ran%'
ORDER BY Population DESC;


-- 3: Count all cities
SELECT COUNT(*) AS Number_of_cities FROM city;


-- 4: Get the average population of all cities
SELECT AVG(Population) AS Average_Population FROM city;


-- 5: Get the biggest population found in any of the cities
SELECT MAX(Population) FROM city;


-- 6: Get the smallest population found in any of the cities
SELECT MIN(Population) FROM city;


-- 7: Sum the population of all cities with a population below 10000
SELECT SUM(Population) FROM city
WHERE Population < 10000;


-- 8: Count the cities with the country codes MOZ and VNM
SELECT COUNT(*) AS Cities FROM  city
WHERE CountryCode IN ('MOZ', 'VNM');


-- 9: Get individual count of cities for the country codes MOZ and VNM
Select CountryCode, COUNT(*) AS Cities FROM city
WHERE CountryCode IN ('MOZ','VNM')
GROUP BY CountryCode;


-- 10: Get average population of cities in MOZ and VNM
SELECT CountryCode, AVG(Population) FROM city
WHERE CountryCode IN ('MOZ','VNM')
GROUP BY CountryCode;



-- 11: Get the country codes with more than 200 cities
SELECT CountryCode, COUNT(*) AS city_count FROM city
GROUP BY CountryCode
HAVING COUNT(CountryCode) > 200;


-- 12: Get the country codes with more than 200 cities ordered by city count
SELECT CountryCode, COUNT(*) AS city_count FROM city
GROUP BY CountryCode
HAVING COUNT(CountryCode) > 200
ORDER BY city_count DESC;


-- 13: What language(s) is spoken in the city with a population between 400 and 500?
SELECT cl.Language 
FROM city AS c
JOIN countrylanguage AS cl
	ON c.CountryCode = cl.CountryCode
WHERE c.Population BETWEEN 400 AND 500;


-- 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
SELECT c.Name AS city_name, cl.Language 
FROM city AS c
JOIN countrylanguage AS cl
	ON c.CountryCode = cl.CountryCode
WHERE c.Population BETWEEN 500 AND 600;


-- 15: What names of the cities are in the same country as the city with a population of 122199 (including that city itself)
SELECT c2.Name 
FROM city AS c1
JOIN city AS c2
	ON c1.CountryCode = c2.CountryCode
WHERE c1.Population = 122199;



-- 16: What names of the cities are in the same country as the city with a population of 122199 (excluding that city itself)
SELECT c2.Name 
FROM city AS c1
JOIN city AS c2
	ON c1.CountryCode = c2.CountryCode
WHERE c1.Population = 122199 AND c1.ID != c2.ID;


-- 17: What are the city names in the country where Luanda is the capital?
SELECT city.Name, city.CountryCode 
FROM city
JOIN country
	ON city.CountryCode = country.Code
WHERE country.Capital IN (SELECT ID FROM city WHERE Name = 'Luanda');


-- 18: What are the names of the capital cities in countries in the same region as the city named Yaren
SELECT c.Name AS CapitalCity, c.CountryCode
FROM city c
WHERE c.ID IN (
	SELECT co.Capital
    FROM country co
    WHERE co.Region = (
		SELECT country.Region
        FROM country
        JOIN city ON city.CountryCode = country.Code
        WHERE city.Name = 'Yaren'
	)
);



-- 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT DISTINCT Language
FROM countrylanguage
WHERE CountryCode IN (
	SELECT Code
	FROM country
	WHERE Region = (
		SELECT Region
		FROM country
		JOIN city
			ON city.CountryCode = country.Code
		WHERE city.Name = 'Riga'
	)
);



-- 20: Get the name of the most populous city
SELECT Name, Population FROM city
ORDER BY Population DESC
LIMIT 1;

SELECT Name, Population FROM city
WHERE Population = (SELECT MAX(Population) FROM city);


