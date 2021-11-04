import pandas as pd
import numpy as np
import pyodbc


# def clean_df(PATH):
#     print(PATH)
    
#     df = pd.read_csv(PATH, dtype={
#       "Job No" : np.float64,
#       "Schd Time End" : str, 
#       "Schd Time Start": str, 
#       "Customer Name" : str,
#       "Site Name" : str,
#       "Address 1" : str,
#       "Address 1" : str,
#       "City" : str,
#       "State" : str,
#       "Zone" : str,
#       "Phone" : str,
#       "Serv Type" : str,   
#       "Container Type" : str,
#       "Status" : str,
#       "Truck number" : str,
#       "Route number" : str,
#       "Initial Entry Date" : str,
#       "Prorated Weight" : float,
#       "Booking Reference 1" : str,
#      "Booking Reference 2" : str,
#       "Alternate Ref No 1" : str,
#      "Alternate Ref No 2" : str,
#      "Alternate Service Ref 1" : str,
#      "Alternate Service Ref 2" : str,
#      "Directions" : str,
#      "Waste Type" : str,
#      "Price" : float,
#       "PO": str, 
#       "Notes": str, 
#       "Tip Site": str})

#     df = df.fillna(value=0)
#     # df.Date = pd.to_datetime(df.Date, format="%Y-%m-%d")
#     df.Date = pd.to_datetime(df.Date, format="%d/%m/%y")

#     df['Customer number'] = df['Customer number'].round(3)
#     df['Schd Time End'] = df['Schd Time Start'].astype(str)
#     df['Schd Time End'] = df['Schd Time End'].astype(str)
#     df["Branch"] = df["Branch"].astype(str)
    
#     df["PostCode"] = df["PostCode"].astype(int)
#     df.Notes = df.Notes.astype(str)
#     df.Directions = df.Directions.astype(str)
#     return df


PATH = "C:\\Users\\User\\Desktop\\blob_storage\\fuel_we\\RouteSummariesDetail_011121_31372220.xlsx"

df = pd.read_excel(PATH).fillna(0).dropna(subset=["RouteDate"]) 
df.RouteDate = pd.to_datetime(df.RouteDate, format="%d/%m/%y")

server = 'localhost' 
database = 'STAGE'

username = 'SA' 
password = 'Sydwaste123#'

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()

for index, row in df.iterrows():
    print(index)
    cursor.execute("INSERT INTO STAGE.ROUTE_SUMMARY_SCH_2.ROUTE_SUMMARY_TB_2 \
    (RouteNumber,RouteDate,RouteDescription,TruckNumber,Driver,StartTime,\
    EndTime,NormalLabourHrs,OverTimeLabourHrs,LabourCostOverTime2,\
    OdometerStart,OdometerFinish,ContainerScheduled,ContainerServiced,MetricTons,CubicMetres,TipsVisited,\
    FuelUsed,HourMeterStart,HourMeterFinish,HourMeterTotal,TotalBookings,\
    BookingsCompleted,BookingsFailed,TruckCostHr,LabourCostNormal,\
    LabourCostOverTime,TipCost,FuelCost,TipCharges,BookingCharges,\
    AdditionalCharges,TotalRevenue,GrossMarigin,Distance,TotalCost,Branch,ServCode) \
    values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", 
                    row["RouteNumber"],
                    row.RouteDate,
                    row["RouteDescription"],
                    row["TruckNumber"],
                    row["Driver"],
                    row["StartTime"],
                    row["EndTime"],
                    row["NormalLabourHrs"],
                    row["OverTimeLabourHrs"],
                    row["LabourCostOverTime2"],
                    row["OdometerStart"],
                    row["OdometerFinish"],
                    row["ContainerScheduled"],
                    row.ContainerServiced,
                    row.MetricTons,
                    row.CubicMetres,
                    row["TipsVisited"],
                    row["FuelUsed"],
                    row["HourMeterStart"],
                    row["HourMeterFinish"],
                    row["HourMeterTotal"],
                    row.TotalBookings,
                    row["BookingsCompleted"],
                    row["BookingsFailed"],
                    row["TruckCostHr"],
                    row.LabourCostNormal,
                    row["LabourCostOverTime"],
                    row["TipCost"],
                    row["FuelCost"],
                    row["TipCharges"],
                    row["BookingCharges"],
                    row["AdditionalCharges"],
                    row["TotalRevenue"],
                    row["GrossMarigin"],
                    row["Distance"],
                    row["TotalCost"],
                    row["Branch"],
                    row.ServCode)  
cnxn.commit()
cursor.close()
cnxn.close()