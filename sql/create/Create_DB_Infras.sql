CREATE DATABASE STAGE;

CREATE DATABASE INFO;

USE INFO 
GO

CREATE SCHEMA BOOKING_SCH_1;

CREATE SCHEMA EMPLOYEE;

CREATE SCHEMA BOOKING_SCH_1;

CREATE SCHEMA BOOKING_SCH_2;

CREATE DATABASE DWH_1

SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE].[SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1]


SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE].[BOOKING_SCH_1].[BOOKING_TB_1]

SELECT * FROM [INFO].[EMPLOYEE_INFO].[EMPLOYEE_ID]


USE [INFO]
GO

CREATE SCHEMA [EMPLOYEE_INFO]


CREATE TABLE [INFO].[EMPLOYEE_INFO].[EMPLOYEE_ID](
    ID int IDENTITY(1,1),
    Full_name varchar(500),
    Employee_id varchar(500),
    Last_name varchar(500),
    First_name varchar(500),
    Middle_name varchar(500),
    Note varchar(max)
)

CREATE TABLE [STAGE].[BOOKING_SCH_1].[BOOKING_TB_1](
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
    Notes varchar(MAX), 
    Directions varchar(MAX),
    Waste_Type varchar(300),
    Price money,
    PO VARCHAR(400)
)


USE STAGE
GO

CREATE SCHEMA SUEZ_TIPPING_SCH_1;

CREATE TABLE [STAGE].[SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1](
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


SELECT count(*) from [STAGE].[SUEZ_TIPPING_SCH_1].[SUEZ_TIPPING_TB_1]

SELECT count(*) FROM [STAGE].[BOOKING_SCH_1].[BOOKING_TB_1] 

SELECT MIN(DISTINCT [Date]) as EarliestDate,
MAX(DISTINCT [Date]) as LATESTDATE, count(*)
FROM [STAGE].[BOOKING_SCH_2].[BOOKING_TB_2];



-- ======================
BULK INSERT [STAGE_1_DB].[BOOKING_SCH_1].[BOOKING_TB_1]
FROM 'C:\Users\User\Desktop\blob_storage\booking\0.csv'
WITH (
    FIRSTROW = 2, -- as 1st one is header
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)
-- ======================

SELECT count(*) FROM [CONST_INFO].[EMPLOYEE_INFO].[EMPLOYEE_ID]


TRUNCATE TABLE [EMPLOYEE_INFO].[EMPLOYEE_ID]

SELECT * FROM [CONST_INFO].[EMPLOYEE_INFO].[EMPLOYEE_ID]
WHERE [NOTE] is NULL


SELECT T.name TableName,i.Rows NumberOfRows
FROM sys.tables T
JOIN sys.sysindexes I ON T.OBJECT_ID = I.ID
WHERE indid IN (0,1)
ORDER BY i.Rows DESC,T.name


SELECT TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME,
COLUMN_NAME,
DATA_TYPE,
IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS


select s.name as schema_name, 
    s.schema_id,
    u.name as schema_owner
from sys.schemas s
    inner join sys.sysusers u
        on u.uid = s.principal_id
order by s.name


SELECT TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME,
COLUMN_NAME,
DATA_TYPE,
IS_NULLABLE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE [DATA_TYPE] = 'varchar'


Select * from INFORMATION_SCHEMA.COLUMNS

SELECT 
    c.name 'Column Name',
    t.Name 'Data type',
    c.max_length 'Max Length',
    c.precision ,
    c.scale ,
    c.is_nullable,
    ISNULL(i.is_primary_key, 0) 'Primary Key'
FROM    
    sys.columns c
INNER JOIN 
    sys.types t ON c.user_type_id = t.user_type_id
LEFT OUTER JOIN 
    sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT OUTER JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
-- WHERE
--     c.object_id = OBJECT_ID('YourTableName')




Select * FROM 
'C:\Users\User\Desktop\blob_storage\booking\9.csv'
WITH 
    (
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    )
GO

SELECT * FROM
'C:\Users\User\Desktop\blob_storage\booking\9.csv'


USE STAGE
GO

CREATE SCHEMA WE_TIPPING_SCH_1;

CREATE TABLE [STAGE].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1](
        ID int IDENTITY(1,1),
        Sequence_No float, 
        Booking_No float,
        Customer_Details VARCHAR(500),
        Route_No VARCHAR(200),
        Truck_No VARCHAR(200),
        Route_Date datetime2, 
        Disposal_Date datetime2, 
        Tip_Site VARCHAR(800), 
        Tip_In_Time TIME,
        Tip_Out_Time TIME, 
        Cost_Rate float, 
        Total_Cost float, 
        Charge_Rate float,
        Total_Charge float, 
        Waste_Type VARCHAR(100), 
        UOM VARCHAR(500), 
        Weight float, 
        Docket_No VARCHAR(500),
        Gross_Weight float, 
        Tare_Weight float, 
        Branch VARCHAR(500)
)

