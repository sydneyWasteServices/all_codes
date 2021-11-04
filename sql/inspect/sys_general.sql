DROP DATABASE CONST_INFO
CREATE DATABASE GENERAL_INFO

-- inspect DBs
SELECT name, database_id, create_date  
FROM sys.databases ;  
GO  

-- 
USE [STAGE_1_DB]
GO

USE info 
go

USE [STAGE_2_DB]
GO

SELECT DISTINCT [table_schema], [TABLE_NAME]
FROM INFORMATION_SCHEMA.COLUMNS


select s.name as schema_name, 
    s.schema_id,
    u.name as schema_owner
from sys.schemas s
    inner join sys.sysusers u
        on u.uid = s.principal_id
where s.schema_id > 4 
    and s.schema_id < 10000 
order by s.schema_id


-- Inspect Table Columns 
SELECT
	*
FROM
  	INFORMATION_SCHEMA.COLUMNS
WHERE 
    [DATA_TYPE] = 'text'

-- CDC======================================================
SELECT s.name AS Schema_Name, tb.name AS Table_Name
, tb.object_id, tb.type, tb.type_desc, tb.is_tracked_by_cdc
FROM sys.tables tb
INNER JOIN sys.schemas s on s.schema_id = tb.schema_id
WHERE tb.is_tracked_by_cdc = 1

SELECT name, database_id, is_cdc_enabled FROM sys.databases
WHERE is_cdc_enabled = 1

DECLARE @begin binary(10), @end binary(10);
 SET @begin = sys.fn_cdc_get_min_lsn('BOOKING_SCH_S1_BOOKING_TB_S1');
 SET @end = sys.fn_cdc_get_max_lsn();
SELECT * FROM [cdc].[fn_cdc_get_all_changes_BOOKING_SCH_S1_BOOKING_TB_S1](@begin, @end, N'ALL')



SELECT
  *
FROM
  SYSOBJECTS
WHERE
  xtype = 'U';
GO


SELECT
  *
FROM
  INFORMATION_SCHEMA.TABLES;
GO