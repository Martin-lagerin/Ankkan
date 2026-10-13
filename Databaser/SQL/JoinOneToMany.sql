USE everyloop

DROP TABLE countriess

CREATE TABLE countriess
(
	id INT PRIMARY KEY,
	name NVARCHAR(20)
)

INSERT INTO countriess VALUES(1, 'Sweden')
INSERT INTO countriess VALUES(2, 'Denmark')
INSERT INTO countriess VALUES(3, 'Norway')
INSERT INTO countriess VALUES(4, 'Finland')

INSERT INTO countriess VALUES(4, 'Germany')   -- kommer ej att gå, eftersom att primary key behöver vara unikt

SELECT * FROM countriess

DROP TABLE cities

CREATE TABLE cities
(
	id INT PRIMARY KEY,
	name NVARCHAR(20),
	countryid INT        -- foreign key som ska referea till id columnen i countries tabellen
)

INSERT INTO cities VALUES(1, 'Stockholm', 1)
INSERT INTO cities VALUES(2, 'Gothenburg', 1)
INSERT INTO cities VALUES(3, 'Malmö', 1)
INSERT INTO cities VALUES(4, 'Copenhagen', 2)
INSERT INTO cities VALUES(5, 'Oslo', 3)
INSERT INTO cities VALUES(6, 'Bergen', 3)
INSERT INTO cities VALUES(7, 'London', 5)

-- show everything we have so far

SELECT * FROM countriess
SELECT * FROM cities

-- JOIN (inner join by default)

SELECT
	*
FROM
	cities JOIN countriess ON cities.countryID = countriess.id   -- ni kan lika gärna skriva INNER JOIN (istället för bara JOIN) för att vara extra tydliga)


SELECT
	*
FROM
	countriess JOIN cities ON cities.countryid = countriess.id   -- ordningen på tabellerna i angivelsen spelar roll!


SELECT
--	*,           
	cities.name AS stad,
	countries.name AS land
FROM
	cities JOIN countriess ON cities.countryid = countriess.id


SELECT
	*,           
	ci.name AS stad,
	co.name AS land
FROM
	cities AS ci JOIN countries AS co ON ci.countryid = co.id     -- vi kan ge allias till våra tabeller, för att underlätta queryn
																  -- OBS! FROM sker innan SELECT


SELECT
	ci.name AS [City name],
	co.name AS [Country name],
	ci.name + ' ' + co.name AS [Combined]
FROM
	cities ci JOIN countriess co ON ci.countryid = co.id


SELECT
	A.name AS [City name],
	B.name AS [Country name],
	A.name + ' ' + B.name AS [Combined]
FROM
	cities A JOIN countriess B ON A.countryid = B.id


-- LEFT JOIN

SELECT * FROM countriess
SELECT * FROM cities

SELECT
	ci.name AS [City name],
	co.name AS [Country name],
	ci.name + ' ' + co.name AS [Combined]
FROM
	cities ci LEFT JOIN countriess co ON ci.countryid = co.id


SELECT
	ci.name AS [City name],
	co.name AS [Country name],
	ci.name + ' ' + co.name AS [Combined]
FROM
	countriess co LEFT JOIN cities ci ON ci.countryid = co.id


-- RIGHT JOIN


SELECT
	ci.name AS [City name],
	co.name AS [Country name],
	ci.name + ' ' + co.name AS [Combined]
FROM
	cities ci RIGHT JOIN countriess co ON ci.countryid = co.id


-- CROSS JOIN

SELECT
	a.name as [City name],
	b.name AS [Country name]
FROM
	cities a CROSS JOIN countriess b


-- När användar man cross join? Wijdan tvingade mig visa er ett exempel x)

CREATE TABLE frukter
(
	id INT PRIMARY KEY,
	name NVARCHAR(20),
)

CREATE TABLE dryck
(
	id INT PRIMARY KEY,
	name NVARCHAR(20),
)

CREATE TABLE måltid
(
	id INT PRIMARY KEY,
	name NVARCHAR(20),
)

INSERT INTO frukter VALUES(1, 'Äpple')
INSERT INTO frukter VALUES(2, 'Banan')
INSERT INTO frukter VALUES(3, 'Apelsin')

INSERT INTO dryck VALUES(1, 'Palestine Coke')
INSERT INTO dryck VALUES(2, 'Zingo Zero')
INSERT INTO dryck VALUES(3, 'Pucko')

INSERT INTO måltid VALUES(1, 'Lasagne')
INSERT INTO måltid VALUES(2, 'Hamburgare')
INSERT INTO måltid VALUES(3, 'Kycklingsallad')



SELECT * FROM frukter
SELECT * FROM dryck
SELECT * FROM måltid


SELECT 
	f.name,
	d.name
FROM
	frukter f CROSS JOIN dryck d


SELECT
	m.name,
	d.name,
	f.name
FROM
	måltid m CROSS JOIN dryck d CROSS JOIN frukter f


