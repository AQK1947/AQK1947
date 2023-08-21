import os
import pandas as pd

directory = '/path/to/excel/files'
for filename in os.listdir(directory):
    if filename.endswith(".xlsx") or filename.endswith(".xls"):
        full_path = os.path.join(directory, filename)
        df = pd.read_excel(full_path)
        # Process the DataFrame 'df' here




import os
from openpyxl import load_workbook

directory = '/path/to/excel/files'
for filename in os.listdir(directory):
    if filename.endswith(".xlsx") or filename.endswith(".xls"):
        full_path = os.path.join(directory, filename)
        workbook = load_workbook(filename=full_path)
        # Process the workbook 'workbook' here



    for sheet_name in workbook1.sheet_names:
    if sheet_name in workbook2.sheet_names:
        df1 = workbook1.parse(sheet_name)
        df2 = workbook2.parse(sheet_name)
