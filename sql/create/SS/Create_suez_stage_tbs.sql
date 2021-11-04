USE STAGE
GO

CREATE SCHEMA SUEZ_TIPPING_SCH_1;

CREATE TABLE [SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1](
    ID int IDENTITY(1,1),
    Date date,
    Docket varchar(1000),
    Location varchar(1000),
    First_Weigh datetime2,
    Second_Weigh datetime2,
    IsStored_tare char,
    Rego varchar(500), 
    Account_code int,
    Product_code int,
    Product_name VARCHAR(700),
    Gross_t float,
    Tare_t float,
    Net_t float,
    Amount_ex_gst money,
    Price_per_unit money
)

SELECT * FROM [STAGE_1_DB].[SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1]



SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE_1_DB].[SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1]


-- SELECT MIN(DISTINCT [Date]) as EarliestDate,
-- MAX(DISTINCT [Date]) as LATESTDATE, count(*)
-- FROM [STAGE_2_DB].[BOOKING_SCH_S2].[BOOKING_TB_S2]