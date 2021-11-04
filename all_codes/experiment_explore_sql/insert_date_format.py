# https://www.youtube.com/watch?v=WWgiRkvl1Ws
import pandas as pd
import numpy as np
import xml.etree.ElementTree as et
import pyodbc

# PATH = "/home/gordon_local/local_workplace/ds/WE_Tipping.xml"

PATH = "C:\\Users\\User\\Desktop\\blob_storage\\tip_we\\tip_all.xml"

# ===================================================================================
# XML processing
# ===================================================================================
ns = "{urn:schemas-microsoft-com:office:spreadsheet}"
etree = et.parse(PATH)
eroot = etree.getroot()
rows_attr = f"{ns}Row"
data_attr = f"{ns}Data"
data = list()

for r in eroot.iter(tag=rows_attr):
    row = np.array([])

    for d in r.iter(tag=data_attr):
        row = np.append(row, d.text)

    row = np.array(row)
    data.append(row)

df = pd.DataFrame(data=data[1:], columns=data[0]).iloc[1:]
# ===================================================================================


# ==========================================================================
def clean_df(df):
    df['Route Date'] = pd.to_datetime(
        df['Route Date'], format="%Y-%m-%d", errors='coerce')
    df['Disposal Date'] = pd.to_datetime(
        df['Disposal Date'], format="%Y-%m-%d", errors='coerce')
    df['Tip In Time'] = pd.to_datetime(
        df['Tip In Time'], infer_datetime_format=True, errors='coerce')
    df['Tip Out Time'] = pd.to_datetime(
        df['Tip Out Time'], infer_datetime_format=True, errors='coerce')
    df['Tip In Time'] = df['Tip In Time'].fillna(pd.to_datetime('2021-10-20 00:00:00',infer_datetime_format=True))      
    df['Tip Out Time'] = df['Tip Out Time'].fillna(pd.to_datetime('2021-10-20 00:00:00',infer_datetime_format=True))    
    df['Tip In Time'] = df['Tip In Time'].dt.time
    df['Tip Out Time'] = df['Tip Out Time'].dt.time
    df['Tip In Time'] = pd.to_datetime(df['Tip In Time'], format='%H:%M:%S').apply(pd.Timestamp)
    df['Tip Out Time'] = pd.to_datetime(df['Tip Out Time'], format='%H:%M:%S').apply(pd.Timestamp)
    return df


df = clean_df(df)

server = 'localhost'
database = 'STAGE'
username = 'SA'
password = 'Sydwaste123#'

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server +
                      ';DATABASE='+database+';UID='+username+';PWD=' + password)

cursor = cnxn.cursor()


for index, row in df.iterrows():
    cursor.execute("INSERT INTO [STAGE].[WE_TIPPING_SCH_1].[WE_TIPPING_TB_1] \
    (Sequence_No,Booking_No,Customer_Details,Route_No,Truck_No,\
    Route_Date,Disposal_Date,Tip_Site,Tip_In_Time,\
    Tip_Out_Time, Cost_Rate, Total_Cost, Charge_Rate,\
    Total_Charge, Waste_Type, Weight, UOM, Docket_No,\
    Gross_Weight, Tare_Weight, Branch) \
    values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                   row['Sequence No'],
                   row['Booking No'],
                   row['Customer Details'],
                   row['Route No'],
                   row['Truck No'],
                   row['Route Date'],
                   row['Disposal Date'],
                   row['Tip Site'],
                   row['Tip In Time'],
                   row['Tip Out Time'],
                   row['Cost Rate'],
                   row['Total Cost'],
                   row['Charge Rate'],
                   row['Total Charge'],
                   row['Waste Type'],
                   row['Weight'],
                   row['UOM'],
                   row['Docket No'],
                   row['Gross Weight'],
                   row['Tare Weight'],
                   row['Branch']
                   )
cnxn.commit()
cursor.close()
cnxn.close()
