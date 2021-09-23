import pandas as pd
import numpy as np
import os
from sqlalchemy import (Numeric, create_engine, Table, Column, 
                        Integer, String, MetaData, Float, Date, 
                        Time, SmallInteger, Text)

def insert_records(path):
    print(path)

    df = pd.read_csv(path, dtype={ 
                    "Schd Time Start" : str,
                    "PO": str,
                    "Route number" : str,
                    "Notes" : str, 
                    "Schd Time End" : str,
                    "Address 2" : str})  

  # encoding='iso8859'
    df.drop('Phone 2', inplace=True, axis=1)
    df["Date"] = pd.to_datetime(df["Date"], format='%d/%m/%y')
    df[['Route number', 'Weekday']] = df['Route number'].str.split('-', 1, expand=True)
    
    db = "STAGE_1_DB"
    sch = "BOOKING_SCH_S1"
    tablename = "BOOKING_TB_S1"
    
    status = "append"
    
    user = "SA"
    pwd = "Sydwaste123#"

    server = "localhost"
    driver = "ODBC+Driver+17+for+SQL+Server"
    engine_str = f"mssql+pyodbc://{user}:{pwd}@{server}/{db}?driver={driver}"
    engine = create_engine(engine_str)
    
    # try:

    df.to_sql(name=tablename, con=engine, schema=sch, if_exists=status, dtype={
        'Job No': Numeric(20, 5),
        'Date': Date(),
        'Schd Time Start': String(length=350),
        'Schd Time End': String(length=350),
        'Latitude': Numeric(20, 7),
        'Longitude': Numeric(20, 7),
        'Customer number': Numeric(20, 5),
        'Customer Name': String(length=800),
        'Site Name': String(length=800),
        'Address 1': String(length=1200),
        'Address 2': String(length=1200),
        'City': String(length=500),
        'State': String(length=30),
        'PostCode': Integer(),
        'Zone': String(length=500),
        'Phone': String(length=600),
        'Qty Scheduled': SmallInteger(),
        'Qty Serviced': SmallInteger(),
        'Serv Type': String(length=600),
        'Container Type': String(length=20),
        'Bin Volume': Float(precision=5),
        'Status': String(length=5),
        'Truck number': String(length=50),
        'Route number': String(length=50),
        'Generate ID': String(length=500),
        'Initial Entry Date': String(length=350),
        'Weight': Float(precision=5),
        'Prorated Weight': Float(precision=5),
        'Booking Reference 1': String(length=200),
        'Booking Reference 2': String(length=200),
        'Alternate Ref No 1': String(length=200),
        'Alternate Ref No 2': String(length=200),
        'Alternate Service Ref 1': String(length=200),
        'Alternate Service Ref 2': String(length=200),
        'Notes': Text(length=8000),
        'Directions': Text(length=8000),
        'CheckLists': String(length=300),
        'Waste Type': String(length=350),
        'Tip Site': String(length=450),
        'Price': Numeric(8, 3),
        'PO': String(length=200),
        'Weekday' : SmallInteger()
    })
        
    # except Exception:
    #         print(Exception)
    #         print(df['Job No'])
            
# 1.csv

# CDC_TEST_PATH = "./cdctest.csv"  staged/stage_booking.csv

PATH = f"/media/sf_BLOB_STORAGE/booking_weekly/Aug.csv"

insert_records(PATH)

# for filename in os.listdir(PATH):
#     if filename.endswith(".csv"):
#         path_1 = f"{PATH}/{filename}"
#         insert_records(path_1)
        

# insert_records(PATH)
# filenames = []

# nth = 9


# for filename in os.listdir(PATH):
#     if filename.endswith(".csv"):
#         filenames.append(filename)

# filenames.append("to_even")

# filenames = np.array(filenames)
# # 
# filenames_cluster = filenames.reshape((10,40))[nth]

# print(f"Nth Cluster {nth}")

# for f in filenames_cluster:
#     if f.endswith(".csv"):
#         f_PATH = f"{PATH}/{f}"
#         insert_records(f_PATH)

# 0 1 2

# issue on 239.csv
