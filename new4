import csv
import pandas as pd
from openpyxl import Workbook
from openpyxl.styles import PatternFill

def compare_csv(file1_path, file2_path, output_path):
    differences = []

    with open(file1_path, 'r') as file1, open(file2_path, 'r') as file2:
        csv_reader1 = csv.reader(file1)
        csv_reader2 = csv.reader(file2)
        header = next(csv_reader1)

        for row_num, (row1, row2) in enumerate(zip(csv_reader1, csv_reader2), start=1):
            if row1 != row2:
                differences.append([f"Row {row_num}", *row1, *row2])

    # Create a pandas DataFrame from the differences list
    df = pd.DataFrame(differences, columns=['Row Number'] + ['File 1 ' + str(i) for i in range(len(header))] + ['File 2 ' + str(i) for i in range(len(header))])

    # Create a new Excel workbook
    output_workbook = Workbook()
    output_worksheet = output_workbook.active

    # Define the red fill style
    highlight_fill = PatternFill(start_color="FFFF0000", end_color="FFFF0000", fill_type="solid")

    # Write the DataFrame to the Excel worksheet
    for row in df.itertuples(index=False):
        output_worksheet.append(row)

    # Apply red fill to cells with differences
    for row in output_worksheet.iter_rows(min_row=2, max_row=output_worksheet.max_row, min_col=len(header) + 2):
        for cell in row:
            if cell.value != '':
                cell.fill = highlight_fill

    # Save the Excel workbook
    output_workbook.save(output_path + '.xlsx')

    # Save the DataFrame as a CSV file with the original header
    df.to_csv(output_path + '.csv', index=False, header=header)

file1_path = 'file1.csv'
file2_path = 'file2.csv'
output_path = 'comparison_results'

compare_csv(file1_path, file2_path, output_path)
print(f"Comparison results saved to {output_path}.xlsx and {output_path}.csv")
