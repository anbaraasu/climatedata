import pandas as pd
import matplotlib.pyplot as plt

# Load data
data = pd.read_csv('portfolio_data.csv')

# Data exploration
print(data.head())

# Data visualization
plt.figure(figsize=(10, 6))
plt.hist(data['value'], bins=30)
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.title('Histogram of Values')
plt.show()

# Data analysis
summary = data.describe()
print(summary)
