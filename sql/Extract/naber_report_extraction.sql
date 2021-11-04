-- Rempve data type text

ALTER table
[STAGE_1_DB].[BOOKING_SCH_1].[BOOKING_TB_1]
ALTER COLUMN [Directions] VARCHAR(MAX)
  

SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM 
[STAGE].[BOOKING_SCH_1].[BOOKING_TB_1];


SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM 
[STAGE].[BOOKING_SCH_2].[BOOKING_TB_2];


WITH naber_report_ds AS(
    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE 
        [Customer_Number] IN (1887,3763,3268,3483,2317,4236,3476,4156,3966,4365)
    AND
        [DATE] BETWEEN '20210901' AND '20210930'

        UNION

    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE
        [Customer_Number] BETWEEN 4138 AND 4138.1
    AND
        [DATE] BETWEEN '20210901' AND '20210930'

        UNION

    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE
        [Customer_Number] BETWEEN 3139 AND 3139.1
    AND
        [DATE] BETWEEN '20210901' AND '20210930'

        UNION

    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE
        [Customer_Number] BETWEEN 1021 AND 1021.1
    AND
        [DATE] BETWEEN '20210901' AND '20210930'

        UNION

    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE
        [Customer_Number] BETWEEN 2505 AND 2505.1
    AND
        [DATE] BETWEEN '20210901' AND '20210930'

)Select count (*)
FROM naber_report_ds;
-- ORDER BY [Date]


-- =====================================================================================

WITH naber_report_ds AS(
    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE 
        [Customer_number] IN (1887,3763,3268,3483,2317,4236,3476,4156,3966,4365)
    AND
        [DATE] BETWEEN '20211001' AND '20211031'

        UNION

    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE
        [Customer_number] BETWEEN 4138 AND 4138.1
    AND
        [DATE] BETWEEN '20211001' AND '20211031'

        UNION

    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE
        [Customer_number] BETWEEN 3139 AND 3139.1
    AND
        [DATE] BETWEEN '20211001' AND '20211031'

        UNION

    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE
        [Customer_number] BETWEEN 1021 AND 1021.1
    AND
        [DATE] BETWEEN '20211001' AND '20211031'

        UNION

    SELECT
        * 
    FROM
        [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
    WHERE
        [Customer_number] BETWEEN 2505 AND 2505.1
    AND
        [DATE] BETWEEN '20211001' AND '20211031'

)  
Select * FROM naber_report_ds
order by [DATE]




-- 4138 All
-- 3139 All
-- 1021 All
-- 2505 All

-- 1887,3763,3268,3483,2317,4236,3476,4156,3966
-- 4365 Only