USE everyloop;

SELECT 
	*
FROM
	dbo.Users;


SELECT
	*
FROM
	Users;    -- behöver ej skriva ut dbo. i tabellnamn, ty dbo är standardschema (mer om detta senasre)


SELECT
	ID,
	FirstName,
	LastName,
	FirstName + ' ' + LastName AS FullName -- generera en ny kolumn i vår returnerade vy (obs, ändrar ej i själva tabellen)
FROM
	Users;

-- SELECT INTO (skapa en ny tabell, från en befintlig tabell)

SELECT
	*
INTO
	Users2
FROM
	Users;


SELECT
	*
FROM
	Users2;

-- DROP TABLE (låt oss radera den nyligen skapade tabellen)

DROP TABLE
	Users2;

--

SELECT
	ID,
	FirstName,
	LastName,
	FirstName + ' ' + LastName AS FullName
INTO
	Users2
FROM
	Users;


SELECT
	*
FROM
	Users2;

-- Låt oss skapa en till tabell som heter GoTs01, som bara innnehåller episoder från säsong 1

SELECT
	*
FROM
	GameOfThrones;


SELECT
	*
INTO
	GoTs01
FROM
	GameOfThrones
WHERE
	Season=1;


SELECT * FROM GoTs01;


DROP TABLE
	GoTs01;

-- INSERT INTO (lägg till rader till en befintlig tabell)

SELECT * FROM Users2;

INSERT INTO Users2 (ID, FirstName, LastName, FullName) VALUES('891211-xxxx', 'Ali', 'Leylani', 'Ali Leylani');
INSERT INTO Users2 VALUES('891211-xxxx', 'Ali', 'Leylani', 'Ali Leylani');
INSERT INTO Users2 (ID, FirstName, LastName) VALUES('891211-xxxx', 'Ali', 'Leylani');

INSERT INTO Users2 (FirstName, LastName, FullName) VALUES('Ali', 'Leylani', 'Ali Leylani'); -- kommer ge error, eftersom att kolumnen
																							-- ID ej tillåter NULL-värden


-- DELETE FROM (radera rader som uppfyller visst villkor)

SELECT ID, FirstName FROM Users2
ORDER BY ID ASC;

DELETE FROM Users2 WHERE ID = '891211-xxxx';   -- radera rader som uppfyller ett (eller flera) villkor

SELECT ID, FirstName FROM Users2
ORDER BY ID ASC;

-- TRUNCATE TABLE (radera alla rader från en befintlig tabell)

SELECT * FROM Users;


SELECT
	FirstName AS 'UserName',
	LastName AS 'PassWord'
INTO
	UserCredentials
FROM
	Users;

SELECT * FROM UserCredentials;

TRUNCATE TABLE UserCredentials;

SELECT * FROM UserCredentials;

-- INSERT INTO SELECT FROM (sätta in värden till en befintlig tabell, från en annan tabell, givet vissa villkor

SELECT * FROM GameOfThrones;


SELECT * FROM UserCredentials;


INSERT INTO UserCredentials (UserName, PassWord)
SELECT
	Season, Episode
FROM
	GameOfThrones
WHERE Season < 7;


SELECT * FROM UserCredentials;


DROP TABLE UserCredentials;

-- UPDATE (uppdatera värden i en befintlig kolumn)

SELECT * FROM Users2;

INSERT INTO Users2 (ID, FirstName, LastName) VALUES('1', 'Ali', 'Leylani');

UPDATE Users2 SET FullName = 'Ali Leylani' WHERE ID = '1';


SELECT
	ID,
	FirstName,
	LastName,
	FirstName + ' ' + LastName as FullName,
	FirstName + ' ' + LastName + '' + LastName as Email
INTO 
	Users3
FROM
	Users;

SELECT * FROM Users3;


-- MINIUPPGIFT
-- uppdatera Email till att anta formatet {förnamn}@gmail.com för alla rader där förnamnets
-- längd är kortare än 6 bokstäver exempelvis ali@gmail.com (HINT: använd ett UPDATE kommando)

UPDATE Users3 SET Email = LOWER(FirstName) + '@gmail.com'
WHERE LEN(FirstName) < 6;

SELECT * FROM Users3;


-- CREATE TABLE (skapa ny tabell, från scratch)

CREATE TABLE Persons(
	ID INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(max)
	);

SELECT * FROM persons;

INSERT INTO Persons VALUES(1, 'Ali', 'Leylani');
INSERT INTO Persons (ID, FirstName) VALUES(1, 'Ali');
INSERT INTO Persons VALUES(0, 'Amir', 'Leylani');

DROP TABLE Persons;

CREATE TABLE Persons(
	ID INT,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(max)
	);

INSERT INTO Persons VALUES(1, 'Ali', 'Leylani');
INSERT INTO Persons (ID, FirstName) VALUES(1, 'Ali');

INSERT INTO Persons (ID, LastName) VALUES(1, 'Leylani'); -- error, ty FirstName måste anges

DROP TABLE Persons;

-- PRIMARY KEY

CREATE TABLE Persons(
	ID INT PRIMARY KEY,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(max)
	);

INSERT INTO Persons (ID, FirstName, LastName) VALUES(1, 'Ali', 'Leylani');
INSERT INTO Persons (ID, FirstName, LastName) VALUES(1, 'Amir', 'Leylani'); -- kommer ej gå, ID = 1 existerar redan
INSERT INTO Persons (ID, FirstName, LastName) VALUES(0, 'Amir', 'Leylani'); -- unikt ID, kommer att funka!

SELECT * FROM Persons;