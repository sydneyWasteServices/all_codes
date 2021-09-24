SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM 
[STAGE_1_DB].[BOOKING_SCH_1].[BOOKING_TB_1]


SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM 
[STAGE_2_DB].[BOOKING_SCH_2].[BOOKING_TB_2];


SELECT 
    [Date],
     [Customer_Number],
    [Address_1],
    [Bin_Volume],
    [STATUS]
FROM 
    [STAGE_2_DB].[BOOKING_SCH_2].[BOOKING_TB_2]
WHERE 
--     [STATUS] = 'C'
-- AND 
    [Customer_Number] = 1345
AND
    [DATE] BETWEEN '20210801' and '20210831' 
ORDER BY   
    [Status]


-- ==================================================
-- Waste report 
With clean_waste_type_tb as (
Select 
    [Customer_Number],
    [Address_1],
    replace(replace(replace(replace([Waste_Type], 'General Waste', 'General'), 'Paper/Cardboard', 'Cardboard'), 'Glass Bin', 'Comingle'), 'Food Waste', 'Organics') Clean_Waste_Type ,
    [Bin_Volume] * [Qty_Serviced] AS Total_volume
FROM
    [STAGE_2_DB].[BOOKING_SCH_2].[BOOKING_TB_2] 
WHERE 
    [DATE] BETWEEN 
        '20210701' 
        and 
        '20210731' 
AND 
    [Customer_Number] IN (
1345, 1346, 1347, 1547, 1683, 3291, 3293, 3294,
3295,3296,3297,3299,3303,3464,3590,4037,4308,
4309,4337,4378,4399,4547,4615,4326,4328,3992,
4370,4327,4231,4329,4330,4331,4332,4333,4334,
4335,4457,4472,4581,4321,4322,4323,3909,4339,
4393,4340,4341,1870)
AND 
    [STATUS] = 'C'
), SourceTable as (
    SELECT 
    [Customer_Number],
    [Address_1],
    [Clean_Waste_Type],
    [Total_volume]
FROM 
    clean_waste_type_tb
WHERE [Clean_Waste_Type] IN 
    ('General', 'Cardboard', 'Comingle', 'Organics')
)Select [Customer_Number], [Address_1], [General], [Cardboard], [Comingle], [Organics]  from SourceTable PIVOT (
    SUM([Total_volume]) FOR [Clean_Waste_Type] IN ([General], [Cardboard], [Comingle], [Organics])
) AS pvt 
ORDER BY [Customer_Number];
-- ==================================================


-- ==========================================================

SELECT 
    [Customer_Number] ,
    [Waste_Type],
    SUM([Bin_Volume]) as 'Total Waste'
FROM 
    [STAGE_2_DB].[BOOKING_SCH_2].[BOOKING_TB_2] 
WHERE 
    [DATE] BETWEEN '20210801' and '20210831' 

GROUP BY 
    [Customer_Number], 
    [Waste_Type]
ORDER BY [Customer_Number] DESC


-- ==========================================================


SELECT 
    [Customer_Number] ,
    [Waste_Type],
    [Bin_Volume]
FROM 
    [STAGE_2_DB].[BOOKING_SCH_2].[BOOKING_TB_2] 
WHERE 
    [DATE] BETWEEN '20210801' and '20210831' 






    -- Clean_Waste_Type IN ('')





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
        [DATE] BETWEEN '20210401' AND '20210430'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 4138 AND 4138.1
    AND
        [DATE] BETWEEN '20210401' AND '20210430'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 3139 AND 3139.1
    AND
        [DATE] BETWEEN '20210401' AND '20210430'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 1021 AND 1021.1
    AND
        [DATE] BETWEEN '20210401' AND '20210430'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 2505 AND 2505.1
    AND
        [DATE] BETWEEN '20210401' AND '20210430'

)Select *
FROM naber_report_ds
ORDER BY [Date]


-- =====================================================================================

WITH naber_report_ds AS(
    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE 
        [Customer number] IN (1887,3763,3268,3483,2317,4236,3476,4156,3966,4365)
    AND
        [DATE] BETWEEN '20210401' AND '20210430'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 4138 AND 4138.1
    AND
        [DATE] BETWEEN '20210401' AND '20210430'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 3139 AND 3139.1
    AND
        [DATE] BETWEEN '20210401' AND '20210430'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 1021 AND 1021.1
    AND
        [DATE] BETWEEN '20210401' AND '20210430'

        UNION

    SELECT
        * 
    FROM
        [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]
    WHERE
        [Customer number] BETWEEN 2505 AND 2505.1
    AND
        [DATE] BETWEEN '20210401' AND '20210430'

)  
Select * FROM naber_report_ds
order by [DATE]




-- 4138 All
-- 3139 All
-- 1021 All
-- 2505 All

-- 1887,3763,3268,3483,2317,4236,3476,4156,3966
-- 4365 Only