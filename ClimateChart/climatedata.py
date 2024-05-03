# read list of climatedata from http://localhost:1111/api/v1/climate url with exception handling
#plot the chart with temperature for each city only for January month from data response

import requests
import json
import matplotlib.pyplot as plt

def get_climate_data():
    """
    Retrieves climate data from a specified API endpoint.

    Returns:
        dict: A dictionary containing the climate data.

    Raises:
        requests.exceptions.RequestException: If there is an error making the request to the API.
    """
    try:
        response = requests.get("http://localhost:1111/api/v1/climate")
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
        return None
    
def plot_climate_chart(data):
    if data:
        for city in data:
            if city["monthData"] == "January":
                plt.bar(city["city"], city["temperature"])
        plt.xlabel("City")
        plt.ylabel("Temperature")
        plt.title("Temperature for each city for January")
        plt.show()

data = get_climate_data()

plot_climate_chart(data)