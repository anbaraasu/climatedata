import pandas as pd

# -------------------------------
# Example: Concatenating DataFrames
# -------------------------------

# Create the first DataFrame
data1 = {
    "Employee_ID": [1, 2, 3],
    "Name": ["Alice", "Bob", "Charlie"],
    "Department": ["HR", "IT", "Finance"]
}
df1 = pd.DataFrame(data1)

# Create the second DataFrame
data2 = {
    "Employee_ID": [4, 5, 6],
    "Name": ["David", "Eve", "Frank"],
    "Department": ["Marketing", "Sales", "Support"]
}
df2 = pd.DataFrame(data2)

# Vertical concatenation (stacking rows)
vertical_concat = pd.concat([df1, df2], axis=0, ignore_index=True)
print("Vertical Concatenation (Stacking Rows):")
print(vertical_concat)

# Create the third DataFrame for horizontal concatenation
data3 = {
    "Employee_ID": [1, 2, 3],
    "Salary": [50000, 60000, 55000],
    "Years_of_Experience": [5, 7, 6]
}
df3 = pd.DataFrame(data3)

# Horizontal concatenation (adding columns)
horizontal_concat = pd.concat([df1, df3], axis=1)
print("\nHorizontal Concatenation (Adding Columns):")
print(horizontal_concat)
