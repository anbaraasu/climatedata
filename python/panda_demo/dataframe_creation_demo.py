import pandas as pd

# -------------------------------
# Example 2: Creating a DataFrame
# -------------------------------
# A DataFrame is a two-dimensional labeled data structure with columns of potentially different types.
# It is similar to a table in a relational database or a spreadsheet.

# Create a DataFrame from a dictionary
data = {
    "Name": ["Alice", "Bob", "Charlie", "David"],  # Column 1: Names
    "Age": [25, 30, 35, 40],  # Column 2: Ages
    "City": ["New York", "Los Angeles", "Chicago", "Houston"]  # Column 3: Cities
}
dataframe_example = pd.DataFrame(data)  # Convert the dictionary to a DataFrame
print("\nDataFrame Example:")
print(dataframe_example)  # Display the DataFrame

# -------------------------------
# Example 3: Creating a DataFrame from a Dictionary of Series
# -------------------------------
# Combine multiple Series into a single DataFrame

# Create individual Series
names = pd.Series(["Alice", "Bob", "Charlie", "David"], name="Name")
ages = pd.Series([25, 30, 35, 40], name="Age")
cities = pd.Series(["New York", "Los Angeles", "Chicago", "Houston"], name="City")

# Combine the Series into a dictionary
dictionary_of_series = {
    "Name": names,
    "Age": ages,
    "City": cities
}
dataframe_from_series = pd.DataFrame(dictionary_of_series)  # Convert the dictionary to a DataFrame
print("\nDataFrame from Dictionary of Series:")
print(dataframe_from_series)  # Display the DataFrame

# -------------------------------
# Example 4: Creating a DataFrame from a List of Dictionaries
# -------------------------------
# Each dictionary in the list represents a row in the DataFrame

list_of_dicts = [
    {"Name": "Alice", "Age": 25, "City": "New York"},
    {"Name": "Bob", "Age": 30, "City": "Los Angeles"},
    {"Name": "Charlie", "Age": 35, "City": "Chicago"},
    {"Name": "David", "Age": 40, "City": "Houston"}
]
dataframe_from_dicts = pd.DataFrame(list_of_dicts)  # Convert the list of dictionaries to a DataFrame
print("\nDataFrame from List of Dictionaries:")
print(dataframe_from_dicts)  # Display the DataFrame
