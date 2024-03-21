# read list of climatedata from http://localhost:1111/api/v1/climate url

import requests
import json
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# read list of climatedata from http://localhost:1111/api/v1/climate url
url = "http://localhost:1111/api/v1/climate"
response = requests.get(url)
data = response.json()
df = pd.DataFrame(data)

# print the first 5 rows of the dataframe
print(df.head())

# plot the chart w.r.t temperature data and city name for the January monthdata
df = df[df['monthData'] == 'January']
plt.bar(df['city'], df['temperature'])
plt.xlabel('City')
plt.ylabel('Temperature')
plt.title('Temperature of Cities in January')
plt.xticks(rotation=90)
plt.show()

