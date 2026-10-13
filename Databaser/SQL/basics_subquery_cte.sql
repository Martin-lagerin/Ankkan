USE AI25;

CREATE TABLE Products (
  ProductID INT IDENTITY PRIMARY KEY,
  ProductName NVARCHAR(50) NOT NULL,
  CategoryID INT,                        --- FOREIGN KEY som refererar till CategoryID i Categories tabellen
  UnitPrice FLOAT NOT NULL
);

CREATE TABLE Categories (
  CategoryID INT IDENTITY PRIMARY KEY,   
  CategoryName NVARCHAR(50) NOT NULL
);

INSERT INTO 
Products (ProductName, CategoryID, UnitPrice)
VALUES
('Laptop', 1, 899.99), ('Shirt', 2, 29.99), ('Desk', 3, 199.99), ('Phone', 1, 499.99), ('Dress', 2, 59.99), ('Chair', 3, 99.99);

INSERT INTO Categories (CategoryName)
VALUES ('Electronics'), ('Clothing'), ('Furniture');

SELECT * FROM Products;
SELECT * FROM Categories;


-- SUBQUERY

-- Find the most expensive product using a subquery

SELECT TOP 1 * FROM PRODUCTS ORDER BY UnitPrice DESC



SELECT
	*
FROM
	Products
WHERE
	UnitPrice = (
				SELECT
					MAX(UnitPrice)
				FROM
					Products
				);

-- Find all products in the 'Electronics' category


SELECT
	*
FROM
	Products
WHERE
	CategoryID IN (
				 SELECT 
					CategoryID
				 FROM 
					Categories
				 WHERE CategoryName IN ('Electronics', 'Furniture')
				 );
					

-- Subqueries can be used under different clauses such as SELECT, WHERE, FROM and HAVING

SELECT
	ProductName,
	UnitPrice,
	(SELECT 
		CategoryName
	 FROM 
		Categories
	 WHERE 
		Categories.CategoryID = Products.CategoryID) AS CategoryName
FROM
	Products


-- Correlated Subqueries

-- Find all products more expensive than the average price within their category

SELECT
	p.ProductName, p.UnitPrice, c.CategoryID, c.CategoryName
FROM
	Products p JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE
	p.UnitPrice > ( 
					SELECT
						AVG(UnitPrice)
					FROM
						Products p2
					WHERE p2.CategoryID = p.CategoryID
				 );

-- WITH STATEMENTS (CTE)

WITH ElecontricCategory AS (
							SELECT *
							FROM Categories
							WHERE CategoryName IN ('Electronics')
						   )

SELECT
	*
FROM
	Products
WHERE CategoryID IN (
					 SELECT CategoryID
					 FROM ElecontricCategory
					);





