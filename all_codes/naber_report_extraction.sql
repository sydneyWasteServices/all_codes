SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM 
[STAGE_1_DB].[BOOKING_SCH_S1].[BOOKING_TB_S1]
-- where [Date] between '20210701' and '20210731'


SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM 
[STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]


SELECT 
-- TABLE_CATALOG,
-- TABLE_SCHEMA
TABLE_NAME
-- COLUMN_NAME,
-- DATA_TYPE,
-- IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
Group by TABLE_NAME
-- WHERE TABLE_NAME = 'BOOKING_TB_S1';


USE
    [STAGE_2_DB]
GO


WITH naber_report_ds AS(

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE 
        [Customer number] IN (1887,3763,3268,3483,2317,4236,3476,4156,3966,4365)
    AND
        [DATE] BETWEEN '20210801' AND '20210831'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 4138 AND 4138.1
    AND
        [DATE] BETWEEN '20210801' AND '20210831'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 3139 AND 3139.1
    AND
        [DATE] BETWEEN '20210801' AND '20210831'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 1021 AND 1021.1
    AND
        [DATE] BETWEEN '20210801' AND '20210831'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 2505 AND 2505.1
    AND
        [DATE] BETWEEN '20210801' AND '20210831'

        UNION
        
    Select
         * 
    From 
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE 
        [Customer number] = 1202.032
    AND 
        [DATE] BETWEEN '20210801' AND '20210831'


)
Select *
FROM naber_report_ds
ORDER BY [Date]



-- =========================================================================
Select
 * 
From 
    [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
WHERE 
    [Customer number] = 4138.005
AND 
    [DATE] BETWEEN '20210801' AND '20210630'


-- Customer Number -> 4365 - 26 Lee street

Select 
    *
From 
    [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
WHERE 
    [DATE] BETWEEN '20210801' AND '20210831'
AND 
    [Customer number] = 4365
 
-- LIKE '26 Lee%'


-- 4138 All
-- 3139 All
-- 1021 All
-- 2505 All

-- 1887,3763,3268,3483,2317,4236,3476,4156,3966,1202.032
-- 4365 Only



SELECT TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME,
COLUMN_NAME,
DATA_TYPE,
IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS

SELECT      T.name TableName,i.Rows NumberOfRows
FROM        sys.tables T
JOIN        sys.sysindexes I ON T.OBJECT_ID = I.ID
WHERE       indid IN (0,1)
ORDER BY    i.Rows DESC,T.name



-- STAGE 1 DB
    -- TIPPING_TB_S1

-- STAGE 2 DB
    -- BOOKING_TB_S2
    -- SUEZ_TIPPING_TB_S2


