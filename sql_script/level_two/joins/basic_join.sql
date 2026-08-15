--############################################################
--### WIDEWORLDIMPORTERS – JOIN PRACTICE (50 QUESTIONS) ######
--############################################################

---------------------------
--### LEVEL 1 (1–15) – CORE JOINS
---------------------------
--1. Get OrderID, CustomerName using INNER JOIN.
SELECT
    o.OrderID,
    c.CustomerID,
    c.CustomerName
FROM Sales.Customers as c 
INNER JOIN Sales.Orders as o  
ON c.CustomerID = o.CustomerID 
ORDER BY  c.CustomerID;

--2. Get all customers and their orders (include customers with no orders).
SELECT
    c.CustomerID,
    o.OrderID,
    c.CustomerName,
    c.AccountOpenedDate,
    c.PaymentDays,
    c.PostalAddressLine1,
    c.DeliveryAddressLine1,
    c.WebsiteURL,
    o.OrderDate,
    o.ExpectedDeliveryDate
FROM Sales.Customers as c   
LEFT JOIN Sales.Orders as o  
ON c.CustomerID = o.CustomerID 

--3. Get orders with salesperson full name.
SELECT 
    so.OrderID,
    so.CustomerPurchaseOrderNumber,
    so.IsUndersupplyBackordered,
    so.OrderDate,
    so.ExpectedDeliveryDate,
    ap.FullName as SalespersonName,
    ap.PhoneNumber,
    ap.EmailAddress
FROM  Sales.Orders as so
INNER JOIN Application.People as ap
ON ap.PersonID = so.SalespersonPersonID
ORDER BY so.OrderID ASC ;

--4. Get OrderID, CustomerName, OrderDate.
SELECT 
    so.OrderID,
    sc.CustomerName,
    so.OrderDate
FROM Sales.Orders as so 
INNER JOIN Sales.Customers as sc 
ON so.CustomerID = sc.CustomerID
ORDER BY so.OrderID ASC ;

--5. Get all orders and corresponding picking person name.
SELECT 
    so.OrderID,
    so.PickedByPersonID,
    ap.FullName as PickingPersonName
FROM Sales.Orders as so
INNER JOIN Application.People as ap
ON so.PickedByPersonID = ap.PersonID

--6. Get all orders with customer and salesperson in same query.
SELECT 
    so.OrderID,
    so.CustomerID,
    so.SalespersonPersonID,
    sc.CustomerName,
    ap.FullName as SalesPersonName
FROM Sales.Orders as so  
INNER JOIN Sales.Customers as sc 
ON so.CustomerID = sc.CustomerID
LEFT JOIN Application.People as ap 
ON so.SalespersonPersonID = ap.PersonID ;

--7. Find all customers who have placed at least one order.
SELECT 
    sc.CustomerID,
    COUNT(*) as Order_count
FROM Sales.Customers as sc
LEFT JOIN Sales.Orders as so
ON so.CustomerID = sc.CustomerID
GROUP BY sc.CustomerID
HAVING COUNT(so.OrderID) >= 1

--8. Find all customers who have never placed any order.
SELECT 
    sc.CustomerID,
    COUNT(*) as Order_count
FROM Sales.Customers as sc
LEFT JOIN Sales.Orders as so
ON so.CustomerID = sc.CustomerID
GROUP BY sc.CustomerID
HAVING COUNT(so.OrderID) < 1

--9. Get all orders with CustomerName and ContactPerson name.
SELECT 
    o.OrderID,
    c.CustomerName,
    p.FullName as ContactPersonName
FROM Sales.Orders as o
INNER JOIN Sales.Customers as c 
ON o.CustomerID = c.CustomerID
INNER JOIN Application.People p 
ON  o.ContactPersonID = p.PersonID ;

SELECT TOP 10 * FROM Application.People ;
--10. Get all order lines with StockItem name.
--
--11. Get OrderID and total number of items in that order.
--
--12. Get all orders where customer is from a specific city.
--
--13. Get all orders with delivery method name.
--
--14. Get orders and corresponding invoice ID (if exists).
--
--15. Get orders and show NULL where invoice not generated.
--
--
---------------------------
--### LEVEL 2 (16–30) – LOGIC + CONDITIONS
---------------------------
--
--16. Find customers who have more than 5 orders.
--
--17. Find customers whose total order count is zero.
--
--18. Get top 10 customers by number of orders.
--
--19. Get orders where StockItem name contains 'USB'.
--
--20. Get orders where customer name starts with 'A'.
--
--21. Find orders that have more than 3 order lines.
--
--22. Get orders placed by specific salesperson.
--
--23. Find customers who ordered more than 10 different products.
--
--24. Get orders where any item price > 1000.
--
--25. Get orders with total order amount.
--
--26. Get customers with total spending > 50000.
--
--27. Get average order value per customer.
--
--28. Find orders where at least one item is out of stock.
--
--29. Get orders placed in a date range with customer details.
--
--30. Find orders where delivery city != customer city.
--
--
---------------------------
--### LEVEL 3 (31–40) – MULTI JOIN + EDGE CASES
---------------------------
--
--31. Get OrderID, CustomerName, SalespersonName, StockItemName.
--
--32. Find duplicate joins causing row multiplication (detect).
--
--33. Find customers linked to multiple cities (data inconsistency check).
--
--34. Get orders with both picking and sales person names.
--
--35. Find orders with no order lines (data issue).
--
--36. Find StockItems never ordered.
--
--37. Find customers who ordered all products in a category.
--
--38. Get most frequently ordered product.
--
--39. Get least ordered product.
--
--40. Find customers who only ordered one product repeatedly.
--
--
---------------------------
--### LEVEL 4 (41–50) – HARD / REAL DATA ENGINEERING
---------------------------
--
--41. Detect join explosion between Orders and OrderLines (compare counts).
--
--42. Validate 1:N relationship between Customers and Orders.
--
--43. Identify orphan records (Orders without Customers).
--
--44. Identify orphan records (OrderLines without Orders).
--
--45. Build a query to simulate FULL OUTER JOIN mismatch report.
--
--46. Find customers whose order total suddenly spiked (join + aggregation).
--
--47. Find inconsistent joins (same OrderID with multiple customers).
--
--48. Build anti-join to find missing invoices.
--
--49. Compare expected vs actual row count after multi-table join.
--
--50. Create a reconciliation report:
--    - Total Orders
--    - Total OrderLines
--    - Mismatch count
--    - Missing relationships
--
--
--############################################################
--################### END OF QUESTIONS ########################
--############################################################