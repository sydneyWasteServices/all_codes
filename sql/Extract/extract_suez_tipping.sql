SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, 
count(*)
FROM [STAGE].[SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1]


SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, 
count(*)
FROM [STAGE].[SUEZ_TIPPING_SCH_2].[SUEZ_TIPPING_TB_2]




--  TRUNCATE TABLE SUEZ_TIPPING_SCH_S2
TRUNCATE TABLE [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]

-- 6/5/2021 - 13/5/2021
-- 07 04 2021 13 04 2021

-- inspect duplicate DOCKET
SELECT [DATE], [DOCKET], count([DOCKET])
FROM [STAGE].[SUEZ_TIPPING_SCH_2].[SUEZ_TIPPING_TB_2]
GROUP BY [DATE], [DOCKET]
HAVING count([DOCKET]) > 1 
order by [DATE] desc



SELECT [DATE], [Job_No], count([Job_No])
FROM [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
GROUP BY [DATE], [Job_No]
HAVING count([Job_No]) > 1 
order by [DATE] desc


SELECT * FROM [STAGE].[SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1]

TRUNCATE TABLE [STAGE_2_DB].[SUEZ_TIPPING_SCH_S2].[SUEZ_TIPPING_TB_S2]

-- ================================================================================
SELECT 
    [Date],
    [First_Weigh],
    [Docket],
    [Rego],
    [Net_t],
    [Price_per_unit],
    [Net_t] * [Price_per_unit] AS [total_price]
FROM 
    [STAGE].[SUEZ_TIPPING_SCH_2].[SUEZ_TIPPING_TB_2]
WHERE [DATE] BETWEEN '20211006' AND '20211012' 
AND 
    [REGO] in ('XN76VB', 'CQ64LO')    
ORDER BY 
    [DATE],
    [REGO]
-- ================================================================================



-- Check Tonnage 
SELECT 
    SUM([Net_t])
FROM
[STAGE].[SUEZ_TIPPING_SCH_2].[SUEZ_TIPPING_TB_2]
WHERE [DATE] BETWEEN '20210811' AND '20210817'     

-- Check average daily ton 
SELECT 
    [date],
    count(*) as Num_Row,
    avg([Net_t]) as Average_ton
FROM 
    [STAGE].[SUEZ_TIPPING_SCH_2].[SUEZ_TIPPING_TB_2]
WHERE  [DATE] BETWEEN '20210811' AND '20210817'     
GROUP by 
    [DATE];







