from sdv.multi_table import HMASynthesizer
from sdv.metadata import MultiTableMetadata
from sdv.datasets.local import load_csvs


# Read multitable data from multiple CSV files
real_data = load_csvs(
    folder_name='multitable_data',
    read_csv_parameters={
        'skipinitialspace': True,
        # 'encoding': 'utf_32'
    })

# print(real_data)
# Create a Multitable Metadata object
metadata = MultiTableMetadata()

# Automatically detect the metadata based on actual data
metadata.detect_from_csvs(
    folder_name='multitable_data'
)
# Check if metadata is correct
metadata_dict = metadata.to_dict()
# print(metadata_dict)

# Visualize the metadata
metadata.visualize(
    show_table_details='full',
    show_relationship_labels=True,
    output_filepath='my_metadata1.png'
)

# Validate the metadata API
metadata.validate()

# Train the model and generate synthetic data

# Step 1: Create the synthesizer
synthesizer = HMASynthesizer(metadata)

# Step 2: Train the synthesizer
synthesizer.fit(real_data)

# Step 3: Generate synthetic data
synthetic_data = synthesizer.sample()

synthetic_data.save('multitable_synthetic_data')