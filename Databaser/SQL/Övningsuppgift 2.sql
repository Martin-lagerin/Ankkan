

-- Övning A
-- Ta ut (select) en rad för varje (unik) period i tabellen ”Elements” med
-- följande kolumner: ”period”, ”from” med lägsta atomnumret i perioden,
-- ”to” med högsta atomnumret i perioden, ”average isotopes” med
-- genomsnittligt antal isotoper visat med 2 decimaler, ”symbols” med en
-- kommaseparerad lista av alla ämnen i perioden

SELECT * FROM Elements

SELECT
	Period,
	min(number) AS [from],
	max(number) as [to],
	FORMAT(avg(cast(Stableisotopes AS Float)), 'N2' ) AS [Average isotopes],
	STRING_AGG(symbol, ',') AS symbols
FROM
	Elements
GROUP BY
	Period

	


SELECT
	Period,
	AVG([Density]) as [Average isotopes]
FROM 
	Elements
GROUP BY 
	period
ORDER BY 
	period ASC



-- Övning B
-- För varje stad som har 2 eller fler kunder i tabellen Customers, ta ut
-- (select) följande kolumner: ”Region”, ”Country”, ”City”, samt
-- ”Customers” som anger hur många kunder som finns i staden.

SELECT * FROM Company.Customers

SELECT 
	City,
	Region,
	Country,
	COUNT(*) AS Costumers
	
FROM 
	Company.customers
GROUP BY 
	City,Country, Region
HAVING 
	COUNT(*) > 2
ORDER BY 
	costumers ASC






-- Övning C
-- Skapa en varchar-variabel och skriv en select-sats som sätter värdet:
-- ”Säsong 1 sändes från april till juni 2011. Totalt
-- sändes 10 avsnitt, som i genomsnitt sågs av 2.5
-- miljoner människor i USA.”, följt av radbyte/char(13), följt av
-- ”Säsong 2 sändes …” osv.
-- När du sedan skriver (print) variabeln till messages ska du alltså få en rad
-- för varje säsong enligt ovan, med data sammanställt från tabellen
-- GameOfThrones.
-- Tips: Ange ’sv’ som tredje parameter i format() för svenska månader


SELECT * FROM GameOfThrones

--------

DECLARE @Värdet AS NVARCHAR(max) = '';

SELECT
	@Värdet +=
	'Säsong ' + CAST(season as Varchar) +
	' sändes från ' + FORMAT(min([Original air date]),' MMMM ','sv') +
	' till ' + FORMAT(max([Original air date]),' MMMM yyyy ', 'sv') + 
	' Totalt Sändes ' + CAST(COUNT(*) AS VARCHAR) + 
	' avsnitt, som i genomsnitt sågs av ' + FORMAT(AVG([U.S. Viewers(millions)]), 'N1')+
	' miljoner människor i USA. ' + char(13)
FROM
	Gameofthrones
GROUP BY
	Season

PRINT @Värdet

------------

DECLARE @ny as NVARCHAR(max) = ' '

SELECT
	@ny = @ny +
	'Totalt sändes' + Cast(COUNT(*) AS nvarchar) + char(13)
FROM
	GameOfThrones
GROUP BY
	EpisodeInSeason
ORDER BY 
	EpisodeInSeason

print @ny


-- Övning D
-- Ta ut (select) alla användare i tabellen ”Users” så du får tre kolumner:
-- ”Namn” som har fulla namnet; ”Ålder” som visar hur många år personen
-- är idag (ex. ’45 år’); ”Kön” som visar om det är en man eller kvinna.
-- Sortera raderna efter för- och efternamn. 


SELECT * FROM Users


SELECT
	id,
	-- förnamn + eftenamn 
	Firstname + ' '+ Lastname as Fullname,

	-- personnummer - dagen datum = ålder
	YEAR(GETDATE()) as året,
	LEFT(ID, 2) as födelseår,
	YEAR(GETDATE()) - LEFT(ID, 2) as födelseår,
	RIGHT((YEAR(GETDATE()) - LEFT(ID, 2)), 2) AS ålder,
	SUBSTRING (ID, 3, 4) as månader,
	SUBSTRING (ID, 10, 1) as [nummer avgörande],   -- hakparantes för mellanslag 
	-- IF, Else siffra jämn/ojämn kvinna eller man.
	CASE WHEN 
		SUBSTRING(ID, 10, 1) % 2 = 0 THEN 'Kvinna'
		ELSE 'Man'
		END AS Kön
FROM
	Users



---------------


SELECT
	-- förnamn + eftenamn 
	Firstname + ' '+ Lastname as Fullname,

	-- personnummer - dagen datum = ålder
	Datediff(Year, Cast(left(ID, 6) AS Date), GETDATE()) as Ålder,

	-- IF, Else siffra jämn/ojämn kvinna eller man.
	CASE
		WHEN CAST(SUBSTRING(id, len(ID) -1,1) as INT) % 2 = 0
			THEN 'Kvinna'
		ELSE 'Man'
		END AS Kön
FROM
	Users
ORDER BY
	Fullname ASC



-- e) Ta ut en lista över regioner i tabellen ”Countries” där det för varje region
-- framgår regionens namn, antal länder i regionen, totalt antal invånare,
-- total area, befolkningstätheten med 2 decimaler, samt
-- spädbarnsdödligheten per 100.000 födslar avrundat till heltal.

SELECT * FROM Countries


SELECT
	Region AS 'Region name',
	COUNT(*) AS 'Number of countries',
	SUM(CAST(Population AS BIGINT)) AS 'Total population',
	SUM(CAST([Area (sq# mi#)] AS BIGINT)) AS 'Total area',
	ROUND((SUM(CAST(population AS BIGINT))) / CAST(SUM(CAST([Area (sq# mi#)] AS BIGINT)) AS FLOAT), 2) AS 'population dead',
	ROUND(AVG(CAST(REPLACE([Infant mortality (per 1000 births)], ',','.') as FLOAT)), 0) AS 'Infant mortality'
	FROM
		dbo.Countries
	GROUP BY 
		Region









-- f) Från tabellen ”Airports”, gruppera per land och ta ut kolumner som visar:
-- land, antal flygplatser (IATA-koder), antal som saknar ICAO-kod, samt hur
-- många procent av flygplatserna i varje land som saknar ICAO-kod.


SELECT * FROM Airports


SELECT
	[Location served],
	REVERSE ([Location served]) as Reserved
FROM 
	Airports


SELECT
	*
	SUVSTRING