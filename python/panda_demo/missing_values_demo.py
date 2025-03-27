import pandas as pd

# -------------------------------
# Example 6: Finding Missing Values
# -------------------------------
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
# Example 8: Using fillna with Forward and Backward Fill
# -------------------------------
# Forward fill missing values
df_forward_filled = df_with_missing.fillna(method='ffill')
print("\nDataFrame after Forward Fill:")
print(df_forward_filled)

# Backward fill missing values
df_backward_filled = df_with_missing.fillna(method='bfill')
print("\nDataFrame after Backward Fill:")
print(df_backward_filled)
