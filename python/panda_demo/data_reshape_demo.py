import pandas as pd

# -------------------------------
# Example: Reshaping Data
# -------------------------------

# Create a sample DataFrame
data = {
    "Employee": ["Alice", "Bob", "Charlie"],
    "Department": ["HR", "IT", "Finance"],
    "Salary_2022": [50000, 60000, 55000],
    "Salary_2023": [52000, 62000, 58000]
}
df = pd.DataFrame(data)

# Display the original DataFrame
print("Original DataFrame:")
print(df)

# Reshape the DataFrame using melt (long format)
melted = pd.melt(df, id_vars=["Employee", "Department"], 
                 var_name="Year", value_name="Salary")
print("\nMelted DataFrame (Long Format):")
print(melted)

# Reshape the melted DataFrame back to wide format using pivot
pivoted = melted.pivot(index=["Employee", "Department"], 
                       columns="Year", values="Salary").reset_index()
print("\nPivoted DataFrame (Wide Format):")
print(pivoted)
