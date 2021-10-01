SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE_1_DB].[SUEZ_TIPPING_SCH_S1].[SUEZ_TIPPING_TB_S1]



SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]


--  TRUNCATE TABLE SUEZ_TIPPING_SCH_S2
TRUNCATE TABLE [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]

-- 6/5/2021 - 13/5/2021
-- 07 04 2021 13 04 2021

-- inspect duplicate DOCKET
SELECT [DATE], [DOCKET], count([DOCKET])
FROM [STAGE_1_DB].[SUEZ_TIPPING_SCH_S1].[SUEZ_TIPPING_TB_S1]
GROUP BY [DATE], [DOCKET]
HAVING count([DOCKET]) > 1 
order by [DATE] desc


TRUNCATE TABLE [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]


SELECT 
    [Date],
    [1st Weigh],
    [Docket],
    [Rego],
    [Net (t)],
    [Price per unit],
    [Net (t)] * [Price per unit] AS [total_price]
FROM 
    [STAGE_1_DB].[SUEZ_TIPPING_SCH_S1].[SUEZ_TIPPING_TB_S1]
WHERE 
    -- [DATE] = '20210714'
    [DATE] BETWEEN '20210812' AND '20210825'



-- 30 - 6 
-- 7 - 13


-- ===================================================
-- Insert new non duplicate records to stage 2 table  

WITH Distinct_Doc AS
(
    SELECT * ,
        ROW_NUMBER() OVER(
            PARTITION BY [Docket] ORDER BY [Docket]) AS 'RowNum' 

    FROM 
        [STAGE_1_DB].[SUEZ_TIPPING_SCH_S1].[SUEZ_TIPPING_TB_S1]
    -- WHERE 
    --     [DATE] BETWEEN '20210812' AND '20210825'
    -- WHERE [Date] = '20210609'

    
)
SELECT * INTO #TmpTable
FROM Distinct_Doc
WHERE RowNum = 1

ALTER TABLE #TmpTable
DROP COLUMN RowNum;

INSERT INTO  
    [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]
SELECT *
FROM #TmpTable

DROP TABLE #TmpTable



Select * from  #TmpTable
WHERE [DATE] = '20210424'
ORDER BY [DOCKET]


-- SELECT * from 
-- [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]
-- WHERE [Date] BETWEEN '20210414' AND '20210420'
-- ORDER BY [Date]

-- ===============================================
-- Extract with Date

SELECT 
    [Date],
    [1st Weigh],
    [Docket],
    [Rego],
    [Net (t)],
    [Price per unit],
    [Net (t)] * [Price per unit] AS [total_price]
FROM 
     [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]
WHERE 
    [DATE] BETWEEN '20210818' AND '20210824'
ORDER BY 
    [DATE]




-- ===========================================
-- Data Audit 
SELECT 
    [DATE],
    -- count([DATE]) as occurence
    count(*)
    -- *
FROM
    [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]
WHERE [DATE] BETWEEN '20210818' AND '20210824'
GROUP BY [DATE]
ORDER BY [DATE]


-- Calculate Weight
-- =====================
SELECT 
    sum([Net (t)])
FROM 
     [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]

WHERE [DATE] BETWEEN '20210818' AND '20210824'



SELECT *
from 
     [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]
WHERE 
    [DATE] BETWEEN '20210602' AND '20210608'


     
DELETE 
FROM 
[STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]
WHERE 
[DATE] = '20210609'



SELECT 
    count(*) as Num_Row,
    avg([Net (t)]) as Average_ton
    -- *
FROM 
     [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]

    -- [DATE] BETWEEN '20210609' AND '20210615'

WHERE [DATE] BETWEEN '20210818' AND '20210824'

    -- [DATE] = '20210609'

    -- [DATE] BETWEEN '20210609' AND '20210615'


SELECT 
    [date],
    count(*) as Num_Row,
    avg([Net (t)]) as Average_ton
-- *
FROM 
    [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]
WHERE 
    -- [DATE] BETWEEN '20210609' AND '20210615'

    [DATE] BETWEEN '20210731' AND '20210801'

GROUP by 
    [DATE]




SELECT * FROM [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]
ORDER BY [DATE] 