SELECT * FROM [STAGE_1_DB].[SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1]

SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE_1_DB].[SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1]
