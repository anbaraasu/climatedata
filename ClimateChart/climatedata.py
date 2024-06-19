# read list of climatedata from http://localhost:1111/climate/all url with exception handling
# plot a dashboard with multi-colored with temperature (float) for each city only for January month from data response

import requests
import json
import matplotlib.pyplot as plt
import numpy as np

def get_climate_data():
    """
    Retrieves climate data from http://localhost:1111/climate/all.

    Returns:
        dict: A dictionary containing climate data for each city.
    """
    try:
        response = requests.get("http://localhost:1111/climate/all")
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(e)
        return None
    
data = get_climate_data()
if data:
    cities = []
    temperatures = []
    for city in data:
        cities.append(city["city"])
        temperatures.append(city["temperature"])
    y_pos = np.arange(len(cities))
    plt.bar(y_pos, temperatures, color=['red', 'green', 'blue', 'cyan', 'magenta'])
    plt.xticks(y_pos, cities)
    plt.ylabel('Temperature')
    plt.title('Temperature of cities in January')
    plt.show()
else:
    print("No data available")


