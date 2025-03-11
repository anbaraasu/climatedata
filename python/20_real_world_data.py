import pandas as pd
import matplotlib.pyplot as plt

# Load data
data = pd.read_csv('real_world_data.csv')

# Data exploration
print(data.info())
print(data.describe())

# Data visualization
plt.figure(figsize=(10, 6))
plt.plot(data['date'], data['value'])
plt.xlabel('Date')
plt.ylabel('Value')
plt.title('Real World Data Over Time')
plt.show()
