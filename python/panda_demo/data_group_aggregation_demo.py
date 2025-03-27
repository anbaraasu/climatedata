import pandas as pd

# -------------------------------
# Example: Grouping and Aggregating Data
# -------------------------------
# Create a sample DataFrame
data = {
    "Department": ["HR", "IT", "HR", "IT", "Finance", "Finance", "HR"],
    "Employee": ["Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace"],
    "Salary": [50000, 60000, 55000, 70000, 65000, 62000, 52000],
    "Years_of_Experience": [5, 7, 6, 8, 10, 9, 4]
}
df = pd.DataFrame(data)

# Display the original DataFrame
print("Original DataFrame:")
print(df)

# Group by 'Department' and calculate the mean salary and mean years of experience
grouped = df.groupby("Department").agg({
    "Salary": "mean",
    "Years_of_Experience": "mean"
})

# Rename the columns for clarity
grouped.rename(columns={"Salary": "Average_Salary", "Years_of_Experience": "Average_Experience"}, inplace=True)

# Display the grouped and aggregated data
print("\nGrouped and Aggregated Data:")
print(grouped)
