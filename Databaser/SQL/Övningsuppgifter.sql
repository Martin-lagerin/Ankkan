USE AI25;

-- OBS skapa och inserta datan ENDAST EN GÅNG
-- DROP TABLE om du råkar generera duplicerade rader

CREATE TABLE Students (
				StudentID INT PRIMARY KEY,
				Firstname NVARCHAR(50),
				LastName NVARCHAR(50),
				GradeLevel INT
				      )

CREATE TABLE Courses (
	            CourseID INT PRIMARY KEY,
				CourseName NVARCHAR(100),
				Teacher NVARCHAR(100)
				     )

CREATE TABLE Enrollments (
                EnrollmentID INT PRIMARY KEY,
				StudentID INT,
				CourseID INT,
				Score INT
				         )

-- Insert Students
INSERT INTO Students VALUES
(1, 'Alice', 'Johnson', 10),
(2, 'Bob', 'Smith', 10),
(3, 'Charlie', 'Lee', 11),
(4, 'Diana', 'Garcia', 11),
(5, 'Ethan', 'White', 12),
(6, 'Fiona', 'Brown', 12);

-- Insert Courses
INSERT INTO Courses VALUES
(101, 'Mathematics', 'Mr. Adams'),
(102, 'History', 'Ms. Brooks'),
(103, 'Biology', 'Dr. Clark'),
(104, 'English', 'Mrs. Davis'),
(105, 'Physics', 'Dr. Evans');

-- Insert Enrollments
INSERT INTO Enrollments VALUES
(1, 1, 101, 85),
(2, 1, 102, 90),
(3, 1, 103, 75),
(4, 2, 101, 78),
(5, 2, 104, 82),
(6, 3, 103, 88),
(7, 3, 105, 91),
(8, 4, 102, 85),
(9, 4, 101, 89),
(10, 5, 104, 95),
(11, 5, 105, 87),
(12, 6, 102, 90),
(13, 6, 103, 92);


SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;



-- Excercises can be solved using either SUBQUERIES OR CTE, up to you



-- Exercise 1: Find Students Enrolled in More Than two Courses



-- Excercise 2: Show average score per course, along with teacher name




-- Excercise 3: Find students whose score is below the course average




-- Excercise 4: List students who took 'Physics' and scored above 85.










-- FLER TABELLER & UPPGIFTER


CREATE TABLE Products (
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2)                      -- Decimaltal med totalt 10 siffror, varav 2 st efter decimaltecknet
);

CREATE TABLE Customers (
    CustomerID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    City NVARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT
);

INSERT INTO Products VALUES
('Wireless Mouse', 'Electronics', 25.99),
('Laptop', 'Electronics', 999.99),
('Notebook', 'Stationery', 3.50),
('Pen Pack', 'Stationery', 4.99),
('Desk Lamp', 'Home', 29.99);


INSERT INTO Customers VALUES
('John', 'Doe', 'New York'),
('Jane', 'Smith', 'Chicago'),
('Mike', 'Brown', 'New York'),
('Lisa', 'Taylor', 'Seattle');


INSERT INTO Orders VALUES
(1, '2024-01-10'),
(1, '2024-02-15'),
(2, '2024-03-01'),
(3, '2024-03-22'),
(4, '2024-04-05');

INSERT INTO OrderItems VALUES
(1, 2, 1),
(1, 1, 2),
(2, 5, 1),
(3, 3, 5),
(3, 4, 3),
(4, 1, 1),
(5, 2, 1);


SELECT * FROM Products
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM OrderItems


-- Excercise 1 Find the total number of orders placed by each customer [Easy]




-- Excercise 2 List products that have been ordered more than once across all orders [Easy-Medium]




-- Excercise 3 Find the average order value for each customer (based on price × quantity) [Medium]

-- Hint: just use CTE version for this one



