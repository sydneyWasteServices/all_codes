import pyodbc
import pandas as pd

df = pd.read_csv("C:\\Users\\User\\Desktop\\blob_storage\\EmployeeID.csv")

# fill Nan
# ============================================= 
df = df.fillna(0)
# ============================================= 

server = 'localhost' 
database = 'INFO'

username = 'SA' 
password = 'Sydwaste123#'


cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
# Insert Dataframe into SQL Server:

for index, row in df.iterrows():
    
    cursor.execute("INSERT INTO [INFO].[EMPLOYEE_INFO].[EMPLOYEE_ID] \
    (Full_name,Employee_id,Last_name, First_name, Middle_name, Note) \
    values(?,?,?,?,?,?)", row.Name, row.EmployeeID, row.lastname, row.firstname, row.middlename, row.Note)          

cnxn.commit()
cursor.close()
cnxn.close()
