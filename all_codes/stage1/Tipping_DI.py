import pandas as pd
import numpy as np
import os
from sqlalchemy import (Numeric, create_engine, Table, Column, 
                        Integer, String, MetaData, Float, Date, 
                        Time, SmallInteger, Text)


def insert_records(path : str):
    print(path)
    df = pd.read_csv(path)

    df["Route Date"] = pd.to_datetime(df["Route Date"], format='%d-%b-%Y')
    df["Disposal Date"] = pd.to_datetime(df["Disposal Date"], format='%d-%b-%Y')


    df[['Route No', 'Weekday']] = df['Route No'].str.split('-', 1, expand=True)


    db = "STAGE_1_DB"
    sch = "TIPPING_SCH_S1"
    tablename = "TIPPING_TB_S1"
    
    status = "append"
    
    user = "SA"
    pwd = "Sydwaste123#"

    
    server = "localhost"
    driver = "ODBC+Driver+17+for+SQL+Server"
    engine_str = f"mssql+pyodbc://{user}:{pwd}@{server}/{db}?driver={driver}"
    engine = create_engine(engine_str)

    try:
        df.to_sql(name=tablename, con=engine, schema=sch, if_exists=status, dtype={
            'Sequence No' : Numeric(20, 3),
            'Booking No' : Numeric(20, 3),
            'Customer Details' : String(length=1200),
            'Route No' : String(length=50),
            'Truck No' : String(length=50),
            'Route Date' : Date(),
            'Disposal Date' : Date(),
            'Tip Site' : String(length=500),
            'Tip In Time' : String(length=500),
            'Tip Out Time' : String(length=500),
            'Cost Rate' : Numeric(15, 4),
            'Total Cost' : Numeric(17, 4),
            'Charge Rate' : Numeric(17, 4),
            'Total Charge' : Numeric(17, 4),
            'Waste Type' : String(length=50),
            'Weight' : Numeric(17, 4),
            'UOM' : String(length=50),
            'Docket No' : String(length=300),
            'Gross Weight' : Numeric(10, 4),
            'Tare Weight' : Numeric(10, 4),
            'Branch' : String(length=200),
            'Weekday' : SmallInteger()
            })

    except Exception:
        print(Exception)
        print(df['Booking No'])


PATH = "/media/sf_BLOB_STORAGE/tipping_weekly/12_13th_2021.csv"
insert_records(PATH)

# for filename in os.listdir(PATH):
#     if filename.endswith(".csv"):
#         path_1 = f"{PATH}/{filename}"
#         insert_records(path_1)
