import pandas as pd

# -------------------------------
# Example 1: Creating a Series
# -------------------------------
# A Series is a one-dimensional labeled array capable of holding any data type.
# Create a Series from a list
series_example = pd.Series([10, 20, 30, 40, 50], name="Sample Series")
print("Series Example:")
print(series_example)

# -------------------------------
# Example 2: Creating a DataFrame
# -------------------------------
# A DataFrame is a two-dimensional labeled data structure with columns of potentially different types.
# Create a DataFrame from a dictionary
data = {
    "Name": ["Alice", "Bob", "Charlie", "David"],
    "Age": [25, 30, 35, 40],
    "City": ["New York", "Los Angeles", "Chicago", "Houston"]
}
dataframe_example = pd.DataFrame(data)
print("\nDataFrame Example:")
print(dataframe_example)

# -------------------------------
# Example 3: Creating a DataFrame from a Dictionary of Series
# -------------------------------
# Combine multiple Series into a DataFrame
names = pd.Series(["Alice", "Bob", "Charlie", "David"], name="Name")
ages = pd.Series([25, 30, 35, 40], name="Age")
cities = pd.Series(["New York", "Los Angeles", "Chicago", "Houston"], name="City")

dictionary_of_series = {
    "Name": names,
    "Age": ages,
    "City": cities
}
dataframe_from_series = pd.DataFrame(dictionary_of_series)
print("\nDataFrame from Dictionary of Series:")
print(dataframe_from_series)

# -------------------------------
# Example 4: Creating a DataFrame from a List of Dictionaries
# -------------------------------
# Each dictionary represents a row in the DataFrame
list_of_dicts = [
    {"Name": "Alice", "Age": 25, "City": "New York"},
    {"Name": "Bob", "Age": 30, "City": "Los Angeles"},
    {"Name": "Charlie", "Age": 35, "City": "Chicago"},
    {"Name": "David", "Age": 40, "City": "Houston"}
]
dataframe_from_dicts = pd.DataFrame(list_of_dicts)
print("\nDataFrame from List of Dictionaries:")
print(dataframe_from_dicts)

# -------------------------------
# Example 5: Accessing Data
# -------------------------------
# Accessing a column
print("\nAccessing the 'Name' column:")
print(dataframe_example["Name"])

# Accessing a row by index
print("\nAccessing the first row:")
print(dataframe_example.iloc[0])

# Accessing a specific value
print("\nAccessing the value at row 1, column 'City':")
print(dataframe_example.loc[1, "City"])

# -------------------------------
# Example 6: Finding Missing Values
# -------------------------------
# Create a DataFrame with missing values
data_with_missing_values = {
    "Name": ["Alice", "Bob", None, "David"],
    "Age": [25, None, 35, 40],
    "City": ["New York", "Los Angeles", "Chicago", None]
}
df_with_missing = pd.DataFrame(data_with_missing_values)

# Display the DataFrame with missing values
print("\nDataFrame with Missing Values:")
print(df_with_missing)

# Check for missing values
print("\nMissing Values Check:")
print(df_with_missing.isnull())

# Count missing values in each column
print("\nCount of Missing Values in Each Column:")
print(df_with_missing.isnull().sum())

# -------------------------------
# Example 7: Using the describe() Method
# -------------------------------
# The describe() method provides a summary of statistics for numeric columns in the DataFrame
print("\nSummary Statistics for DataFrame Example:")
print(dataframe_example.describe())

# -------------------------------
# Example 8: Using fillna with Forward and Backward Fill
# -------------------------------
# Create a DataFrame with missing values
data_with_missing_values = {
    "Name": ["Alice", "Bob", None, "David"],
    "Age": [25, None, 35, None],
    "City": ["New York", None, "Chicago", "Houston"]
}
df_with_missing = pd.DataFrame(data_with_missing_values)

# Display the original DataFrame
print("\nOriginal DataFrame with Missing Values:")
print(df_with_missing)

# Forward fill missing values
df_forward_filled = df_with_missing.fillna(method='ffill')
print("\nDataFrame after Forward Fill:")
print(df_forward_filled)

# Backward fill missing values
df_backward_filled = df_with_missing.fillna(method='bfill')
print("\nDataFrame after Backward Fill:")
print(df_backward_filled)