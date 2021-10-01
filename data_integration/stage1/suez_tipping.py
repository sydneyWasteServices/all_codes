import pandas as pd
import numpy as np
import glob, os
import pyodbc

# def clean_df(PATH):
#     print(PATH)
    
#     df = pd.read_csv(PATH, parse_dates=['Date', '1st Weigh', '2nd Weigh'], dtype={
#       "Job No" : np.float64,
#         'Docket' : str , 
#         'Location' : str, 
#         'Stored tare?' : str,
#         'Rego' : str, 
#         'Account code' : int, 
#         'Product Code' : int, 
#         'Product name' : str, 
#         'Gross (t)' : np.float64,
#         'Tare (t)' : np.float64, 
#         'Net (t)' : np.float64, 
#         'Amount ex gst ($)' : np.float64,
#         'Price per unit' : np.float64
#     })
#     df = df.iloc[:,1:]

#     return df
# PATH = 'C:\\Users\\User\\Desktop\\blob_storage\\tipping_suez\\Suez_All.csv' 

def clean_df(PATH):
    suez_excel = pd.read_excel(PATH, sheet_name=None, skiprows=9, parse_dates=['Date', '1st Weigh', '2nd Weigh'])

    df = pd.concat(suez_excel, ignore_index=True).dropna(subset=["Rego"])
    df = df.astype({'Date':str,'1st Weigh':str,'2nd Weigh':str})
    df['Date'] = df['Date'].str.split(' ', 1, expand=True)[0]
    df['Date'] = pd.to_datetime(df["Date"], format="%Y-%m-%d")
    df['1st Weigh'] = pd.to_datetime(df["1st Weigh"], format="%Y-%m-%d %H:%M:%S.%f")
    df['2nd Weigh'] = pd.to_datetime(df["2nd Weigh"], format="%Y-%m-%d %H:%M:%S.%f")

    return df

PATH = "C:\\Users\\User\\Desktop\\blob_storage\\suez_tipping\\*.xlsx"

df = pd.concat(
          map(
              clean_df, glob.glob(PATH)
             )
).sort_values(by="Date")


server = 'localhost'
database = 'STAGE_1_DB'
username = 'SA' 
password = 'Sydwaste123#'

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()

for index, row in df.iterrows():
    cursor.execute("INSERT INTO STAGE_1_DB.SUEZ_TIPPING_SCH_1.SUEZ_TIPPING_TB_1 \
    (Date,Docket,Location,First_Weigh,Second_Weigh,\
    IsStored_tare,Rego,Account_code,Product_code,\
    Product_name,Gross_t,Tare_t,Net_t,Amount_ex_gst,Price_per_unit) \
    values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    row.Date,
                    row["Docket"],
                    row["Location"],
                    row["1st Weigh"],
                    row["2nd Weigh"],
                    row["Stored tare?"],
                    row["Rego"],
                    row["Account code"],
                    row["Product Code"],
                    row["Product name"],
                    row["Gross (t)"],
                    row["Tare (t)"],
                    row["Net (t)"],
                    row["Amount ex gst ($)"],
                    row["Price per unit"])
cnxn.commit()
cursor.close()
cnxn.close()