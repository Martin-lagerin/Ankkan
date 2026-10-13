
-- Uppgift A
SELECT
    Title,
    'S' + FORMAT(Season, '00') + 'E' + FORMAT(EpisodeInSeason, '00') AS Episode
FROM GameOfThrones;


SELECT
    *
FROM
    GameOfThrones


-- Uppgift B

SELECT
    *
FROM
    Users2


UPDATE Users2
SET UserName = LOWER(LEFT(FirstName, 2) + LEFT(LastName, 2));

-- TRANSLATE ? Username, 'ÅÄÖ' , 'AAO'        


-- UPPGIFT C

SELECT
    *
FROM
    Airports2


UPDATE 
    Airports2
SET 
    Time = ISNULL(Time, '-'),
    DST = ISNULL(DST, '-')

-- COUNT ?


SELECT
    *
FROM
    Airports2

-- Upgift D

SELECT
    *
FROM 
    Elements2


-- Upgifft E

SELECT  * FROM Elements



