USE 
    STAGE_1_DB
GO


SELECT MIN(DISTINCT [Date]) as EarliestDate,
    MAX(DISTINCT [Date]) as LATESTDATE,
    count(DISTINCT [Job_No])
FROM [STAGE].[BOOKING_SCH_1].[BOOKING_TB_1]


SELECT MIN(DISTINCT [Date]) as EarliestDate,
    MAX(DISTINCT [Date]) as LATESTDATE,
    count(DISTINCT [Job_No])
FROM [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]

select top 3
    *
from [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]

SELECT
    count([DATE]),
    sum(*)
FROM
    [STAGE].[BOOKING_SCH_1].[BOOKING_TB_1]
WHERE [DATE] > '20210801'
GROUP BY 
[DATE];


Select * from 
[STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
WHERE 
    [Job_No] = 2919080.02


-- ========================================================================================================
-- Data Audit
-- ========================================================================================================

with
    ds_data_audit
    as
    (
        SELECT
            * ,
            PARSENAME(REPLACE([Route_Number], '-','.'),2) as rn
        -- SUM([Price])
        FROM
            [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
        WHERE 
    [Date] 
BETWEEN 
    '20211013' AND '20211019'
            AND
            [Status] = 'C'
    --     ORDER BY 
    -- [DATE],
    -- [Job_No]
    )
Select *
from ds_data_audit;

-- BR1 BR2	BR3	CBK	DOY	FL2	FLG	FLP	HOOK1	HYG	RED	RL1	RL2	RL4	RL5	RL6	RL7	RL8	RL9	RLC	RLD	RLE	RLG	RLH	RLI	RLJ	RLK	RLP	RLR	SWG	UOSCB	UOSCO	UOSGW	CMDCB	CMDGW	CUMGW	NEPCB	NEPGW	NIWPR1	NIWPR2
-- ========================================================================================================
-- Weekly Financial Report
-- ========================================================================================================
SELECT
    * ,
    [Price] / 11 *10 as excl_gst_price,
    PARSENAME(REPLACE([Route_Number], '-','.'),2) as Route_number
-- SUM([Price])
FROM
    [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
WHERE 
    [Date] 
BETWEEN 
    '20211013' AND '20211019'
    AND
    [Status] NOT IN ('V','N','F')
    AND 
    [Serv_Type] = 'COL'
ORDER BY 
    [DATE],
    [Job_No]





-- ============================================
-- SPLIT [Route Number]
-- ============================================
Select
    sum([Price])
From
    [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
CROSS APPLY
     string_split([Route_Number], '-')
where
    [Date] between '20210407' AND '20210420'
    AND
    [Route_Number] like '%HOOK%'
GROUP by
    [Route_Number]
-- ORDER BY
--     -- [Date],
--     [Job_No]
-- ======================


SELECT
    -- TABLE_CATALOG,
    -- TABLE_SCHEMA,
    TABLE_NAME
-- COLUMN_NAME,
-- DATA_TYPE,
-- IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
GROUP BY [TABLE_NAME]

SELECT table_name
FROM user_tables;



-- ========================
Select
    -- *,
    -- [Price] / 11 *10 as excl_gst_price
    count(*)
From
    [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
CROSS APPLY
     string_split([Route_Number], '-')
where
    [Date] between '20211013' AND '20211019'
    AND
    [Status] NOT IN ('V','N','F')
    AND
    [Serv_Type] = 'COL'
ORDER BY 
    [Date] 




-- ================================================
-- Extract Booking data
-- ================================================


with
    currwk_booking_data
    as
    (
        SELECT
            * ,
            PARSENAME(REPLACE([Route_Number], '-','.'),2) as Route_number,
            [Price] / 11 *10 as excl_gst_price
        -- SUM([Price])
        FROM
            [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2]
        WHERE 
    [Date] 
BETWEEN '20211013' AND '20211019'
            AND [Status] = 'C'
    --     ORDER BY 
    -- [DATE],
    -- [Job_No]
    )
Select 
    -- sum(excl_gst_price)
    TOP 3 *
from 
    currwk_booking_data
where
    [Route_number] = 'BR1'
    AND
    [Status] NOT IN ('V','N','F')
    AND
    [Serv_Type] = 'COL'


order by [Date]
