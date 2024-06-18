# read list of climatedata from http://localhost:1111/api/climate url with exception handling
# plot a multi colored dashboard with temperature (float) for each city only for January month from data response

import requests
import matplotlib.pyplot as plt
import itertools

def get_climate_data():
    try:
        response = requests.get("http://localhost:1111/api/climate")
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print("Error: ", e)
        return None

def plot_climate_data(data):
    if data is None:
        return
    colors = itertools.cycle(["blue", "green", "red", "yellow", "orange"])  # Create an iterator of colors
    for city in data:
        if city["monthData"] == "January":
            color = next(colors)  # Get the next color from the iterator
            plt.bar(city["city"], city["temperature"], color=color)
    plt.xlabel("City")
    plt.ylabel("Temperature")
    plt.title("Climate Data")
    plt.show()

data = get_climate_data()
plot_climate_data(data)

