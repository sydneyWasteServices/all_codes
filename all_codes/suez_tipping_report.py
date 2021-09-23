# Suez Data parse
import pandas as pd
import numpy as np
import os
import glob


def cleanning_report_format(df : object):

        # If the Rego is Nan Then it will select until that point
        df = df[~df.Rego.isnull()]
        # Convert 3 Date Column to string
        # split the excess part  
        df = df.astype({'Date':str,'1st Weigh':str,'2nd Weigh':str})
        df['Date'] = df['Date'].str.split(' ', 1, expand=True) 
        df['1st Weigh'] = df['1st Weigh'].str.split('.', 1, expand=True) 
        df['2nd Weigh'] = df['2nd Weigh'].str.split('.', 1, expand=True) 

        # Convert Date to Date time
        df['Date'] = pd.to_datetime(df["Date"], format="%Y-%m-%d")
        df['1st Weigh'] = pd.to_datetime(df["1st Weigh"], format="%Y-%m-%d %X")
        df['2nd Weigh'] = pd.to_datetime(df["2nd Weigh"], format="%Y-%m-%d %X")

        current_date = df.iloc[0].Date.date()
        location = df.iloc[0].Location.replace(" ","")
        
        df.to_csv(f'/media/sf_BLOB_STORAGE/suez_Veolia_Ton_Report/suez_csv/{current_date}_{location}.csv', index=False)


def read_all_files(path : str):

    try:
        df_objs = pd.read_excel(path, sheet_name=None, skiprows=9)
        all_sheets_name = list(df_objs.keys())
        [cleanning_report_format(df_objs[sheet_name]) for sheet_name in all_sheets_name]

    except:
        print(path)

PATH = "/media/sf_BLOB_STORAGE/suez_Veolia_Ton_Report/og_suez_reports"

for filename in os.listdir(PATH):

    if filename.endswith(".xlsx"):

        path_1 = f"{PATH}/{filename}"
        read_all_files(path_1)


PATH = '/media/sf_BLOB_STORAGE/suez_Veolia_Ton_Report/suez_csv/*.csv'
COMPLETE_PATH = '/media/sf_BLOB_STORAGE/suez_Veolia_Ton_Report/suez_csv/all.csv'

df = pd.concat(map(pd.read_csv, glob.glob(PATH)))


df.to_csv(COMPLETE_PATH, index=False) 



# os.listdir(path)
# os.startfile()
# os.path.abspath(path)
# os.getcwd()

#/media/sf_BLOB_STORAGE/Veolia_suez_Ton_Report/og_suez_reports/

# Customer Daily Transaction Report - Sydney Waste 5209148 800229 030121.xlsx
# Customer Daily Transaction Report - Sydney Waste 5209148 800229 100121.xlsx
# Customer Daily Transaction Report - Sydney Waste 5209148 800229 170121.xlsx
# Customer Daily Transaction Report - Sydney Waste 5209148, 800229 140221.xlsx
# Customer Daily Transaction Report - Sydney Waste 5209148, 800229 280221.xlsx
# Customer Daily Transaction Report - Sydney Waste 5209148, 800229 310121.xlsx
