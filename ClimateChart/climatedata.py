# read list of climatedata from http://localhost:1111/api/v1/climate url with exception handling
#plot the chart with temperature for each city only for January month from data response
#exception handling for invalid data
import requests
import json
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# read list of climatedata from http://localhost:1111/api/v1/climate url with exception handling
data = []
try:
    url = "http://localhost:1111/api/v1/climate"
    response = requests.get(url)
    data = response.json()
except:
    print("Error in reading data from url")
    
    
#plot the chart with temperature for each city only for January month from data response
#exception handling for invalid data
try:
    df = pd.DataFrame(data)
    df = df[df['monthData'] == 'January']
    df = df[['city', 'temperature']]
    df.plot(x='city', y='temperature', kind='bar')
    plt.show()
except:
    print("Error in plotting chart")