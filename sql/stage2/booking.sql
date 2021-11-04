SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM  [STAGE].[BOOKING_SCH_1].[BOOKING_TB_1]; 

SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM  [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2] 

SELECT TOP 3 * FROM  [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2] 

SELECT count(DISTINCT [Job_No]) FROM  [STAGE].[BOOKING_SCH_1].[BOOKING_TB_1] 
WHERE [DATE] between '20210901' AND '20210930';

SELECT count(DISTINCT [Job_No]) FROM  [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2] 
WHERE  [DATE] between '20210901' AND '20210930';

SELECT count(DISTINCT [Job_No]) FROM  [STAGE].[BOOKING_SCH_1].[BOOKING_TB_1] 
WHERE [DATE] between '20211001' AND '20211031';

SELECT count(DISTINCT [Job_No]) FROM  [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2] 
WHERE  [DATE] between '20211001' AND '20211031';



WITH DistinctJobs AS
(
    SELECT * ,
        ROW_NUMBER() OVER(
            PARTITION BY [Job_No] ORDER BY [Job_No]) AS 'RowNum' 
    FROM [STAGE].[BOOKING_SCH_1].[BOOKING_TB_1] 
)
SELECT * INTO #TmpTB
FROM DistinctJobs
WHERE RowNum = 1

ALTER TABLE #TmpTB
DROP COLUMN [RowNum], [ID]

INSERT INTO [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
SELECT * FROM #TmpTB
DROP TABLE #TmpTB




-- Insert into existing table

-- INSERT INTO [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
-- SELECT * FROM #TmpTB
-- DROP TABLE #TmpTB


-- Duplicate a new table

-- select * INTO 
-- [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
-- FROM #TmpTB
-- DROP TABLE #TmpTB
-- DROP TABLE #TmpTB


-- Check and Audit Data in #TmpTB
SELECT count(Distinct [Job No]) FROM #TmpTB


USE STAGE
GO

