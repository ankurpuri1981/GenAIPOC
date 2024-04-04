import os
import pyodbc
from sqlalchemy import create_engine
import pandas as pd
from sdv.multi_table import HMASynthesizer  # Hierarchical Modeling Algorithm Synthesizer
from sdv.metadata import MultiTableMetadata
from sdv.evaluation.multi_table import run_diagnostic, evaluate_quality
from sdv.evaluation.multi_table import get_column_plot


# Read input data from local SQL server database instead of csv's using pyodbc library
conn_str = ("Driver={SQL Server};"
            "Server=vewprdsi-QEHKY;"
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

        # Delete any output tables present in database, as otherwise input data will also read those output tables
        final_table_list = []
        for column in table_list:
            if '_out' in column[0]:
                pass
            else:
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
                df_merged = pd.concat([df_merged, temp_df], ignore_index=True)

            # Create merged dictionary of dataframes for each table
            table_dict = {table: df_merged}
            real_data_dict.update(table_dict)
        real_data = real_data_dict

    # Create a Multitable Metadata object
    metadata = MultiTableMetadata()

    # Automatically detect the metadata based on actual data
    metadata.detect_from_dataframes(real_data)

    # Check if metadata is correct
    metadata_dict = metadata.to_dict()
    # Save the metadata to json file, so we can verify the dtypes and other schema properties vis a vis the input
    # dataset
    try:
        metadata.save_to_json('multitable_metadata_motor_vehicle_theft.json')
    except ValueError:
        os.remove('multitable_metadata_motor_vehicle_theft.json')
        metadata.save_to_json('multitable_metadata_motor_vehicle_theft.json')

    # Check for columns with unknown sdtype and fix them, this needs to be done manually based on input dataset
    # Otherwise, model gives error - ValueError: invalid literal for int() with base 10:
    metadata.update_column(table_name='locations', column_name='region', sdtype='categorical')
    metadata.update_column(table_name='locations', column_name='population', sdtype='numerical')
    metadata.update_column(table_name='license_details', column_name='License_ID', sdtype='id')
    metadata.update_column(table_name='stolen_vehicles', column_name='License_ID', sdtype='id')
    # metadata.update_column(table_name='make_details', column_name='make_name', sdtype='categorical')
    # metadata.update_column(table_name='stolen_vehicles', column_name='vehicle_desc', sdtype='categorical')
    metadata.update_column(table_name='owner', column_name='name', sdtype='categorical')
    metadata.update_column(table_name='owner', column_name='address', sdtype='categorical')

    # Add relationship between tables manually if metadata object doesn't detect automatically
    metadata.add_relationship(parent_table_name='license_details', child_table_name='stolen_vehicles',
                              parent_primary_key='License_ID', child_foreign_key='License_ID')

    # # Visualize the metadata (Uses graphviz package in background, make sure you install Graphviz on local machine
    # and add the executable in PATH variable during installation
    metadata.visualize(
        show_table_details='full',
        show_relationship_labels=True,
        output_filepath='multitable_metadata_motor_vehicle_theft.png'
    )

    # Validate the metadata API
    metadata.validate()

    # Train the model and generate synthetic data
    # Step 1: Create the synthesizer
    synthesizer = HMASynthesizer(metadata)

    synthesizer.validate(real_data)

    # Step 2: Train the synthesizer
    synthesizer.fit(real_data)

    # Step 3: Generate synthetic data
    synthetic_data = synthesizer.sample(scale=1)

    # Saving data in the output tables in same database
    engine = create_engine('mssql+pyodbc://vewprdsi-QEHKY/GENAI_POCDB?driver=ODBC+Driver+17+for+SQL+Server')

    for table_name, synthetic_dataframe in synthetic_data.items():
        synthetic_dataframe.to_sql(table_name + str('_out'), con=engine, if_exists='replace', index=False)

finally:
    conn.close()

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
fig = get_column_plot(
    real_data=real_data,
    synthetic_data=synthetic_data,
    metadata=metadata,
    table_name='stolen_vehicles',
    column_name='vehicle_type'
)

fig.show()
