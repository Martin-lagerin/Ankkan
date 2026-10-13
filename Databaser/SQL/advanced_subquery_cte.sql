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


-- Find students who have scored above the total average at any point during their studies

SELECT
	FirstName, LastName
FROM
	Students
WHERE
	StudentID IN (
					SELECT StudentId
					FROM Enrollments
					WHERE Score > (
									SELECT AVG(Score) FROM Enrollments
								  )
				);

-- Get average scores per student using a subquery

SELECT
	s.Firstname,
	s.LastName,
	avgScores.AverageScore
FROM
	Students s JOIN (
					 SELECT StudentID,
					 AVG(Score) AS AverageScore
					 FROM Enrollments
					 GROUP BY StudentID
					) avgScores ON s.StudentID = avgScores.StudentID;


-- CTE

-- A CTE is a temporary result defined with WITH, used to simplify complex queries and improve readability.

/*

WITH CTE_Name AS (
    SELECT ...
)
SELECT * FROM CTE_Name;

*/

WITH avgScores AS (
					 SELECT StudentID,
					 AVG(Score) AS AverageScore
					 FROM Enrollments
					 GROUP BY StudentID
                  )

SELECT
	s.Firstname,
	s.LastName,
	avgScores.AverageScore
FROM
	Students s JOIN avgScores ON s.StudentID = avgScores.StudentID 



-- Find students with average score > 85

WITH HighAchievers AS (
						SELECT 
							StudentID, 
							AVG(Score) AS AvgScore
						FROM Enrollments
						GROUP BY StudentID
						HAVING AVG(Score) > 85
	                   )

SELECT 
	s.Firstname, s.LastName, h.AvgScore
FROM
	Students s JOIN HighAchievers h ON s.StudentID = h.StudentID



-- List students with the courses they took and their scores

WITH StudentCourses AS (
		SELECT
			s.FirstName,
			s.LastName,
			c.Coursename,
			e.Score
		FROM Students s  
		JOIN Enrollments e ON s.StudentID = e.StudentID
		JOIN Courses c ON e.CourseID = c.CourseID
		               )
SELECT
	*
FROM 
	StudentCourses
ORDER BY
	LastName



-- First, calculate per-course average, then find students who beat it


WITH CourseAverage AS (
						SELECT CourseID, AVG(Score) AS AvgScore
						FROM Enrollments
						GROUP BY CourseID
					  ),
    AboveAverageScores AS (
							SELECT e.StudentID, e.CourseID, e.Score, ca.AvgScore
							FROM Enrollments e JOIN CourseAverage ca ON e.CourseID = ca.CourseID
						  )

SELECT
	s.Firstname, s.LastName, c.CourseName, aas.Score, aas.AvgScore
FROM 
	AboveAverageScores aas 
	JOIN Students s ON aas.StudentID = s.StudentID
	JOIN Courses c ON aas.CourseID = c.CourseID
WHERE
	aas.Score > aas.AvgScore