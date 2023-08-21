import pandas as pd
from openpyxl import Workbook
from openpyxl.utils.dataframe import dataframe_to_rows
from openpyxl.styles import PatternFill

# Load the two Excel workbooks
workbook1 = pd.ExcelFile('workbook1.xlsx')
workbook2 = pd.ExcelFile('workbook2.xlsx')

# Create a new Excel workbook to store the differences with highlighting
output_workbook = Workbook()

# Define the red fill style
highlight_fill = PatternFill(start_color="FFFF0000", end_color="FFFF0000", fill_type="solid")

# Loop through the common sheet names in both workbooks
for sheet_name in set(workbook1.sheet_names) & set(workbook2.sheet_names):
    df1 = workbook1.parse(sheet_name)
    df2 = workbook2.parse(sheet_name)
    
    # Compare data and create a DataFrame with differences highlighted
    differences = df1.where(df1.ne(df2), 'DIFF')
    
    # Create a new sheet in the output workbook
    output_sheet = output_workbook.create_sheet(title=sheet_name)
    
    # Write the DataFrame to the sheet
    for row in dataframe_to_rows(differences, index=False, header=True):
        output_sheet.append(row)
    
    # Apply red fill to cells with differences
    for row in output_sheet.iter_rows(min_row=2, max_row=output_sheet.max_row, min_col=1):
        for cell in row:
            if cell.value == 'DIFF':
                cell.fill = highlight_fill

# Remove the default first sheet created by openpyxl
output_workbook.remove(output_workbook['Sheet'])

# Save the output workbook
output_workbook.save('differences_highlighted.xlsx')
