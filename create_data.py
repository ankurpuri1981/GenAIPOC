import pandas as pd
from ydata_synthetic.synthesizers.regular import RegularSynthesizer
from ydata_synthetic.synthesizers import ModelParameters, TrainParameters


data = pd.read_csv('adult.csv')


# data = fetch_data('adult')
# load the data and define the numeric and categorical features
num_cols = ['age', 'fnlwgt', 'capital.gain', 'capital.loss', 'hours.per.week']
cat_cols = ['workclass','education', 'education.num', 'marital.status', 'occupation', 'relationship', 'race', 'sex',
            'native.country', 'income']

# Train the model using pre-built CTGAN (Conditional Tabular Generative Adversarial Network) models
# specify the model and training parameters
batch_size = 500
epochs = 500+1
learning_rate = 2e-4
beta_1 = 0.5
beta_2 = 0.9

ctgan_args = ModelParameters(batch_size=batch_size,
                             lr=learning_rate,
                             betas=(beta_1, beta_2))

train_args = TrainParameters(epochs=epochs)
synth = RegularSynthesizer(modelname='ctgan', model_parameters=ctgan_args, )
synth.fit(data=data, train_arguments=train_args, num_cols=num_cols, cat_cols=cat_cols)
synth.save('synthetic_data.csv')
# synth.save('adult_ctgan_model.pkl')
#
# # Synthetic Data Generation after the model is trained
# synth = RegularSynthesizer.load('adult_ctgan_model.pkl')
synth.sample(1000)
