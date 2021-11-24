
SELECT MIN(DISTINCT [RouteDate]) as EarliestDate,
    MAX(DISTINCT [RouteDate]) as LATESTDATE,
    count(*)
FROM [STAGE].[ROUTE_SUMMARY_SCH_2].[ROUTE_SUMMARY_TB_2];
-- -- count(DISTINCT [Job_No

-- ====================================================================================
-- ====================================================================================
-- Extract Fuel Cost
With
    Split_Route_No
    as
    (
        SELECT
            * ,
            PARSENAME(REPLACE([RouteNumber], '-','.'),2) as Route_number
        from
            [STAGE].[ROUTE_SUMMARY_SCH_2].[ROUTE_SUMMARY_TB_2]
        WHERE
 [RouteDate] 
BETWEEN '20211013' AND '20211019'
    )
Select
    Route_number,
    sum([FuelUsed]) as Fuel_used,
    sum([FuelCost]) as Fuel_cost
from
    Split_Route_No
WHERE Route_number IN ('HOOK1', 'BR1', 'BR2', 'BR3', 'FL2', 'FLG', 'RL1', 'RL2','RL4', 'RL7', 
                        'RL9', 'RLD', 'RLE', 'RLH', 'RLI', 'RLJ', 'RLK', 'SWG', 'UOSGW', 'CMDGW', 
                        'CUMCB', 'CUMGW', 'APR', 'FLP', 'HYG', 'RED', 'RL5', 'RL6', 'RL8', 'RLP', 
                        'RLR', 'SWP', 'HOOKCB','UOSCB','CMDCB','CUMCB','NEPCB', 'CBK', 'RLC', 'RLG', 
                        'DOY','UOSCO')
GROUP BY 
    Route_number
-- ====================================================================================
-- ====================================================================================
-- ===========================================

