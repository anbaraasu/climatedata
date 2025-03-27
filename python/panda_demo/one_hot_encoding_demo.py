import pandas as pd

# -------------------------------
# Example: One-Hot Encoding
# -------------------------------

# Create a sample DataFrame
data = {
    "Employee_ID": [1, 2, 3],
    "Department": ["HR", "IT", "Finance"]
}
df = pd.DataFrame(data)

# Display the original DataFrame
print("Original DataFrame:")
print(df)

# Perform one-hot encoding on the 'Department' column
one_hot_encoded_df = pd.get_dummies(df, columns=["Department"], prefix="Dept")

# Display the one-hot encoded DataFrame
print("\nOne-Hot Encoded DataFrame:")
print(one_hot_encoded_df)
