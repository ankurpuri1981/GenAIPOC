import os

from sdv.multi_table import HMASynthesizer  # Hierarchical Modeling Algorithm Synthesizer
from sdv.metadata import MultiTableMetadata
from sdv.datasets.local import load_csvs
from sdv.evaluation.multi_table import run_diagnostic, evaluate_quality
from sdv.evaluation.multi_table import get_column_plot

folder_name = "HCAHPS+Patient+Survey"
# Read multitable data from multiple CSV files
real_data = load_csvs(
    folder_name='HCAHPS+Patient+Survey',
    read_csv_parameters={
        'skipinitialspace': True,
        # 'encoding': 'utf_32'
    })

# Create a Multitable Metadata object
metadata = MultiTableMetadata()

# # Automatically detect the metadata based on actual data
metadata.detect_from_csvs(
    folder_name='HCAHPS+Patient+Survey'
)
# # Save metadata to json
metadata_dict = metadata.to_dict()
try:
    metadata.save_to_json('multitable_metadata' + str(folder_name) + '.json')
except ValueError:
    os.remove('multitable_metadata' + str(folder_name) + '.json')
    metadata.save_to_json('multitable_metadata' + str(folder_name) + '.json')


# Change sdtype for column State to 'id'
metadata.update_column(table_name='states', column_name='State', sdtype='id')
metadata.update_column(table_name='state_results', column_name='State', sdtype='id')
metadata.update_column(table_name='responses', column_name='State', sdtype='id')
metadata.add_relationship('states', 'state_results', 'State', 'State')

# Visualize the metadata
metadata.visualize(
    show_table_details='full',
    show_relationship_labels=True,
    output_filepath='my_multi_table_metadata_hcahps_patient_survey.png'
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

for table_name, synthetic_dataframe in synthetic_data.items():
    print("Saving data in csv file for: " + str(table_name))
    synthetic_dataframe.to_csv(str(table_name) + "_out" + ".csv", index=False)

# 1. perform basic validity checks
print("Performing diagnostics for basic validity checks...")
diagnostic = run_diagnostic(real_data, synthetic_data, metadata)

# 2. measure the statistical similarity
print("Evaluating statistical similarity between real data and synthetic data generated...")
evaluate_quality(real_data, synthetic_data, metadata)

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