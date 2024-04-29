# read list of climatedata from http://localhost:1111/api/v1/climate url with exception handling
#plot the chart with temperature for each city only for January month from data response

import requests
import json
import matplotlib.pyplot as plt

def get_climate_data():
    url = "http://localhost:1111/api/v1/climate"
    try:
        response = requests.get(url)
        response.raise_for_status()
        data = response.json()
        return data
    except requests.exceptions.RequestException as e:
        print("Error: ", e)
        return None
    
def plot_climate_chart(data):
    if data is None:
        return
    for city in data:
        if city['monthData'] == 'January':
            plt.bar(city['city'], city['temperature'])
    plt.xlabel('City')
    plt.ylabel('Temperature')
    plt.title('Temperature of Cities for January')
    plt.show()

data = get_climate_data()
plot_climate_chart(data)