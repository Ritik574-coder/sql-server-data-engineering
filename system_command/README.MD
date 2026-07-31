## SQL Server Metadata Reference (sys. & INFORMATION_SCHEMA.)

### Overview
This document summarizes the most important SQL Server metadata views used for database discovery, documentation, data engineering, and administration.

---

### INFORMATION_SCHEMA Views

| Object | Purpose | Description |
|--------|---------|-------------|
| INFORMATION_SCHEMA.TABLES | List tables/views | Returns user tables and views in the database. |
| INFORMATION_SCHEMA.COLUMNS | Column metadata | Returns column names, data types, nullability, defaults, etc. |
| INFORMATION_SCHEMA.VIEWS | Views | Lists all database views. |
| INFORMATION_SCHEMA.TABLE_CONSTRAINTS | Constraints | Returns PRIMARY KEY, FOREIGN KEY, UNIQUE and CHECK constraints. |
| INFORMATION_SCHEMA.KEY_COLUMN_USAGE | Key columns | Shows which columns participate in constraints. |
| INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS | FK relationships | Parent-child foreign key relationships. |
| INFORMATION_SCHEMA.CHECK_CONSTRAINTS | Check constraints | Returns CHECK expressions. |
| INFORMATION_SCHEMA.ROUTINES | Procedures & Functions | Lists stored procedures and functions. |
| INFORMATION_SCHEMA.PARAMETERS | Parameters | Parameters of procedures/functions. |
| INFORMATION_SCHEMA.SCHEMATA | Schemas | Lists database schemas. |

---

### sys Catalog Views

### Objects

| View | Purpose | Description |
|------|---------|-------------|
| sys.objects | All objects | Every object in the database. |
| sys.tables | Tables | User tables only. |
| sys.views | Views | Database views. |
| sys.schemas | Schemas | Schema information. |
| sys.columns | Columns | Metadata for every column. |
| sys.all_columns | All columns | Includes hidden/system columns. |
| sys.types | Data types | System and user-defined data types. |

### Constraints

| View | Purpose | Description |
|------|---------|-------------|
| sys.key_constraints | PK/Unique | Primary and unique constraints. |
| sys.foreign_keys | Foreign Keys | Foreign key definitions. |
| sys.foreign_key_columns | FK Columns | Parent and referenced columns. |
| sys.check_constraints | CHECK | Check constraint definitions. |
| sys.default_constraints | Defaults | Default values for columns. |

### Indexes & Statistics

| View | Purpose | Description |
|------|---------|-------------|
| sys.indexes | Indexes | Clustered, nonclustered, XML, columnstore indexes. |
| sys.index_columns | Index Columns | Columns inside each index. |
| sys.stats | Statistics | Query optimizer statistics. |
| sys.stats_columns | Statistics Columns | Columns used in statistics. |

## Programmability

| View | Purpose | Description |
|------|---------|-------------|
| sys.procedures | Procedures | Stored procedures. |
| sys.sql_modules | SQL Source | SQL definition of procedures, views, functions, triggers. |
| sys.parameters | Parameters | Parameters of routines. |
| sys.triggers | Triggers | Database and table triggers. |
| sys.synonyms | Synonyms | Alias objects. |

### Identity & Sequence

| View | Purpose | Description |
|------|---------|-------------|
| sys.identity_columns | Identity | Identity seed, increment and metadata. |
| sys.sequences | Sequences | Sequence objects. |

### Storage

| View | Purpose | Description |
|------|---------|-------------|
| sys.partitions | Partitions | Row count per partition. |
| sys.allocation_units | Storage | Storage allocation details. |
| sys.filegroups | Filegroups | Filegroup metadata. |
| sys.database_files | Database files | MDF/NDF/LDF information. |

### Security

| View | Purpose | Description |
|------|---------|-------------|
| sys.database_principals | Users/Roles | Database users and roles. |
| sys.database_permissions | Permissions | Granted permissions. |
| sys.server_principals | Logins | Server logins. |

### Dependencies

| View | Purpose | Description |
|------|---------|-------------|
| sys.sql_expression_dependencies | Dependencies | Object dependencies. |
| sys.dm_sql_referenced_entities() | References | Objects referenced by an object. |
| sys.dm_sql_referencing_entities() | Referencing | Objects that reference another object. |

---

### Dynamic Management Views (DMVs)

| DMV | Purpose | Description |
|-----|---------|-------------|
| sys.dm_db_index_usage_stats | Index usage | Tracks index reads/writes. |
| sys.dm_exec_query_stats | Query statistics | Performance metrics for cached queries. |
| sys.dm_exec_requests | Running requests | Currently executing requests. |
| sys.dm_exec_sessions | Sessions | Active user sessions. |
| sys.dm_db_partition_stats | Partition stats | Accurate row counts and storage. |
| sys.dm_exec_cached_plans | Cached plans | Execution plans in cache. |

---

### Recommended Learning Order

1. sys.objects
2. sys.tables
3. sys.columns
4. sys.types
5. sys.schemas
6. sys.key_constraints
7. sys.foreign_keys
8. sys.foreign_key_columns
9. sys.indexes
10. sys.index_columns
11. sys.check_constraints
12. sys.default_constraints
13. sys.identity_columns
14. sys.views
15. sys.procedures
16. sys.sql_modules
17. sys.parameters
18. sys.triggers
19. sys.partitions
20. sys.database_files
21. sys.dm_db_partition_stats
22. sys.dm_db_index_usage_stats
23. sys.dm_exec_query_stats

---

### Notes

- Prefer **sys** for SQL Server-specific development.
- Use **INFORMATION_SCHEMA** when ANSI SQL portability is important.
- Most database documentation, ERD generators, and reverse-engineering tools rely on these metadata views.
"""

