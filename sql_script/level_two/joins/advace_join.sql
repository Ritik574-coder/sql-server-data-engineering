/********************************************************************
### HARD MODE – SQL JOIN PRACTICE (WITH DIFFICULTY RATING) ##########
Database: WideWorldImporters
Scale: 8.0 → 10.0 (strict data engineering level)
********************************************************************/


/* =========================
SECTION 1 – DATA VALIDATION
========================= */

/*Q1 (8.5/10):
Detect customers where total Orders count ≠ total distinct OrderIDs after joining OrderLines.
Tables:
Sales.Orders, Sales.OrderLines, Sales.Customers*/
SELECT 
    o.CustomerID,
    c.CustomerName,
    COUNT(DISTINCT o.OrderID) as distinct_order_count,
    COUNT(ol.OrderID) as order_count
FROM Sales.Orders as o  
INNER JOIN Sales.OrderLines as ol  
    ON o.OrderID = ol.OrderID 
INNER JOIN Sales.Customers as c  
    ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CustomerName
HAVING COUNT(ol.OrderID) <> COUNT(DISTINCT o.OrderID) 
ORDER BY o.CustomerID ASC ; 
 

/*Q2 (8.0/10):
Identify Orders where sum(OrderLines.Quantity) = 0 but order exists.
Tables:
Sales.Orders, Sales.OrderLines*/
SELECT 
    o.OrderID,
    COALESCE(SUM(ol.Quantity), 0) as order_quentity 
FROM Sales.Orders as o  
LEFT JOIN Sales.OrderLines as ol 
    ON o.OrderID = ol.OrderID 
GROUP BY o.OrderID 
HAVING COALESCE(SUM(ol.Quantity), 0) = 0 ;


/*Q3 (8.5/10):
Find Orders that multiply rows incorrectly due to duplicate StockItemID joins.
Tables:
Sales.OrderLines, Warehouse.StockItems*/
WITH before_join AS(
    SELECT 
        OrderID,
        COUNT(*) before_count
    FROM Sales.OrderLines
    GROUP BY OrderID 
),
after_join AS (
    SELECT 
        ol.OrderID,
        COUNT(*) as after_count
    FROM Sales.OrderLines as oL  
    INNER JOIN Warehouse.StockItems as s  
        ON ol.StockItemID = s.StockItemID
    GROUP BY ol.OrderID
)
SELECT 
    bj.OrderID,
    bj.before_count,
    aj.after_count
FROM before_join as bj 
INNER JOIN after_join as aj 
    ON bj.OrderID = aj.OrderID 
WHERE aj.after_count > bj.before_count ;


/*Q4 (9.0/10):
Detect Customers where joining Orders causes row explosion > expected threshold 130.
Tables:
Sales.Customers, Sales.Orders*/
SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) as total_orders 
FROM Sales.Customers as c 
INNER JOIN Sales.Orders as o  
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName 
HAVING COUNT(o.OrderID) > 130;


/*Q5 (8.5/10):
Validate that every Order has at least one OrderLine — return violations.
Tables:
Sales.Orders, Sales.OrderLines*/
SELECT 
    o.OrderID
FROM Sales.Orders as o 
WHERE NOT EXISTS
(
    SELECT 1 
    FROM Sales.OrderLines as ol 
    WHERE  o.OrderID = ol.OrderID
) ;

/*Q6 (9.0/10):
Find Orders where joining to Customers produces multiple CustomerNames.
Tables:
Sales.Orders, Sales.Customers*/

/*Q7 (9.0/10):
Identify inconsistent joins where one OrderID maps to multiple CustomerIDs.
Tables:
Sales.Orders, Sales.OrderLines*/

/*Q8 (9.0/10):
Detect Orders where LEFT JOIN to Invoices produces duplicate InvoiceIDs.
Tables:
Sales.Orders, Sales.Invoices*/

/*Q9 (9.5/10):
Find Orders where FULL JOIN between Orders and Invoices shows mismatch on both sides.
Tables:
Sales.Orders, Sales.Invoices*/

/*Q10 (9.0/10):
Identify customers where total Orders (JOIN) > actual Orders table count.
Tables:
Sales.Customers, Sales.Orders*/

/* ==============================
SECTION 2 – NULL & JOIN BREAKS
================================= */

/*Q11 (9.0/10):
Find Customers where LEFT JOIN Orders returns NULL but Orders exist in system.
Tables:
Sales.Customers, Sales.Orders*/

/*Q12 (9.0/10):
Detect Orders where CustomerID exists but JOIN still produces NULL customer.
Tables:
Sales.Orders, Sales.Customers*/

/*Q13 (9.5/10):
Identify rows where FULL JOIN produces NULL on both sides incorrectly.
Tables:
Sales.Orders, Sales.Invoices*/

/*Q14 (8.5/10):
Find Orders where RIGHT JOIN removes valid Orders unexpectedly.
Tables:
Sales.Orders, Sales.Customers*/

/*Q15 (9.5/10):
Detect cases where LEFT JOIN + WHERE filter behaves as INNER JOIN.
Tables:
Sales.Customers, Sales.Orders*/

/*Q16 (9.5/10):
Find rows where NULL propagation hides real data due to incorrect join order.
Tables:
Sales.Orders, Sales.OrderLines, Warehouse.StockItems*/

/*
Q17 (9.0/10):
Identify Customers where joining People table produces NULL names but PersonID exists.
Tables:
Sales.Customers, Application.People
*/

/*
Q18 (8.5/10):
Detect Orders where joining OrderLines results in NULL StockItemID.
Tables:
Sales.Orders, Sales.OrderLines
*/

