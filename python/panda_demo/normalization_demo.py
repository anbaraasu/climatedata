import pandas as pd
from sklearn.preprocessing import MinMaxScaler

# -------------------------------
# Example: Normalization
# -------------------------------

# Create a sample DataFrame
data = {
    "Employee_ID": [1, 2, 3],
    "Salary": [50000, 60000, 55000],
    "Years_of_Experience": [5, 7, 6]
}
df = pd.DataFrame(data)

# Display the original DataFrame
print("Original DataFrame:")
print(df)

# Perform normalization on the numeric columns
scaler = MinMaxScaler()
df[["Salary", "Years_of_Experience"]] = scaler.fit_transform(df[["Salary", "Years_of_Experience"]])

# Display the normalized DataFrame
print("\nNormalized DataFrame:")
print(df)
