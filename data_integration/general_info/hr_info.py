import pyodbc
import pandas as pd
# insert data from csv file into dataframe.
# working directory for csv file: type "pwd" in Azure Data Studio or Linux
# working directory in Windows c:\users\username

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





server = 'localhost' 
database = 'STAGE_1_DB'

username = 'SA' 
password = 'Sydwaste123#'

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()
# Insert Dataframe into SQL Server:
# 38

for index, row in df.iterrows():
    cursor.execute("INSERT INTO STAGE_1_DB.BOOKING_SCH_1.BOOKING_TB_1 \
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