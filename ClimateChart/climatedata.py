# read list of climatedata from http://localhost:1111/climate/all url with exception handling
# plot a dashboard with multi-colored with temperature (float) for each city only for January month from data response

import requests
import matplotlib.pyplot as plt
import numpy as np

def get_climate_data():
    try:
        response = requests.get('http://localhost:1111/climate/all')
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(e)
        return None
    
data = get_climate_data()

if data:
    cities = [city['city'] for city in data]
    temperatures = [city['temperature'] for city in data]
   # colors = np.random.rand(len(cities))
    plt.bar(cities, temperatures, color='blue')
    plt.xlabel('Cities')
    plt.ylabel('Temperature')
    plt.title('Temperature of Cities in January')
    plt.show()


