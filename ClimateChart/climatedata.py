# read list of climatedata from http://localhost:1111/api/v1/climatedata url with exception handling
#plot the chart with temperature for each city only for January month from data response
#exception handling for invalid data

import requests
import matplotlib.pyplot as plt
import json

try:
    response = requests.get("http://localhost:1111/api/v1/climatedata")
    data = response.json()
    print(data)
    cities = []
    temperatures = []
    for city in data:
        cities.append(city['city'])
        temperatures.append(city['temperature'])
    plt.bar(cities, temperatures)
    plt.xlabel('Cities')
    plt.ylabel('Temperature')
    plt.title('Temperature in cities for January')
    plt.show()
except json.JSONDecodeError:
    print("Error: Invalid JSON data.")
except requests.exceptions.RequestException as e:
    print("Error: Cannot connect to server. Please check your internet connection.")
