import pandas as pd

# -------------------------------
# Example: Reading and Writing JSON Files
# -------------------------------

# Create a sample DataFrame
data = {
    "Employee_ID": [1, 2, 3],
    "Name": ["Alice", "Bob", "Charlie"],
    "Department": ["HR", "IT", "Finance"],
    "Salary": [50000, 60000, 55000]
}
df = pd.DataFrame(data)

# Write the DataFrame to a JSON file
json_file_path = "data.json"
df.to_json(json_file_path, orient="records", lines=True)
print(f"Data written to JSON file: {json_file_path}")

# Read the JSON file back into a DataFrame
df_from_json = pd.read_json(json_file_path, orient="records", lines=True)
print("\nData read from JSON file:")
print(df_from_json)

# -------------------------------
# Demo: Filtering, Aggregating, Sorting
# -------------------------------

# Filtering: Select employees with Salary greater than 55000
filtered_df = df_from_json[df_from_json["Salary"] > 55000]
print("\nFiltered Data (Salary > 55000):")
print(filtered_df)

# Aggregating: Calculate the average salary
average_salary = df_from_json["Salary"].mean()
print(f"\nAverage Salary: {average_salary}")

# Sorting: Sort employees by Salary in descending order
sorted_df = df_from_json.sort_values(by="Salary", ascending=False)
print("\nSorted Data (by Salary, descending):")
print(sorted_df)