-- JOIN combined with GROUP BY

SELECT 
	co.name AS 'Country',
	COUNT(ci.name) AS 'Number of cities',
	ISNULL(STRING_AGG(ci.name, ', '), '-') AS 'List of Cities'
FROM 
	cities ci RIGHT JOIN countriess co ON ci.countryid = co.id
GROUP BY
	co.name




SELECT * FROM Products2

SELECT
	id,
	name,
	AVG(id) over (PARTITION by id) AS medel
FROM Products2



SELECT * FROM company.products
SELECT * FROM company.orders
SELECT * FROM company.order_details

SELECT p.id,o.EmployeeId as order_id
FROM Company.Products as p
LEFT JOIN company.orders as o on p.id = o.EmployeeId
WHERE order_id > 6

SELECT
	p.id as produktid,
	p.ProductName,
	o.Id as orderid
	FROM company.products as p
	JOIN company.order_details as od on p.id = od.ProductId
	join company.orders as o on od.OrderId = o.Id


SELECT ShipName,COUNT(*) AS id_count FROM company.orders GROUP BY ShipName


SELECT TOP (2) *
FROM company.products
order by UnitPrice DESC


SELECT * FROM company.employees
SELECT * FROM company.orders
SELECT * FROM company.categories
SELECT * FROM company.suppliers


SELECT e.*
FROM Company.employees as e
LEFT JOIN company.orders as o on e.id = o.EmployeeId
WHERE o.EmployeeId IS NULL 




SELECT * FROM company.products ORDER BY ProductName ASC

SELECT 
	avg(UnitPrice) as genomsnitt
FROM 
	company.products




SELECT 
	*
FROM 
	company.products
WHERE
	UnitPrice > ( 
			SELECT 
			avg(UnitPrice)
			FROM 
			company.products 
			) 






SELECT * FROM company.employees
SELECT * FROM company.categories
SELECT * FROM company.suppliers

SELECT * FROM company.products
SELECT * FROM company.orders
SELECT * FROM company.order_details


WITH Ordersumma as (
	SELECT 
	o.id as orderid,
	sum(od.UnitPrice * od.Quantity) as totalsumma
	FROM company.orders as o 
	JOIN Company.order_details od on o.id = od.OrderId
	GROUP BY o.id
)
SELECT
	*
FROM 
	Ordersumma



SELECT * FROM countriess
SELECT * FROM cities

SELECT
	*
FROM cities c
left JOin countriess co on c.id = co.id


SELECT
	*
FROM cities c
JOin countriess co on c.id = co.id





SELECT * FROM Colors

SELECT
	Name,
	Red,
	Green,
	Blue,
FROM 
	Colors
WHERE (
	SELECT 
		red,
		green,
		Blue,
		COUNT(*)
	FROM 
		Colors
GROUP BY 
	red,green,blue
HAVING 
	Count(*) > 1



SELECT
    Name,
    Red,
    Green,
    Blue
FROM
    Colors
WHERE
    (Red, Green, Blue) IN
(
    SELECT
        Red,
        Green,
        Blue
    FROM
        Colors
    GROUP BY
        Red,
        Green,
        Blue
    HAVING
        COUNT(*) > 1
);
	


SELECT
    c.Name,
    c.Red,
    c.Green,
    c.Blue
FROM
    Colors AS c

JOIN
(
    SELECT
        Red,
        Green,
        Blue
    FROM
        Colors
    GROUP BY
        Red,
        Green,
        Blue
    HAVING
        COUNT(*) > 1
) AS duplicates

ON c.Red = duplicates.Red
AND c.Green = duplicates.Green
AND c.Blue = duplicates.Blue;





SELECT * FROM company.products

WITH PRIS as
(
	SELECT
		*
	FROM 
		company.products
	WHERE
		UnitPrice > 100
)
SELECT * FROM PRIS

SELECT *
FROM company.products
WHERE UnitPrice > 100



SELECT
    ProductName,
    UnitPrice
FROM
    company.products
WHERE
    UnitPrice >
    (
        SELECT AVG(UnitPrice)
        FROM company.products
    );


WITH AveragePrice AS
(
    SELECT AVG(UnitPrice) AS AvgPrice
    FROM company.products
)

SELECT
    ProductName,
    UnitPrice
FROM
    company.products,
    AveragePrice
WHERE
    UnitPrice > AvgPrice;




WITH ProductsOver50 AS
(
    SELECT *
    FROM company.products
    WHERE UnitPrice > 50
),

ProductsOver100 AS
(
    SELECT *
    FROM ProductsOver50
    WHERE UnitPrice > 100
)

SELECT *
FROM ProductsOver100;


SELECT * FROM company.products

SELECT
	ProductName,
	Unitprice,
	categoryId,
	cast(avg(unitprice) over(partition by categoryid) as decimal(5,3)) as avg
FROM 
	company.products


SELECT TOP(1) *
FROM company.products
ORDER BY UnitPrice desc