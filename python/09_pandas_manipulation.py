import pandas as pd

# Load data
data = pd.read_csv('data.csv')

# Data manipulation
data['new_feature'] = data['feature1'] + data['feature2']
data_grouped = data.groupby('category').mean()

print(data_grouped)
