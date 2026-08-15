-- calcute how meany unique order eatch customer place 
SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(DISTINCT o.OrderID) as order_count
FROM 
Sales.Customers as c  
LEFT JOIN Sales.Orders as o  
ON c.CustomerID = o.CustomerID 
GROUP BY c.CustomerID, c.CustomerName
ORDER BY c.CustomerID ;

-- list those customers they never plase any order 
SELECT 
    c.CustomerID,
    c.CustomerName
FROM Sales.Customers AS c  
LEFT JOIN  Sales.orders AS o  
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL ; 

-- manager want to list of those customers they place more then five orders 
SELECT 
    c.CustomerID,
    c.CustomerName,
COUNT(o.OrderID) as order_count 
FROM Sales.Customers as c  
INNER JOIN Sales.Orders as o  
    ON c.CustomerID = o.CustomerID 
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) > 5 ; 

-- Management wants to know which customers generated the highest sales value.
SELECT TOP 1 WITH TIES
    c.CustomerID,
    c.CustomerName,
    SUM(ol.UnitPrice * ol.Quantity) as SalesValue
FROM Sales.Customers AS c  
INNER JOIN Sales.Orders AS o  
    ON c.CustomerID = o.CustomerID 
INNER JOIN Sales.OrderLines AS ol 
    ON o.OrderID = ol.OrderID 
GROUP BY c.CustomerID,c.CustomerName
ORDER BY SalesValue DESC ;

/* Identify customers who have placed a high volume of orders but have a comparatively low total sales value
(i.e., low average order value), indicating they might be buying inexpensive items or heavily discounted
 products.*/

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.orderID) AS OrderCount,
    SUM(ol.UnitPrice * ol.Quantity) AS SalesValue
FROM Sales.Customers AS c  
INNER JOIN Sales.Orders AS o  
    ON c.CustomerID = o.CustomerID 
INNER JOIN Sales.OrderLines AS ol 
    ON o.OrderID = ol.OrderID 
GROUP BY c.CustomerID,c.CustomerName
ORDER BY OrderCount DESC, SalesValue ASC;