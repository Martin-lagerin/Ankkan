

SELECT
	*				-- Komentar
FROM 
	dbo.Users 
WHERE
	FirstName = 'Johanna'



SELECT
	*
FROM
	dbo.GameOfThrones
WHERE
	Season = 1 AND [Directed by] = 'Brian Kirk'
	
	
SELECT
	*
FROM
	dbo.GameOfThrones
WHERE
	[Directed by] = 'Brian Kirk' OR [Directed by] = 'Tim Van Patten' OR [Directed by] = 'Alan Taylor'

SELECT 
	*
FROM
	dbo.GameOfThrones
WHERE
	[Directed by] IN ('Brian Kirk','Tim Van Patten','Alan Taylor')   -- Enklare för se viss akolumner i en specifik kolumn 


SELECT
	*
FROM
	dbo.GameOfThrones
WHERE
	Season IN (1,2,3,4,5,6)


SELECT
	*
FROM
	dbo.GameOfThrones
WHERE
	Season BETWEEN 2 AND 4


SELECT 
	*
FROM
	dbo.Airports
WHERE
	IATA BETWEEN 'AAf' AND 'AAJ'


SELECT
	*
FROM
	dbo.GameOfThrones
WHERE
	[Directed by] LIKE 'D%'   -- BÖrjar på D


SELECT
	*
FROM
	dbo.GameOfThrones
WHERE
	[Directed by] LIKE '%R'  -- Slutar på R



SELECT
	*
FROM
	dbo.Airports
WHERE
	IATA LIKE '[acf]_[q-z]'			-- Börjar på acf eller  på q-z



SELECT
	*
FROM
	dbo.Airports
WHERE
	IATA LIKE '[abc]%[a-p]'         -- Börjar på ABC och slutar på a-p


SELECT
	*
FROM
	dbo.GameOfThrones
WHERE
	[Directed by] LIKE '&al&'


SELECT
	*
FROM
	dbo.GameOfThrones
ORDER BY
	Title



SELECT
	*
FROM
	dbo.GameOfThrones
ORDER BY
	Title DESC				-- Hamnar i oalfabetisk ordning



SELECT
	*
FROM 
	dbo.GameOfThrones
ORDER BY
	[U.S. viewers(millions)]



SELECT 
	*
FROM
	dbo.GameOfThrones
WHERE
	[Directed by] LIKE 'D%'
ORDER BY 
	[U.S. viewers(millions)]


SELECT
	Title AS [Episode Name], [Directed by] AS Director
FROM
	dbo.GameOfThrones



SELECT DISTINCT
	[Directed by]
FROM
	dbo.GameOfThrones




SELECT 
	Firstname, CASE
					WHEN LEN (Firstname) <= 4 THEN 'KORT'
					WHEN LEN (Firstname) >= 8 THEN 'LÅNGT'
					ELSE 'MELLAN'
				END
				AS 'NamnLängd'
FROM
	dbo.Users


SELECT
	FirstName, LastName
FROM
	dbo.Users

UNION ALL

SELECT 
	Title, [Directed by]
FROM
	dbo.GameOfThrones




SELECT 
Firstname, CASE
				WHEN LEN (Firstname) <= 4 THEN 'KORT'
				WHEN LEN (Firstname) >= 8 THEN 'LÅNGT'
			ELSE 'MELLAN'
			END
			AS 'NamnLängd'
FROM 
	dbo.Users


SELECT
	*
FROM
	dbo.GameOfThrones
WHERE
	Season IN (6)


SELECT
	Title AS [Episode Name], [Directed by] AS Director
FROM
	dbo.GameOfThrones