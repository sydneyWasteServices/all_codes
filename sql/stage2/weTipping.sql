SELECT MIN(DISTINCT [Route_Date]) as EarliestDate,
MAX(DISTINCT [Route_Date]) as LATESTDATE, count(*)
FROM 
[STAGE].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1];

SELECT MIN(DISTINCT [Route_Date]) as EarliestDate,
MAX(DISTINCT [Route_Date]) as LATESTDATE, count(*)
FROM 
[STAGE].[WE_TIPPING_SCH_2].[WE_TIPPING_TB_2];


SELECT top 3 * FROM [STAGE].[WE_TIPPING_SCH_2].[WE_TIPPING_TB_2]


Select count(DISTINCT Sequence_No) from [STAGE].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1]
where [Route_Date] BETWEEN '20211001' and '20211031';

Select count(DISTINCT Sequence_No) from [STAGE].[WE_TIPPING_SCH_2].[WE_TIPPING_TB_2]
where [Route_Date] BETWEEN '20211001' and '20211031';


WITH DistinctSeqNo AS
(
    SELECT * ,
        ROW_NUMBER() OVER(
            PARTITION BY [Sequence_No] ORDER BY [Sequence_No]) AS 'RowNum' 
    FROM [STAGE].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1]
    Where [Route_Date] BETWEEN '20211029' AND '20211102'
)
SELECT * INTO #TmpTB
FROM DistinctSeqNo
WHERE RowNum = 1;

ALTER TABLE #TmpTB
DROP COLUMN [RowNum], [ID]

INSERT INTO [STAGE].[WE_TIPPING_SCH_2].[WE_TIPPING_TB_2]
SELECT * FROM #TmpTB
DROP TABLE #TmpTB




select top 3 * from [STAGE].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1]
-- where [Route_Date] > '20210101'

-- new table
-- CREATE SCHEMA [WE_TIPPING_SCH_2]
-- SELECT * INTO 
-- [STAGE].[WE_TIPPING_SCH_2].[WE_TIPPING_TB_2]
-- FROM #TmpTB
-- DROP TABLE #TmpTB

