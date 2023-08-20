import csv
import pandas as pd

def compare_csv(file1_path, file2_path):
    differences = []

    with open(file1_path, 'r') as file1, open(file2_path, 'r') as file2:
        csv_reader1 = csv.reader(file1)
        csv_reader2 = csv.reader(file2)

        for row_num, (row1, row2) in enumerate(zip(csv_reader1, csv_reader2), start=1):
            if row1 != row2:
                differences.append(f"Row {row_num}:\nFile 1: {row1}\nFile 2: {row2}\n")

    return differences

file1_path = 'file1.csv'
file2_path = 'file2.csv'

differences = compare_csv(file1_path, file2_path)

if differences:
    for diff in differences:
        print(diff)
else:
    print("CSV files are identical.")

# Save the comparison results to an Excel sheet
output_workbook = pd.ExcelWriter('comparison_results.xlsx', engine='xlsxwriter')
df = pd.DataFrame({'Differences': differences})
df.to_excel(output_workbook, sheet_name='Comparison Results', index=False)
output_workbook.save()
