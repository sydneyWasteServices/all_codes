-- 2 316 595
SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE_1_DB].[BOOKING_SCH_S1].[BOOKING_TB_S1];

SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2];


-- ==========================================
-- Insert non-duplicate records to Stage 2

WITH Distinct_JobID AS
(
    SELECT * ,
        ROW_NUMBER() OVER(
            PARTITION BY [Job No] ORDER BY [Job No]) AS 'RowNum'

    FROM 
        [STAGE_1_DB].[BOOKING_SCH_S1].[BOOKING_TB_S1]

    WHERE [Date] between  '20210801' AND '20210831'
    
    -- [Date] > '20210505'
    
)
SELECT * INTO #TmpTable
FROM Distinct_JobID
WHERE RowNum = 1

ALTER TABLE #TmpTable
DROP COLUMN RowNum;

INSERT INTO  
    [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
SELECT *
FROM #TmpTable;

drop table #TmpTable;


-- 2 298 862
SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
