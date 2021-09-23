import pandas as pd
import numpy as np
import os
from sqlalchemy import (Numeric, create_engine, Table, Column, 
                        Integer, String, MetaData, Float, Date, 
                        Time, SmallInteger, Text, DateTime)

# Suez From 31 12 2020 
# To 22 4 2021

def insert_records(path):
    print(path)

    df = pd.read_csv(path)

    # df['1st Weigh'] = df['1st Weigh'].str.rsplit(':', 1, expand=True)
    # df['2nd Weigh'] = df['2nd Weigh'].str.rsplit(':', 1, expand=True)

    # df['Date'] = pd.to_datetime(df['Date'], format="%d/%m/%Y")


    # df['1st Weigh'] = pd.to_datetime(df['1st Weigh'], format="%Y-%m-%d %H:%M")
    # df['2nd Weigh'] = pd.to_datetime(df['2nd Weigh'], format="%Y-%m-%d %H:%M")
    
    df.rename(columns={'1st Weigh' : '1st_Weigh_Datetime', '2nd Weigh' : '2nd_Weigh_Datetime'})

    db = "STAGE_1_DB"
    sch = "SUEZ_TIPPING_SCH_S1"
    tablename = "SUEZ_TIPPING_TB_S1"
    
    status = "append"
    
    user = "SA"
    pwd = "Sydwaste123#"

    
    server = "localhost"
    driver = "ODBC+Driver+17+for+SQL+Server"

    engine_str = f"mssql+pyodbc://{user}:{pwd}@{server}/{db}?driver={driver}"
    engine = create_engine(engine_str)
    
    # try:
    df.to_sql(name=tablename, con=engine, schema=sch, if_exists=status, dtype={
        'Date' : Date(),
        'Docket' : String(length=800),
        'Location' : String(length=800),
        '1st_Weigh_Datetime' : String(length=800),
        '2nd_Weigh_Datetime' : String(length=800),
        'Stored tare?' : String(length=10),
        'Rego' : String(length=50),
        'Account code' : Float(),
        'Product Code' : Float(),
        'Product name' : String(length=800),
        'Gross (t)' : Float(precision=3),
        'Tare (t)' : Float(precision=3),
        'Net (t)' : Float(precision=3),
        'Amount ex gst ($)' : Float(precision=3),
        'Price per unit' : Float(precision=3)
    })

    # except Exception:
    #         print(Exception)

            

PATH = "/media/sf_BLOB_STORAGE/suez_Veolia_Ton_Report/suez_csv/all.csv"

insert_records(PATH)

