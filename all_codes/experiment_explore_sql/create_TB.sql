CREATE database experiment

use experiment
go

create schema insert_date
create schema WE_TIPPING_SCH_1


DROP TABLE  [experiment].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1]

SELECT count(*) FROM [experiment].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1]


CREATE TABLE [experiment].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1](
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
        Weight float, 
        UOM VARCHAR(500), 
        Docket_No VARCHAR(500),
        Gross_Weight float, 
        Tare_Weight float, 
        Branch VARCHAR(500)
)