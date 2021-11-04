import pandas as pd
import numpy as np
import glob
import pyodbc


def clean_df(PATH):
    
    print(PATH)
    df = pd.read_csv(PATH, dtype={
      "Job No" : np.float64,
      "Schd Time End" : str, 
      "Schd Time Start": str, 
      "Customer Name" : str,
      "Site Name" : str,
      "Address 1" : str,
      "Address 1" : str,
      "City" : str,
      "State" : str,
      "Zone" : str,
      "Phone" : str,
      "Serv Type" : str,   
      "Container Type" : str,
      "Status" : str,
      "Truck number" : str,
      "Route number" : str,
      "Initial Entry Date" : str,
      "Prorated Weight" : float,
      "Booking Reference 1" : str,
     "Booking Reference 2" : str,
      "Alternate Ref No 1" : str,
     "Alternate Ref No 2" : str,
     "Alternate Service Ref 1" : str,
     "Alternate Service Ref 2" : str,
     "Directions" : str,
     "Waste Type" : str,
     "Price" : float,
      "PO": str, 
      "Notes": str, 
      "Tip Site": str})

    df = df.fillna(value=0)
    df.Date = pd.to_datetime(df.Date, format="%Y-%m-%d")
    # df.Date = pd.to_datetime(df.Date, format="%d-%m-%y")

    df['Customer number'] = df['Customer number'].round(3)
    df['Schd Time End'] = df['Schd Time Start'].astype(str)
    df['Schd Time End'] = df['Schd Time End'].astype(str)
    df["Branch"] = df["Branch"].astype(str)
    
    df["PostCode"] = df["PostCode"].astype(int)
    df.Notes = df.Notes.astype(str)
    df.Directions = df.Directions.astype(str)
    return df


PATH_A = "C:\\Users\\User\\Desktop\\blob_storage\\booking\\initial_staging\\part_a\\*.csv"

for PATH in glob.glob(PATH_A):

    df = clean_df(PATH)

    server = 'localhost' 
    database = 'STAGE'

    username = 'SA' 
    password = 'Sydwaste123#'

    cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

    cursor = cnxn.cursor()

    for index, row in df.iterrows():
        cursor.execute("INSERT INTO STAGE.BOOKING_SCH_1.BOOKING_TB_1 \
        (Job_No,Date,Schd_Time_Start,Schd_Time_End,Lat,Lng,\
        Customer_Number,Customer_Name,Site_Name,Address_1,\
        Address_2,City,State,PostCode,Zone,Phone,Qty_Scheduled,\
        Qty_Serviced,Serv_Type,Container_type,Bin_Volume,Status,\
        Truck_Number,Route_Number,Initial_Entry_Date,Weight,\
        Prorated_Weight_Kg,Booking_Reference_1,Booking_Reference_2,\
        Alternate_Ref_No_1,Alternate_Ref_No_2,Alternate_Service_Ref_1,\
        Alternate_Service_Ref_2,Notes,Directions,Waste_Type,Price,PO,Branch,Phone_2) \
        values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", 
                    
                        row["Job No"],
                        row.Date,
                        row["Schd Time Start"],
                        row["Schd Time End"],
                        row["Latitude"],
                        row["Longitude"],
                        row["Customer number"],
                        row["Customer Name"],
                        row["Site Name"],
                        row["Address 1"],
                        row["Address 2"],
                        row["City"],
                        row["State"],
                        row.PostCode,
                        row.Zone,
                        row.Phone,
                        row["Qty Scheduled"],
                        row["Qty Serviced"],
                        row["Serv Type"],
                        row["Container Type"],
                        row["Bin Volume"],
                        row.Status,
                        row["Truck number"],
                        row["Route number"],
                        row["Initial Entry Date"],
                        row.Weight,
                        row["Prorated Weight"],
                        row["Booking Reference 1"],
                        row["Booking Reference 2"],
                        row["Alternate Ref No 1"],
                        row["Alternate Ref No 2"],
                        row["Alternate Service Ref 1"],
                        row["Alternate Service Ref 2"],
                        row["Notes"],
                        row["Directions"],
                        row["Waste Type"],
                        row["Price"],
                        row.PO,
                    "","")  
    cnxn.commit()
    cursor.close()
    cnxn.close()