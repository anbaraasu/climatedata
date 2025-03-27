import pandas as pd

# ...existing code to create dataframe_example...

# -------------------------------
# Example 5: Accessing Data
# -------------------------------
# Accessing data in a DataFrame using column names, row indices, and specific cell locations.

# Accessing a column by its name
print("\nAccessing the 'Name' column:")
print(dataframe_example["Name"])  # Returns a Series containing the 'Name' column

# Accessing a row by its index using iloc
print("\nAccessing the first row:")
print(dataframe_example.iloc[0])  # Returns the first row as a Series

# Accessing a specific value using loc
print("\nAccessing the value at row 1, column 'City':")
print(dataframe_example.loc[1, "City"])  # Returns the value at row index 1 and column 'City'
