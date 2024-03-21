import os

import pandas as pd
from sdv.multi_table import HMASynthesizer  # Hierarchical Modeling Algorithm Synthesizer
from sdv.metadata import MultiTableMetadata
from sdv.datasets.local import load_csvs
from sdv.evaluation.multi_table import run_diagnostic, evaluate_quality
from sdv.evaluation.multi_table import get_column_plot
import pymysql


# Read multitable data from multiple CSV files
# real_data = load_csvs(
#     folder_name='Motor+Vehicle+Thefts+CSV',
#     read_csv_parameters={
#         'skipinitialspace': True,
#         # 'encoding': 'utf_32'
#     })


# Read input data from local SQL server database instead of csv's using pymsql library
import pyodbc

# conn_str = f'DRIVER={{ODBC SQL Server Driver}};SERVER=localhost;DATABASE=GenAI_POCDB;UID=ankurp;PWD=Yetochalega@123
# # ';TrustServerCertificate=True
conn_str = ("Driver={SQL Server};"
            "Server=AVD-PRD-SI-008;"
            "Database=GenAI_POCDB;"
            "Trusted_Connection=yes;")

conn = pyodbc.connect(conn_str)

# Get tables within the database

try:
    with conn.cursor() as cursor:
        # Read all tables within the database
        cursor.execute("select * from sys.all_objects where type_desc = 'USER_TABLE' and not name like 'trace%'")
        list_tables = cursor.fetchall()
        table_row = list_tables
        table_list = [i for i in table_row]
        final_table_list = []
        for column in table_list:
            final_table_list.append(column[0])

        real_data_dict = {}
        # Create a dataframe for each table
        for table in final_table_list:
            sql = "select * from " + str(table)
            cursor.execute(sql)
            table_columns = [column[0] for column in cursor.description]
            df_merged = pd.DataFrame()
            final_dict = {}
            for row in cursor:
                row_to_list = [elem for elem in row]
                # Crate dictionary of column and row values
                for table_column_name, row_value in zip(table_columns, row_to_list):
                    df_dict = {table_column_name: row_value}
                    final_dict.update(df_dict)

                temp_df = pd.DataFrame(final_dict, index=[0])
                df_merged = pd.concat([df_merged,temp_df], ignore_index=True)

            # Create merged dictionary of dataframes for each table
            table_dict = {table : df_merged}
            real_data_dict.update(table_dict)
        real_data = real_data_dict

finally:
    conn.close()

# Create a Multitable Metadata object
metadata = MultiTableMetadata()

# # Automatically detect the metadata based on actual data
# metadata.detect_from_csvs(
#     folder_name='Motor+Vehicle+Thefts+CSV'
# )

# Automatically detect the metadata based on actual data
metadata.detect_from_dataframes(real_data)

# Check if metadata is correct
metadata_dict = metadata.to_dict()
try:
    metadata.save_to_json('multitable_metadata_motor_vehicle_theft.json')
except ValueError:
    os.remove('multitable_metadata_motor_vehicle_theft.json')
    metadata.save_to_json('multitable_metadata_motor_vehicle_theft.json')
#
# Check for columns with unknown sdtype and fix them, this needs to be done manually based on input dataset
# Otherwise, model gives error - ValueError: invalid literal for int() with base 10:
# metadata.update_column(table_name='locations', column_name='region', sdtype='categorical')
metadata.update_column(table_name='locations', column_name='population', sdtype='numerical')
# metadata.update_column(table_name='make_details', column_name='make_name', sdtype='categorical')
# metadata.update_column(table_name='stolen_vehicles', column_name='vehicle_desc', sdtype='categorical')
# metadata.update_column(table_name='owner', column_name='name', sdtype='categorical')
# metadata.update_column(table_name='owner', column_name='address', sdtype='categorical')
#
# # Visualize the metadata
metadata.visualize(
    show_table_details='full',
    show_relationship_labels=True,
    output_filepath='multitable_metadata_motor_vehicle_theft.png'
)
#
# Validate the metadata API
metadata.validate()
#
# Train the model and generate synthetic data
#
# # Step 1: Create the synthesizer
synthesizer = HMASynthesizer(metadata)
#
synthesizer.validate(real_data)
#
# Step 2: Train the synthesizer
synthesizer.fit(real_data)
#
# # Step 3: Generate synthetic data
synthetic_data = synthesizer.sample(scale=1)
#
for table_name, synthetic_dataframe in synthetic_data.items():
    print("Saving data in csv file for: " + str(table_name))
    synthetic_dataframe.to_csv(str(table_name) + "_out" + ".csv", index=False)

# 1. perform basic validity checks
print("Performing diagnostics for basic validity checks...")
diagnostic = run_diagnostic(real_data, synthetic_data, metadata)

# 2. measure the statistical similarity
print("Evaluating statistical similarity between real data and synthetic data generated...")

quality_report = evaluate_quality(real_data, synthetic_data, metadata)

# Which columns have high and low scores
quality_report.get_details('Column Shapes')
quality_report.get_details('Column Pair Trends')
quality_report.get_details('Cardinality')
quality_report.get_details('Intertable Trends')

# 3. plot the data
# fig = get_column_plot(
#     real_data=real_data,
#     synthetic_data=synthetic_data,
#     metadata=metadata,
#     table_name='stolen_vehicles',
#     column_name='vehicle_type'
# )
#
# fig.show()