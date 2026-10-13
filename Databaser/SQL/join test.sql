

CREATE TABLE Country
(
	ID INT PRIMARY KEY,
	Name NVARCHAR(20)
)

SELECT * FROM Country

INSERT INTO Country VALUES ( 1, 'Sweden'));
INSERT INTO Country VALUES ( 2, 'Denmark');
INSERT INTO Country VALUES ( 3, 'Norway');
INSERT INTO Country VALUES ( 4, 'Finland');


UPDATE Country
SET Name = 'Finland'
WHERE ID = 4

EXEC sp_rename 'Country.ID', 'id', 'COLUMN';

EXEC sp_rename 'Cities.ID', 'id', 'COLUMN';




CREATE TABLE Cities
(
	ID INT PRIMARY KEY,
	Name NVARCHAR(20),
	CountryID INT 
)

SELECT * FROM Cities

INSERT INTO Cities VALUES(1, 'Stockholm', 1)
INSERT INTO Cities VALUES(2, 'Gothenburg', 1)
INSERT INTO Cities VALUES(3, 'Malmö', 1)
INSERT INTO Cities VALUES(4, 'Copenhagen', 2)
INSERT INTO Cities VALUES(5, 'Oslo', 3)
INSERT INTO Cities VALUES(6, 'Bergen', 3)
INSERT INTO Cities VALUES(7, 'London', 5)


SELECT * FROM Country
SELECT * FROM Cities


-- JOIN

SELECT
	*
FROM 
	Cities JOIN Country on Cities.CountryID = Country.id


SELECT
	Cities.name AS stad,
	Country.name AS Land
FROM
	Cities JOIN Country ON Cities.Countryid = Country.id


SELECT
	*,
	ci.name AS Stad,
	co.name AS Land
FROM
	Cities AS ci JOIN Country AS co ON ci.CountryID = co.id





CREATE TABLE FAMILY
(
	ID INT,
	Name NVARCHAR(50),
	Lastname NVARCHAR(50),
	Children INT
);

SELECT * FROM FAMILY

INSERT INTO FAMILY
(
	ID,
	Name,
	Lastname,
	Children
)
VALUES
(921026,'Martin','Lagerin',4),
(930224,'Malin','Wahlgren',3),
(150522,'Max', 'Lagerin',0),
(170517,'Elias','Lagerin',0),
(170822,'Alicia','Sjöström',0),
(240607,'Alba','Lagerin',0);

SELECT * FROM FAMILY

CREATE TABLE FRIENDS
(
	Name NVARCHAR(50),
	ID INT,
	Children INT
);

INSERT INTO FRIENDS
(
	Name,
	ID,
	Children
)
VALUES
('Daniel',921016,0),
('Jose',910505,0),
('Patrik',920620,1),
('Annie', 921103,4);

INSERT INTO FRIENDS
(
	ID,
	Children
)
VALUES
(921026,3)

SELECT * FROM FAMILY
SELECT * FROM FRIENDS



SELECT
	s.Name,
	s.Children,
	p.Name as [Friend name],
	p.Children as [Friend Children]

FROM 
	FAMILY as S
	JOIN FRIENDS as P on s.Children = p.Children;


SELECT 
	ID,
	Children,
	Name + ' ' + Lastname
FROM
	FAMILY
WHERE 
	Children > 2


SELECT
	s.Lastname,
	s.Children,
	p.Name,
	COUNT(*) as matches
FROM
	FAMILY as s
	join FRIENDS as p on s.Children = p.Children
GROUP BY
	s.Children,p.Name,s.Lastname;



SELECT AVG(children) as avg
FROM FAMILY


