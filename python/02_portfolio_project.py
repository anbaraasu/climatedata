import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load data
data = pd.read_csv('real_world_data.csv')

# Data exploration
print(data.head())
print(data.describe())

# Data visualization
sns.pairplot(data)
plt.show()

# Data analysis
correlation = data.corr()
sns.heatmap(correlation, annot=True)
plt.show()
