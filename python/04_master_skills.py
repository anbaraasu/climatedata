import pandas as pd
import numpy as np

# Load data
data = pd.read_csv('data.csv')

# Data cleaning
data.fillna(data.mean(), inplace=True)

# Feature engineering
data['log_feature'] = np.log(data['feature'])

# Data analysis
print(data.describe())
