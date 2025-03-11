import pandas as pd
import matplotlib.pyplot as plt

# Load your own data
data = pd.read_csv('data.csv')

# Data exploration
print(data.info())
print(data.describe())

# Data visualization
data.hist(figsize=(10, 8))
plt.show()

# Data analysis
correlation = data.corr()
print(correlation)
