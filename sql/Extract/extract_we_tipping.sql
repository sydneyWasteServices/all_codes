SELECT MIN(DISTINCT [Route_Date]) as EarliestDate,
MAX(DISTINCT [Route_Date]) as LATESTDATE, count(*)
FROM 
[STAGE].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1];

SELECT MIN(DISTINCT [Route_Date]) as EarliestDate,
MAX(DISTINCT [Route_Date]) as LATESTDATE, count(*)
FROM 
[STAGE].[WE_TIPPING_SCH_2].[WE_TIPPING_TB_2];


-- =================================================================
-- Process Route number
SELECT 
* ,
PARSENAME(REPLACE([Route_No], '-','.'),2) as Route_number
FROM [STAGE].[WE_TIPPING_SCH_2].[WE_TIPPING_TB_2]
WHERE [Route_Date] BETWEEN '20211006' AND '20211012'
AND [Docket_No] IS NOT NULL
-- =================================================================
-- Poly is 160 for cardboard
-- Grima is 220 for cardboard


--  TOTAL_EXCL_SUBCON = ['HOOK1', 'BR1', 'BR2', 'BR3', 'FL2', 'FLG', 'RL1', 'RL2', 'RL4', 'RL7', 'RL9', 'RLD', 'RLE', 'RLH', 'RLI',
--                          'RLJ', 'RLK', 'SWG', 'APR', 'FLP', 'HYG', 'RED', 'RL5', 'RL6', 'RL8', 'RLP', 'RLR', 'SWP', 'HOOKCB', 'CBK', 'RLC', 'RLG', 'DOY']
                         
--     GENERAL_WASTE = ['HOOK1', 'BR1', 'BR2', 'BR3', 'FL2', 'FLG', 'RL1', 'RL2',
--                      'RL4', 'RL7', 'RL9', 'RLD', 'RLE', 'RLH', 'RLI', 'RLJ', 'RLK', 'SWG']
--     CARDBOARD = ['APR', 'FLP', 'HYG', 'RED', 'RL5',
--                  'RL6', 'RL8', 'RLP', 'RLR', 'SWP', 'HOOKCB']
--     COMINGLE = ['CBK', 'RLC', 'RLG', 'DOY']
--     SUBCONTRACTED = ['SUB', 'JJT', 'ALLMED', 'BIN', 'CKG', 'CLN', 'GRACE', 'JJR', 'OWE', 'REM', 'REP',
--                      'REQ', 'RRNW', 'RRR', 'SHR', 'SPD', 'SUE', 'URM', 'VEO', 'VEOACT', 'VTG', 'AUSSKIP', 'GRIMA']
--     UOS = ['UOSCB', 'UOSCO', 'UOSGW', 'CMDCB',
--            'CMDGW', 'CUMCB', 'CUMGW', 'NEPGW', 'NEPCB']

WITH Split_Route_No as (
SELECT 
* ,
PARSENAME(REPLACE([Route_No], '-','.'),2) as Route_number
FROM [STAGE].[WE_TIPPING_SCH_2].[WE_TIPPING_TB_2]
WHERE [Route_Date] 
    BETWEEN '20211020' AND '20211026'
AND [Docket_No] IS NOT NULL)
Select *,
CASE 
    WHEN Route_number IN ('HOOK1', 'BR1', 'BR2', 'BR3', 'FL2', 'FLG', 'RL1', 'RL2','RL4', 'RL7', 'RL9', 'RLD', 'RLE', 'RLH', 'RLI', 'RLJ', 'RLK', 'SWG', 'UOSGW', 'CMDGW', 'CUMCB', 'CUMGW') THEN ([Gross_Weight] - [Tare_Weight]) * 267.22 
END as General_waste_cost,
CASE 
    WHEN Route_number IN ('APR', 'FLP', 'HYG', 'RED', 'RL5', 'RL6', 'RL8', 'RLP', 'RLR', 'SWP', 'HOOKCB','UOSCB','CMDCB','CUMCB','NEPCB') AND [Tip_Site] LIKE '%grima%' THEN ([Gross_Weight] - [Tare_Weight]) * 220 
END as Cardboard_Grima_rebate,
CASE 
    WHEN Route_number IN ('APR', 'FLP', 'HYG', 'RED', 'RL5', 'RL6', 'RL8', 'RLP', 'RLR', 'SWP', 'HOOKCB','UOSCB','CMDCB','CUMCB','NEPCB') AND [Tip_Site] LIKE '%poly%' THEN ([Gross_Weight] - [Tare_Weight]) * 160
END as Cardboard_Poly_rebate,
CASE 
    WHEN Route_number IN ('CBK', 'RLC', 'RLG', 'DOY','UOSCO')  THEN ([Gross_Weight] - [Tare_Weight]) * 190
END as Comingle_cost,
[Gross_Weight] - [Tare_Weight] as net_t
FROM 
    Split_Route_No
ORDER BY 
    [Route_Date],
    [Route_number]

-- POLYTRADE
-- '20211006' '20211012'
-- '20211013' '20211019'
-- '20211020' '20211026'


-- =======================================================
-- Explore / Experiment
SELECT 
* ,
PARSENAME(REPLACE([Route_No], '-','.'),2) as Route_number
FROM [STAGE].[WE_TIPPING_SCH_2].[WE_TIPPING_TB_2]
WHERE [Route_Date] BETWEEN '20210901' AND '20211012'
AND [Docket_No] IS NOT NULL
AND [Tip_Site] LIKE '%grima%'

ORDER BY 
[Tip_Site]