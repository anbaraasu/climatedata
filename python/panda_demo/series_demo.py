import pandas as pd

# -------------------------------
# Example 1: Creating a Series
# -------------------------------
# A Series is a one-dimensional labeled array capable of holding any data type.
# It is similar to a column in a spreadsheet or a database table.

# Create a Series from a list of integers
series_example = pd.Series([10, 20, 30, 40, 50], name="Sample Series")  # Assign a name to the Series
print("Series Example:")
print(series_example)  # Display the Series
