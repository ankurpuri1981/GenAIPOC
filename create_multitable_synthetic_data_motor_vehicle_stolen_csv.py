import os
from sdv.multi_table import HMASynthesizer  # Hierarchical Modeling Algorithm Synthesizer
from sdv.metadata import MultiTableMetadata
from sdv.datasets.local import load_csvs
from sdv.evaluation.multi_table import run_diagnostic, evaluate_quality
from sdv.evaluation.multi_table import get_column_plot

# Read multitable data from multiple CSV files
real_data = load_csvs(
    folder_name='Motor+Vehicle+Thefts+CSV',
    read_csv_parameters={
        'skipinitialspace': True,
        # 'encoding': 'utf_32'
    })

# Create a Multitable Metadata object
metadata = MultiTableMetadata()

# # Automatically detect the metadata based on actual data
metadata.detect_from_csvs(
    folder_name='Motor+Vehicle+Thefts+CSV'
)

# Automatically detect the metadata based on actual data
metadata.detect_from_dataframes(real_data)

# Check if metadata is correct
metadata_dict = metadata.to_dict()
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

# # Visualize the metadata
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

# Saving data in csv files
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
fig = get_column_plot(
    real_data=real_data,
    synthetic_data=synthetic_data,
    metadata=metadata,
    table_name='stolen_vehicles',
    column_name='vehicle_type'
)

fig.show()
