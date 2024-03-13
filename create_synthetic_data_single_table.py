import pandas as pd
from sdv.metadata import SingleTableMetadata
from sdv.single_table import CTGANSynthesizer


metadata = SingleTableMetadata()
metadata.detect_from_csv(filepath='Housing.csv')

metadata_dict = metadata.to_dict()
print(metadata_dict)

metadata.visualize(
    show_table_details='summarized',
    output_filepath='my_single_table_metadata.png'
)

# Read the real data to be used for generating synthetic data
real_data = pd.read_csv('Housing_NULL.csv')
n_rows = len(real_data)

# Modeling the data


# Step 1: Create the synthesizer
synthesizer = CTGANSynthesizer(metadata)

# Step 2: Train the synthesizer
synthesizer.fit(real_data)

# Step 3: Generate synthetic data
synthetic_data = synthesizer.sample(num_rows=n_rows+1000)

# save the generated synthetic data as a CSV
synthetic_data.to_csv('synthetic_data_NULL.csv', index=False)
