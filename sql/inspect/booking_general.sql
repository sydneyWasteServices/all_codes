SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM 
[STAGE].[BOOKING_SCH_1].[BOOKING_TB_1];


SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM 
[STAGE].[BOOKING_SCH_2].[BOOKING_TB_2];



