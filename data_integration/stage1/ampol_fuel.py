import pandas as pd
import numpy as np
import glob
import pyodbc


PATH = 'C:\\Users\\User\\Desktop\\blob_storage\\fuel_ampol\\*.xls'

def clean_df(df):

    df = df[~df.Amount.str.contains('-') & ~df['Card Number'].isnull()]
    
    df.Amount = df.Amount.str.replace('$', '').astype(float)
    
    df['Amount Ex GST'] = df['Amount Ex GST'].str.replace('$', '').astype(float)

    df['Trans. Date'] = pd.to_datetime(df['Trans. Date'], format='%d/%m/%Y')

    df['Post Date'] = pd.to_datetime(df['Post Date'], format='%d/%m/%Y')

    df = df.fillna('')

    return df


df = pd.concat(map(lambda file: pd.read_html(
    file, converters={
        'Card Number' : int,
        'Trans. Ref' : int
    })[0], glob.glob(PATH)))

df = clean_df(df)

server = 'localhost'
database = 'STAGE'
username = 'SA' 
password = 'Sydwaste123#'

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()

for index, row in df.iterrows():
    print(index)

    cursor.execute("INSERT INTO [STAGE].[AMPOL_FUEL_SCH_1].[AMPOL_FUEL_TB_1] \
    (Account, Card_Number, Driver_Name, Trans_Type, Location,Trans_Ref ,Trans_Date,\
    Post_Date,Amount , Amount_Ex_GST ,Location_Name)\
    values(?,?,?,?,?,?,?,?,?,?,?)",
            row['Account'],
            row['Card Number'],
            row['Driver Name'],
            row['Trans. Type'],
            row['Location'],
            row['Trans. Ref'], 
            row['Trans. Date'],
            row['Post Date'],
            row['Amount'],
            row['Amount Ex GST'],
            row['Location Name'])

cnxn.commit()
cursor.close()
cnxn.close()
