--------------------------------------------------------------------
-- Tabell: MOON MISSIONS
-- UPPGIFT 1
--drop table SuccessfulMissions
--drop table NewUsers
SELECT
	Spacecraft,
	[Launch date],
	[Carrier rocket],
	Operator,
	[Mission type]
INTO
	SuccessfulMissions
FROM 
	MoonMissions
WHERE
	[Outcome] = 'Successful';


--------------------------------------------------------------------
-- UPPGIFT 2



UPDATE SuccessfulMissions
SET Operator = TRIM(Operator);



--------------------------------------------------------------------
-- UPPGIFT 3


SELECT
	Operator,
	[Mission type],
	COUNT(*) AS [Mission Count]
FROM
	Successfulmissions
GROUP BY 
	Operator,
	[Mission type]
HAVING
	COUNT(*) > 1
ORDER BY 
	Operator,
	[Mission type];


--------------------------------------------------------------------
-- UPPGIFT 4   VG



--------------------------------------------------------------------
-- TABELL: USERS
-- UPPGIFT 5


SELECT
    *,
    Firstname + ' ' + Lastname AS Name,

    CASE
        WHEN CAST(SUBSTRING(REPLACE(ID, '-', ''),
             LEN(REPLACE(ID, '-', '')) - 1,1) AS INT) % 2 = 0
        THEN 'Female'
        ELSE 'Male'
    END AS Gender

INTO NewUsers
FROM Users;



--------------------------------------------------------------------
-- UPPGIFT 6


SELECT 
	Username,
	COUNT(*) AS [Duplicate Count]
FROM 
	NewUsers
GROUP BY 
	UserName
HAVING 
	COUNT(*) >1;



--------------------------------------------------------------------
-- UPPGIFT 7


UPDATE NewUsers
SET UserName = 'sigpe1'
WHERE ID = '580802-4175';

UPDATE NewUsers
SET UserName = 'sigpe2'
WHERE ID = '630303-4894';

UPDATE NewUsers
SET UserName = 'felbe2'
WHERE ID = '890701-1480';



--------------------------------------------------------------------
-- UPPGIFT 8


DELETE FROM 
	NewUsers
WHERE
	Gender = 'Female'
	AND LEFT (ID,2) < '70';



--------------------------------------------------------------------
-- UPPGIFT 9

 INSERT INTO NewUsers
 (
	ID,
	UserName,
	Password,
	FirstName,
	LastName,
	Email,
	Phone,
	Name,
	Gender
)
 VALUES
(	'921026-1518',
	'Marlag',
	'Vinglas',
	'Martin',
	'Lagerin',
	'Martin.Lagerin@hotmail.se',
	'070-6522725',
	'Martin Lagerin',
	'Male'
);



--------------------------------------------------------------------
-- UPPGIFT 10 (VG)


--------------------------------------------------------------------
-- TABELL: COMPANY(JOINS) 
-- UPPGIFT 11


-- SELECT * FROM Company.products  - ID + productname
-- SELECT * FROM Company.suppliers	- Company name
-- SELECT * FROM Company.Categories - Category name

SELECT
	p.ID,
	p.ProductName as Product,
	s.CompanyName as Supplier,
	c.CategoryName as Category
FROM 
	Company.products as p
	join Company.suppliers as s on p.supplierID = s.ID
	join Company.Categories as c on p.CategoryID = c.ID;



--------------------------------------------------------------------
-- UPPGIFT 12


-- SELECT * FROM Company.employees
-- SELECT * FROM Company.regions
-- SELECT * FROM Company.territories
-- SELECT * FROM Company.employee_territory

SELECT
	r.RegionDescription,
	COUNT(e.id) as [Number of Employees]
FROM
	Company.regions as r
	JOIN Company.territories AS t on r.Id = t.RegionID
	JOIN Company.employee_territory as et on t.Id = et.TerritoryID
	JOIN Company.employees as e on et.EmployeeID = e.Id
GROUP BY 
	r.RegionDescription;



--------------------------------------------------------------------
-- UPPGIFT 13 (VG)

--------------------------------------------------------------------