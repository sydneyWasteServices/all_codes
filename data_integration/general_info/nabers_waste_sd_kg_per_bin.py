import pyodbc
import pandas as pd



df = pd.read_csv("C:\\Users\\User\\Desktop\\blob_storage\\EmployeeID.csv")

# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port

# fill Nan
# ============================================= 
df = df.fillna(value="null")
# ============================================= 

server = 'localhost' 
database = 'CONST_INFO'

username = 'SA' 
password = 'Sydwaste123#'

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
# Insert Dataframe into SQL Server:

for index, row in df.iterrows():
    cursor.execute("INSERT INTO CONST_INFO.EMPLOYEE_INFO.EMPLOYEE_ID \
    (Full_name,EmployeeID,Last_name, First_name, Middle_name, Note) \
    values(?,?,?,?,?,?)", row.Name, row.EmployeeID, row.lastname, row.firstname, row.middlename, row.Note)          
cnxn.commit()
cursor.close()

