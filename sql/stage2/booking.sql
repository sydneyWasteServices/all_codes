CREATE DATABASE STAGE_2_DB 

-- use 
-- GO


CREATE TABLE [BOOKING_SCH_2].[BOOKING_TB_2](
    ID int IDENTITY(1,1),
    Job_No float,
    Date date,
    Schd_Time_Start varchar(500), 
    Schd_Time_End varchar(500),
    Lat Decimal(9,6),
    Lng Decimal(8,6),
    Customer_Number float,
    Customer_Name varchar(2000),
    Branch varchar(800),
    Site_Name varchar(2000),
    Address_1 varchar(2000),
    Address_2 varchar(2000),
    Zone varchar(800),
    City varchar(500),
    State varchar(300),
    PostCode int,
    Phone varchar(400),
    Phone_2 varchar(400),
    Qty_Scheduled int,
    Qty_Serviced int,
    Serv_Type varchar(100),
    Container_type varchar(200),
    Booking_Reference_1 varchar(1000),
    Booking_Reference_2 varchar(1000),
    Alternate_Ref_No_1 varchar(1000),	
    Alternate_Ref_No_2 varchar(1000),
    Alternate_Service_Ref_1 varchar(1000),	
    Alternate_Service_Ref_2 varchar(1000),
    Bin_Volume float,
    Status char,
    Truck_Number varchar(50),
    Route_Number varchar(50),
    Initial_Entry_Date varchar(2000),
    Weight int,
    Prorated_Weight_Kg float,
    Notes text, 
    Directions text,
    Waste_Type varchar(300),
    Price money,
    PO VARCHAR(400)
);



SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM  [STAGE_1_DB].[BOOKING_SCH_1].[BOOKING_TB_1] 


SELECT TOP 3 * FROM  [STAGE_1_DB].[BOOKING_SCH_1].[BOOKING_TB_1] 


WITH DistinctJobs AS
(
    SELECT * ,
        ROW_NUMBER() OVER(
            PARTITION BY [Job_No] ORDER BY [Job_No]) AS 'RowNum' 
    FROM [STAGE_1_DB].[BOOKING_SCH_1].[BOOKING_TB_1] 
    -- WHERE [Date] BETWEEN '20210421' AND '20210504'
)
SELECT * INTO #TmpTB
FROM DistinctJobs
WHERE RowNum = 1

ALTER TABLE #TmpTB
DROP COLUMN [RowNum], [ID]

INSERT INTO [STAGE_2_DB].[BOOKING_SCH_2].[BOOKING_TB_2]
SELECT * FROM #TmpTB
DROP TABLE #TmpTB


 



WITH DistinctJobs AS
(
    SELECT * ,
        ROW_NUMBER() OVER(
            PARTITION BY [Job No] ORDER BY [Job No]) AS 'RowNum' 
    FROM [STAGE_1_DB].[BOOKING_SCH_S1].[BOOKING_TB_S1]
    WHERE [Date] >= '20210324'
    AND [Date] <= '20210406'
)
SELECT * INTO #TmpTB
FROM DistinctJobs
WHERE RowNum = 1

-- Check and Audit Data in #TmpTB
SELECT count(Distinct [Job No]) FROM #TmpTB


