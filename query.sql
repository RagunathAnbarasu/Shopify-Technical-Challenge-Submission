/*
Description : Solution to Task 2 of Shopify Data Science Intern Challenge - Winter 2022
Author : Ragunath Anbarasu
Created Date: 12/09/21
Modified Date: 14/09/21
*/

-- a) How many orders were shipped by Speedy Express in total?


SELECT COUNT(*) AS TotalOrdersBySpeedyExpress  
FROM Orders
INNER JOIN Shippers
ON Orders.ShipperID = Shippers.ShipperID
WHERE Shippers.ShipperName = 'Speedy Express'


/* Result

TotalOrdersBySpeedyExpress
54 

*/

-- b) What is the last name of the employee with the most orders?



SELECT LastName AS EmployeeWithMostOrders FROM Employees 
INNER JOIN Orders
	ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.LastName
HAVING COUNT(*) = (	SELECT MAX(numberOrders)
					FROM (	SELECT EmployeeID, COUNT(OrderID) AS numberOrders
							FROM Orders
							GROUP BY EmployeeID) maxOrders) 



/* Result

EmployeeWithMostOrders
Peacock 

*/

-- c)What product was ordered the most by customers in Germany?

SELECT TOP 1 Products.ProductName AS TopProductInGermany
FROM (((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) INNER JOIN Products ON
Products.ProductID = OrderDetails.ProductID) WHERE Customers.Country = 'Germany' GROUP BY ProductName
ORDER BY SUM(Quantity) DESC;

/* Result

TopProductInGermany
Boston Crab Meat 

*/