DROP TABLE [STAGE].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1]

USE STAGE
GO

CREATE SCHEMA [ROUTE_SUMMARY_SCH_2]

CREATE TABLE [STAGE].[ROUTE_SUMMARY_SCH_2].[ROUTE_SUMMARY_TB_2](
    ID int IDENTITY(1,1),
    RouteNumber varchar(500),
    RouteDate date,
    RouteDescription varchar(500),
    TruckNumber	varchar(500),
    Driver varchar(1000),

    StartTime varchar(500),
    EndTime varchar(500),
    NormalLabourHrs float,

    OverTimeLabourHrs float,
    LabourCostOverTime2 float,
    OdometerStart float,
    OdometerFinish float,
    ContainerScheduled float,
    ContainerServiced float,

    MetricTons float,
    CubicMetres float,
    TipsVisited float,
    FuelUsed float,
    HourMeterStart float,
    HourMeterFinish float, 
    HourMeterTotal float,
    TotalBookings float,


    BookingsCompleted float,
    BookingsFailed float,
    TruckCostHr float,
    LabourCostNormal float,

    LabourCostOverTime float,
    TipCost float,
    FuelCost float,
    TipCharges float,
    BookingCharges float,
    AdditionalCharges float,
    TotalRevenue float,
    GrossMarigin float,
    Distance float,
    TotalCost float,
    Branch varchar(500),
    ServCode varchar(500)
)

USE 
    INFO
GO


CREATE TABLE [INFO].[LINKT_TOLL_INFO].[TAGID](
    ID int IDENTITY(1,1),
    tag_serial_number bigint,
    tag_class VARCHAR(100),   
    state VARCHAR(100),
    number_plate VARCHAR(100)
)


CREATE SCHEMA LINKT_TOLL_INFO 

USE 
STAGE 
go

CREATE SCHEMA [AMPOL_FUEL_SCH_1]

CREATE SCHEMA [AMPOL_FUEL_SCH_2]


CREATE TABLE [STAGE].[AMPOL_FUEL_SCH_1].[AMPOL_FUEL_TB_1](
    ID int IDENTITY(1,1),
    Account int,
    Card_Number bigint ,
    Driver_Name VARCHAR(800),
    Trans_Type VARCHAR(500), 
    Location int,
    Trans_Ref int,
    Trans_Date date,
    Post_Date date,
    Amount money,
    Amount_Ex_GST money, 
    Location_Name VARCHAR(MAX)
)


CREATE TABLE [STAGE].[AMPOL_FUEL_SCH_2].[AMPOL_FUEL_TB_2](
    ID int IDENTITY(1,1),
    Account int,
    Card_Number bigint ,
    Driver_Name VARCHAR(800),
    Trans_Type VARCHAR(500), 
    Location int,
    Trans_Ref int,
    Trans_Date date,
    Post_Date date,
    Amount money,
    Amount_Ex_GST money, 
    Location_Name VARCHAR(MAX)
)
