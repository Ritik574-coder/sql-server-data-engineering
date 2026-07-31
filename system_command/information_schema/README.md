Here's a well-structured Markdown file that's perfect for GitHub. It includes the complete list, organized sections, practical examples, and helpful notes.

---

# SQL Server INFORMATION_SCHEMA Views - Complete Reference

> A comprehensive guide to all `INFORMATION_SCHEMA` views in Microsoft SQL Server

## Table of Contents
- [Overview](#-overview)
- [Complete List of Views](#-complete-list-of-views)
- [Quick Reference Table](#-quick-reference-table)
- [Common Usage Examples](#-common-usage-examples)
- [Important Notes](#-important-notes)
- [Quick Commands](#-quick-commands)

---

## Overview

The `INFORMATION_SCHEMA` views provide a standardized, system-independent way to access database metadata in SQL Server. These views are part of the ISO SQL standard, making your queries portable across different database systems.

**Key Benefits:**
- Standardized metadata access
- User-friendly and readable
- Works across different SQL Server versions
- Filters data based on user permissions

---

## Complete List of Views

### 1. Constraint Views

| View Name | Description |
|-----------|-------------|
| **`CHECK_CONSTRAINTS`** | Returns information about all check constraints in the current database |
| **`CONSTRAINT_COLUMN_USAGE`** | Shows which columns are used by table constraints |
| **`CONSTRAINT_TABLE_USAGE`** | Shows which tables are referenced by table constraints |
| **`TABLE_CONSTRAINTS`** | Lists all table-level constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK) |
| **`REFERENTIAL_CONSTRAINTS`** | Returns detailed information about FOREIGN KEY constraints |
| **`KEY_COLUMN_USAGE`** | Identifies columns that are part of key constraints (primary, foreign, unique) |

### 2. Table & Column Views

| View Name | Description |
|-----------|-------------|
| **`TABLES`** | Contains information about all tables and views in the database |
| **`COLUMNS`** | Provides detailed information about all columns in tables and views |
| **`VIEWS`** | Contains metadata about views in the database |
| **`VIEW_COLUMN_USAGE`** | Shows which columns are referenced in a view definition |
| **`VIEW_TABLE_USAGE`** | Shows which tables are referenced in a view definition |

### 3. Schema & Domain Views

| View Name | Description |
|-----------|-------------|
| **`SCHEMATA`** | Provides information about all schemas (databases) in the SQL Server instance |
| **`DOMAINS`** | Returns information about user-defined data types (domains) |
| **`DOMAIN_CONSTRAINTS`** | Lists constraints defined on user-defined data types |
| **`COLUMN_DOMAIN_USAGE`** | Identifies columns that use user-defined data types |

### 4. Privilege & Security Views

| View Name | Description |
|-----------|-------------|
| **`COLUMN_PRIVILEGES`** | Lists permissions (GRANT/REVOKE) on specific columns |
| **`TABLE_PRIVILEGES`** | Lists permissions (GRANT/REVOKE) on specific tables |

### 5. Stored Procedure & Function Views

| View Name | Description |
|-----------|-------------|
| **`ROUTINES`** | Contains information about stored procedures and user-defined functions |
| **`PARAMETERS`** | Returns parameter information for functions and stored procedures |
| **`ROUTINE_COLUMNS`** | Shows columns returned by table-valued functions |

---

## Common Usage Examples

### 1. List All Tables in Your Database
```sql
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_SCHEMA, TABLE_NAME;
```

### 2. Get Column Details for a Specific Table
```sql
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'YourTableName';
```

### 3. Find All Foreign Key Relationships
```sql
SELECT 
    FK.TABLE_NAME AS 'Foreign Key Table',
    FK.COLUMN_NAME AS 'Foreign Key Column',
    PK.TABLE_NAME AS 'Primary Key Table',
    PK.COLUMN_NAME AS 'Primary Key Column',
    RC.CONSTRAINT_NAME AS 'Foreign Key Name'
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE FK
    ON RC.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
    AND RC.CONSTRAINT_SCHEMA = FK.CONSTRAINT_SCHEMA
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE PK
    ON RC.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
    AND RC.UNIQUE_CONSTRAINT_SCHEMA = PK.CONSTRAINT_SCHEMA
    AND FK.ORDINAL_POSITION = PK.ORDINAL_POSITION 
;
```

### 4. Check All Constraints on a Table
```sql
SELECT 
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'YourTableName';
```

### 5. Find All Columns with User-Defined Data Types
```sql
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    DOMAIN_NAME
FROM INFORMATION_SCHEMA.COLUMN_DOMAIN_USAGE
ORDER BY DOMAIN_NAME;
```

---

## Important Notes

### Key Terminology Mapping

| INFORMATION_SCHEMA Term | SQL Server Equivalent |
|------------------------|----------------------|
| `TABLE_CATALOG` | Database Name |
| `TABLE_SCHEMA` | Schema/Owner Name |
| `DOMAIN` | User-defined Data Type |
| `ROUTINE` | Stored Procedure or Function |

### Permission Considerations

> **Important:** These views only return metadata for objects that:
> - You own, OR
> - You have been granted explicit permission to access

### Best Practices

1. **Always filter by SCHEMA** to avoid system objects:
   ```sql
   WHERE TABLE_SCHEMA = 'dbo'  -- Or your specific schema
   ```

2. **Use specific column selections** instead of `SELECT *` for better performance

3. **For system-level information**, consider using system views like `sys.objects`, `sys.tables`, etc.

4. **These views are read-only** - you cannot modify metadata through them

---

## Quick Commands

### Find All Available INFORMATION_SCHEMA Views
```sql
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'INFORMATION_SCHEMA'
ORDER BY TABLE_NAME;
```

### Count All INFORMATION_SCHEMA Views
```sql
SELECT COUNT(*) AS Total_Views
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'INFORMATION_SCHEMA';
```
> **Result:** Returns `20` (as per standard SQL Server installation)

### Check if a Specific View Exists
```sql
IF EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'INFORMATION_SCHEMA' 
    AND TABLE_NAME = 'TABLES'
)
PRINT 'View exists!';
```

---

## Summary

| Category | Number of Views |
|----------|----------------|
| **Constraints** | 6 |
| **Tables & Columns** | 5 |
| **Schema & Domains** | 4 |
| **Privileges** | 2 |
| **Routines & Parameters** | 3 |
| **TOTAL** | **20** |

---

## Additional Resources

- [Official Microsoft Documentation](https://docs.microsoft.com/en-us/sql/relational-databases/system-information-schema-views/system-information-schema-views-transact-sql)
- 🔧 [System Views vs INFORMATION_SCHEMA](https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/catalog-views-transact-sql)

---

## Quick Reference Card

```sql
-- Quick reference for most commonly used views:

-- 1. Get all tables
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- 2. Get all columns
SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

-- 3. Get all views
SELECT * FROM INFORMATION_SCHEMA.VIEWS;

-- 4. Get all constraints
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;

-- 5. Get all schemas
SELECT * FROM INFORMATION_SCHEMA.SCHEMATA;

-- 6. Get all procedures/functions
SELECT * FROM INFORMATION_SCHEMA.ROUTINES;
```

---

**Last Updated:** 2024  
**Compatible with:** SQL Server 2012 and above

---

