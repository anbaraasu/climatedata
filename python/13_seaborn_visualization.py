import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

# Load data
data = pd.read_csv('data.csv')

# Plot
sns.set(style="whitegrid")
plt.figure(figsize=(10, 6))
sns.boxplot(x='category', y='value', data=data)
plt.title('Boxplot of Value by Category')
plt.show()
