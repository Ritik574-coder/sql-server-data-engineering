-- all FK info 
SELECT 
    fk.name AS FK_Name,
    OBJECT_NAME(fk.parent_object_id) AS Child_Table,
    c1.name AS Child_Column,
    OBJECT_NAME(fk.referenced_object_id) AS Parent_Table,
    c2.name AS Parent_Column
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.columns c1 
    ON fkc.parent_object_id = c1.object_id 
    AND fkc.parent_column_id = c1.column_id
INNER JOIN sys.columns c2 
    ON fkc.referenced_object_id = c2.object_id 
    AND fkc.referenced_column_id = c2.column_id
ORDER BY Child_Table;




SELECT 
    fk.name AS FK_Name,
    sch_child.name AS Child_Schema,
    OBJECT_NAME(fk.parent_object_id) AS Child_Table,
    c1.name AS Child_Column,
    sch_parent.name AS Parent_Schema,
    OBJECT_NAME(fk.referenced_object_id) AS Parent_Table,
    c2.name AS Parent_Column
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.columns c1 
    ON fkc.parent_object_id = c1.object_id 
    AND fkc.parent_column_id = c1.column_id
INNER JOIN sys.columns c2 
    ON fkc.referenced_object_id = c2.object_id 
    AND fkc.referenced_column_id = c2.column_id
INNER JOIN sys.tables t_child
    ON fk.parent_object_id = t_child.object_id
INNER JOIN sys.tables t_parent
    ON fk.referenced_object_id = t_parent.object_id
INNER JOIN sys.schemas sch_child
    ON t_child.schema_id = sch_child.schema_id
INNER JOIN sys.schemas sch_parent
    ON t_parent.schema_id = sch_parent.schema_id
ORDER BY 
    Child_Schema,
    Child_Table;









--get all PK info 
SELECT 
    t.name AS Table_Name,
    c.name AS Column_Name,
    kc.name AS PK_Name
FROM sys.key_constraints kc
INNER JOIN sys.tables t 
    ON kc.parent_object_id = t.object_id
INNER JOIN sys.index_columns ic 
    ON kc.unique_index_id = ic.index_id 
    AND kc.parent_object_id = ic.object_id
INNER JOIN sys.columns c 
    ON ic.object_id = c.object_id 
    AND ic.column_id = c.column_id
WHERE kc.type = 'PK'
ORDER BY t.name;

-- info about primery keys and forgen keys 
SELECT 
    fk.name AS FK_Name,
    pt.name AS Parent_Table,
    pc.name AS Parent_Column,
    rt.name AS Referenced_Table,
    rc.name AS Referenced_Column
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.tables pt 
    ON fkc.parent_object_id = pt.object_id
INNER JOIN sys.columns pc 
    ON fkc.parent_object_id = pc.object_id 
    AND fkc.parent_column_id = pc.column_id
INNER JOIN sys.tables rt 
    ON fkc.referenced_object_id = rt.object_id
INNER JOIN sys.columns rc 
    ON fkc.referenced_object_id = rc.object_id 
    AND fkc.referenced_column_id = rc.column_id
WHERE pt.name LIKE 'Customers'
ORDER BY pt.name ;

-- specific table info 
SELECT 
    fk.name AS FK_Name,
    OBJECT_NAME(fk.parent_object_id) AS Child_Table,
    OBJECT_NAME(fk.referenced_object_id) AS Parent_Table
FROM sys.foreign_keys fk
WHERE OBJECT_NAME(fk.parent_object_id) = 'Orders'
   OR OBJECT_NAME(fk.referenced_object_id) = 'Orders';

--quich snapshort 
EXEC sp_help 'Sales.Orders';


SELECT 
    ss.schema_id,
    ss.name as schema_name,
    st.name as table_name 
FROM sys.schemas as ss 
INNER JOIN sys.tables as st  
ON ss.schema_id = st.schema_id ;

SELECT *
FROM sys.dm_db_index_usage_stats;