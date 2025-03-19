import pandas as pd
import numpy as np

# Load data
data = pd.read_csv('case_study_data.csv')

# Feature engineering
data['interaction'] = data['feature1'] * data['feature2']
data['log_feature'] = np.log(data['feature3'] + 1)

print(data.head())
