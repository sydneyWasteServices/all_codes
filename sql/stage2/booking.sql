SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM  [STAGE_1_DB].[BOOKING_SCH_1].[BOOKING_TB_1] 


SELECT TOP 3 * FROM  [STAGE_1_DB].[BOOKING_SCH_1].[BOOKING_TB_1] 


WITH DistinctJobs AS
(
    SELECT * ,
        ROW_NUMBER() OVER(
            PARTITION BY [Job_No] ORDER BY [Job_No]) AS 'RowNum' 
    FROM [STAGE_1_DB].[BOOKING_SCH_1].[BOOKING_TB_1] 
    WHERE [Date] BETWEEN '20210901' AND '20210930'
)
SELECT * INTO #TmpTB
FROM DistinctJobs
WHERE RowNum = 1

ALTER TABLE #TmpTB
DROP COLUMN [RowNum], [ID]

INSERT INTO [STAGE_2_DB].[BOOKING_SCH_2].[BOOKING_TB_2]
SELECT * FROM #TmpTB
DROP TABLE #TmpTB


-- Check and Audit Data in #TmpTB
SELECT count(Distinct [Job No]) FROM #TmpTB


