import pandas as pd

# Load data
data = pd.read_csv('real_world_data.csv')

# Data cleaning
data.dropna(inplace=True)
data = data[data['value'] > 0]

# Data transformation
data['log_value'] = np.log(data['value'])

# Data analysis
print(data.describe())
