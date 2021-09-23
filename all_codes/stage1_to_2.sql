
SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM 
[STAGE_1_DB].[BOOKING_SCH_S1].[BOOKING_TB_S1]

-- 2 238 917
SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]

-- Integrate Distinct Job No INTO Stage 2 DB 

-- 20559

WITH DistinctJobs AS
(
    SELECT * ,
        ROW_NUMBER() OVER(
            PARTITION BY [Job No] ORDER BY [Job No]) AS 'RowNum' 
    FROM [STAGE_1_DB].[BOOKING_SCH_S1].[BOOKING_TB_S1]
    WHERE [Date] BETWEEN '20210421' AND '20210504'
)
SELECT * INTO #TmpTB
FROM DistinctJobs
WHERE RowNum = 1

ALTER TABLE #TmpTB
DROP COLUMN [RowNum]

INSERT INTO [STAGE_2_DB].BOOKING_SCH_S2.BOOKING_TB_S2
SELECT * FROM #TmpTB
DROP TABLE #TmpTB


SELECT TOP 3 * FROM [STAGE_2_DB].BOOKING_SCH_S2.BOOKING_TB_S2
SELECT TOP 3 * FROM #TmpTB



-- Check and Audit Data in #TmpTB
SELECT count(Distinct [Job No]) FROM #TmpTB

USE STAGE_1_DB
GO

SELECT * FROM [cdc].[BOOKING_SCH_S1_BOOKING_TB_S1_CT] GO

-- ===================================================
-- ===================================================


USE STAGE_2_DB
GO

SELECT s.name AS Schema_Name, tb.name AS Table_Name
, tb.object_id, tb.type, tb.type_desc, tb.is_tracked_by_cdc
FROM sys.tables tb
INNER JOIN sys.schemas s on s.schema_id = tb.schema_id
WHERE tb.is_tracked_by_cdc = 1

-- Distinct Jobs No and Date Range


WITH DistinctJobs AS
(
    SELECT * ,
        ROW_NUMBER() OVER(
            PARTITION BY [Job No] ORDER BY [Job No]) AS 'RowNum' 
    FROM [STAGE_1_DB].[BOOKING_SCH_S1].[BOOKING_TB_S1]
    WHERE [Date] >= '20210324'
    AND [Date] <= '20210406'
)
SELECT * INTO #TmpTB
FROM DistinctJobs
WHERE RowNum = 1

-- Check and Audit Data in #TmpTB
SELECT count(Distinct [Job No]) FROM #TmpTB

USE STAGE_1_DB
GO

SELECT * FROM [cdc].[BOOKING_SCH_S1_BOOKING_TB_S1_CT] GO

exec sp_who2
go

-- ===================================================\
-- Check SQL agent is running 


DECLARE @agent NVARCHAR(512);
SELECT @agent = COALESCE(N'SQLAgent$' + CONVERT(SYSNAME, SERVERPROPERTY('InstanceName')), 
  N'SQLServerAgent');

EXEC master.dbo.xp_servicecontrol 'QueryState', @agent;

SELECT dss.[status], dss.[status_desc]
FROM   sys.dm_server_services dss
WHERE  dss.[servicename] LIKE N'SQL Server Agent (%';


IF EXISTS (SELECT 1 FROM sysprocesses WHERE LEFT(program_name, 8) = 'SQLAgent')
  PRINT 'Agent is running!'
ELSE
  PRINT 'Agent is not connected!';

SELECT @@SERVERNAME


IF EXISTS (  SELECT 1 
             FROM master.dbo.sysprocesses 
             WHERE program_name = N'SQLAgent - Generic Refresher')
BEGIN
    SELECT @@SERVERNAME AS 'InstanceName', 1 AS 'SQLServerAgentRunning'
END
ELSE 
BEGIN
    SELECT @@SERVERNAME AS 'InstanceName', 0 AS 'SQLServerAgentRunning'
END
-- ===================================================\

-- ========================================
-- Agent XPs configure
EXEC sp_configure 'Agent XPs'
GO

EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

EXEC SP_CONFIGURE 'Agent XPs', 1;
GO
RECONFIGURE;
GO
-- ========================================



SELECT SERVERPROPERTY(N'servername') 
SELECT @@ServerName