SELECT name FROM sys.databases;
USE MASTER;

SELECT * FROM kanses_databse1;

USE master;
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Kansas';

USE master;
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'kanses_databse1';

SELECT COUNT(*) AS TotalRows FROM kanses_databse1;

--Question 1   Service Requests Over Time: What is the overall trend in Service Requests over the years 2018-2021? How have Service Requests changed on a monthly basis?

--For Yearly change

SELECT 
    YEAR(Creation_Date) AS Year, 
    COUNT([CASE ID]) AS NumberOfRequests
FROM 
    kanses_databse1
WHERE 
    YEAR(Creation_Date) BETWEEN 2018 AND 2021
GROUP BY 
    YEAR(Creation_Date)
ORDER BY 
    YEAR(Creation_Date);


--For Monthly Changes

SELECT 
    YEAR(Creation_Date) AS Year,
    MONTH(Creation_Date) AS Month, 
    COUNT([CASE ID]) AS NumberOfRequests
FROM 
    kanses_databse1
WHERE 
    YEAR(Creation_Date) BETWEEN 2018 AND 2021
GROUP BY 
    YEAR(Creation_Date), MONTH(Creation_Date)
ORDER BY 
    YEAR(Creation_Date), MONTH(Creation_Date);



--Question 2) (2) Volume of service requests received from different sources: What is the overall trend in Service Requests over Sources?

SELECT 
    SOURCE,
    COUNT([CASE ID]) AS NumberOfRequests
FROM 
    kanses_databse1
GROUP BY 
    SOURCE
ORDER BY 
    COUNT([CASE ID]) DESC;

--Question3) (3) Volume of service requests received by Department: What is the overall trend in Service Requests received by Departments?

SELECT 
    DEPARTMENT,
    COUNT([CASE ID]) AS NumberOfRequests
FROM 
    kanses_databse1
GROUP BY 
    DEPARTMENT
ORDER BY 
    COUNT([CASE ID]) DESC;

--Question 4)Top 10 Performance Metrics (Response Time) per CATEGORY and Type of Request: What are the top 10 cases whose response time was fastest? Categorize it with Category1 and Type of Request.
SELECT TOP 10
    Category1,
    TYPE,
    [CASE ID],
    [DAYS TO CLOSE]
FROM 
    kanses_databse1
ORDER BY 
    [DAYS TO CLOSE] ASC;



--(5) Geographical Visualization:  What are the Top 10 areas where most number of request were raised?
 
SELECT TOP 10
    [ZIP CODE],
    COUNT([CASE ID]) AS NumberOfRequests
FROM 
    kanses_databse1
GROUP BY 
    [ZIP CODE]
ORDER BY 
    COUNT([CASE ID]) DESC;



--(6) Departmental Workload Comparison: How does the workload vary among different departments and work groups? Create a visual representation to highlight the distribution.

SELECT 
    DEPARTMENT, 
    [WORK GROUP], 
    COUNT([CASE ID]) AS NumberOfRequests
FROM 
    kanses_databse1
GROUP BY 
    DEPARTMENT, [WORK GROUP]
ORDER BY 
    DEPARTMENT, COUNT([CASE ID]) DESC;


--(7) Response Time Analysis: Visualize the distribution of response times for each department. Are there any outliers or patterns in response times?

SELECT 
    DEPARTMENT, 
    AVG([DAYS TO CLOSE]) AS AverageResponseTime,
    MIN([DAYS TO CLOSE]) AS MinResponseTime,
    MAX([DAYS TO CLOSE]) AS MaxResponseTime,
    STDEV([DAYS TO CLOSE]) AS StdDevResponseTime
FROM 
    kanses_databse1
GROUP BY 
    DEPARTMENT
ORDER BY 
    AVG([DAYS TO CLOSE]);


--(8) Service Request Status Composition: Create a visualization to show the composition of service request statuses (open, closed, in progress). How has this composition changed over the years 2018-2021?

SELECT 
    YEAR(Creation_Date) AS Year,
    STATUS,
    COUNT([CASE ID]) AS NumberOfRequests
FROM 
    kanses_databse1
WHERE 
    YEAR(Creation_Date) BETWEEN 2018 AND 2021
GROUP BY 
    YEAR(Creation_Date), STATUS
ORDER BY 
    YEAR(Creation_Date), STATUS;



--(9) Time to Closure Analysis: Visualize the average days to close service requests for each category1. Are there categories with consistently longer closure times?
--Show top 10 

SELECT TOP 10
    Category1,
    AVG([DAYS TO CLOSE]) AS AvgDaysToClose
FROM 
    kanses_databse1
GROUP BY 
    Category1
ORDER BY 
    AVG([DAYS TO CLOSE]) DESC;


--(10) Workload Efficiency: Create a visualization to show the relationship between workload (number of service requests) and efficiency (days to close) for each department?

SELECT 
    DEPARTMENT,
    COUNT([CASE ID]) AS TotalRequests,
    AVG([DAYS TO CLOSE]) AS AvgDaysToClose
FROM 
    kanses_databse1
GROUP BY 
    DEPARTMENT;