/*
Q19 (9.0/10):
Find mismatch caused by NULL values in join keys.
Tables:
Sales.Orders, Sales.Customers
*/

/*
Q20 (9.5/10):
Detect rows lost due to improper NULL handling in multi-join chain.
Tables:
Sales.Orders, Sales.OrderLines, Warehouse.StockItems, Sales.Customers
*/


/* =========================
SECTION 3 – JOIN EXPLOSION
========================= */

/*
Q21 (9.0/10):
Identify join combinations where Orders × OrderLines causes exponential growth.
Tables:
Sales.Orders, Sales.OrderLines
*/

/*
Q22 (9.5/10):
Detect Customers whose Orders create unusually high join multiplication.
Tables:
Sales.Customers, Sales.Orders, Sales.OrderLines
*/

/*
Q23 (9.0/10):
Find StockItems that cause row explosion when joined with OrderLines.
Tables:
Warehouse.StockItems, Sales.OrderLines
*/

/*
Q24 (9.5/10):
Detect joins where 1:N becomes N:N due to incorrect join condition.
Tables:
Sales.Orders, Sales.OrderLines
*/

/*
Q25 (9.5/10):
Build query to flag joins exceeding expected cardinality threshold.
Tables:
Sales.Orders, Sales.OrderLines
*/

/*
Q26 (9.0/10):
Identify Orders where join count differs before vs after aggregation.
Tables:
Sales.Orders, Sales.OrderLines
*/

/*
Q27 (9.0/10):
Detect duplicate joins caused by non-unique foreign keys.
Tables:
Sales.OrderLines, Warehouse.StockItems
*/

/*
Q28 (9.5/10):
Find customers with highest join expansion ratio.
Tables:
Sales.Customers, Sales.Orders, Sales.OrderLines
*/

/*
Q29 (8.5/10):
Detect incorrect join keys causing artificial duplication.
Tables:
Sales.Orders, Sales.Customers
*/

/*
Q30 (9.5/10):
Identify joins that inflate revenue calculation incorrectly.
Tables:
Sales.OrderLines, Sales.Orders, Warehouse.StockItems
*/


/* =========================
SECTION 4 – MULTI JOIN CHAINS
========================= */

/*
Q31 (9.5/10):
Join Orders → Customers → People → OrderLines → StockItems and detect inconsistencies.
Tables:
Sales.Orders, Sales.Customers, Application.People, Sales.OrderLines, Warehouse.StockItems
*/

/*
Q32 (9.5/10):
Identify Orders where any join in the chain breaks (NULL appears mid-chain).
Tables:
Sales.Orders, Sales.OrderLines, Warehouse.StockItems
*/

/*
Q33 (9.5/10):
Find Customers whose Orders have missing StockItems in chain joins.
Tables:
Sales.Customers, Sales.Orders, Sales.OrderLines, Warehouse.StockItems
*/

/*
Q34 (9.0/10):
Detect rows where multiple joins produce conflicting attribute values.
Tables:
Sales.Orders, Sales.Customers, Application.People
*/

/*
Q35 (10/10):
Build query to verify referential integrity across 4+ tables.
Tables:
Sales.Orders, Sales.OrderLines, Sales.Customers, Warehouse.StockItems
*/

/*
Q36 (9.0/10):
Identify Orders where different joins produce different counts.
Tables:
Sales.Orders, Sales.OrderLines
*/

/*
Q37 (9.5/10):
Detect mismatches between Salesperson and Customer relationships.
Tables:
Sales.Orders, Sales.Customers, Application.People
*/

/*
Q38 (9.0/10):
Find Orders where joining People table creates duplicate roles.
Tables:
Sales.Orders, Application.People
*/

/*
Q39 (9.5/10):
Identify inconsistent join paths producing different outputs.
Tables:
Sales.Orders, Sales.OrderLines, Warehouse.StockItems
*/

/*
Q40 (9.5/10):
Detect cases where join order changes final result.
Tables:
Sales.Orders, Sales.OrderLines, Sales.Customers
*/


/* =========================
SECTION 5 – FULL JOIN / RECONCILIATION
========================= */

/*
Q41 (9.5/10):
Build FULL JOIN report between Orders and Invoices.
Tables:
Sales.Orders, Sales.Invoices
*/

/*
Q42 (9.5/10):
Identify mismatched counts between Orders and OrderLines using FULL JOIN.
Tables:
Sales.Orders, Sales.OrderLines
*/

/*
Q43 (9.0/10):
Detect missing relationships using FULL JOIN across Customers and Orders.
Tables:
Sales.Customers, Sales.Orders
*/

/*
Q44 (9.5/10):
Build reconciliation showing total expected vs actual joins.
Tables:
Sales.Orders, Sales.OrderLines
*/

/*
Q45 (9.0/10):
Identify records present in one table but missing in related table.
Tables:
Sales.Orders, Sales.Invoices
*/

/*
Q46 (9.5/10):
Detect asymmetric joins.
Tables:
Sales.Orders, Sales.Invoices
*/

/*
Q47 (10/10):
Build mismatch classification (perfect/missing left/missing right).
Tables:
Sales.Orders, Sales.Invoices
*/

/*
Q48 (10/10):
Detect join drift between two related tables over time.
Tables:
Sales.Orders, Sales.Invoices
*/

/*
Q49 (10/10):
Identify broken pipeline scenario where joins fail after schema change.
Tables:
Sales.Orders, Sales.OrderLines
*/

/*
Q50 (10/10):
Build final audit query with row counts, duplicates, NULLs, mismatches.
Tables:
Sales.Orders, Sales.OrderLines, Sales.Customers
*/