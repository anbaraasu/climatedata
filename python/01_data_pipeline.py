import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Load data
data = pd.read_csv('data.csv')

# Data cleaning
data.dropna(inplace=True)

# Feature engineering
data['new_feature'] = data['feature1'] * data['feature2']

# Data visualization
plt.figure(figsize=(10, 6))
plt.scatter(data['feature1'], data['new_feature'])
plt.xlabel('Feature 1')
plt.ylabel('New Feature')
plt.title('Feature 1 vs New Feature')
plt.show()

# Data analysis
correlation = data.corr()
print(correlation)
