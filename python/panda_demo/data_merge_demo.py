import pandas as pd

# -------------------------------
# Example: Merging DataFrames
# -------------------------------

# Create the first DataFrame
data1 = {
    "Employee_ID": [1, 2, 3, 4],
    "Name": ["Alice", "Bob", "Charlie", "David"],
    "Department": ["HR", "IT", "Finance", "Marketing"]
}
df1 = pd.DataFrame(data1)

# Create the second DataFrame
data2 = {
    "Employee_ID": [3, 4, 5],
    "Salary": [55000, 70000, 45000],
    "Years_of_Experience": [6, 8, 3]
}
df2 = pd.DataFrame(data2)

# Display the original DataFrames
print("First DataFrame:")
print(df1)
print("\nSecond DataFrame:")
print(df2)

# Merge the DataFrames using an inner join
inner_merged = pd.merge(df1, df2, on="Employee_ID", how="inner")
print("\nInner Join Result:")
print(inner_merged)

# Merge the DataFrames using a left join
left_merged = pd.merge(df1, df2, on="Employee_ID", how="left")
print("\nLeft Join Result:")
print(left_merged)

# Merge the DataFrames using a right join
right_merged = pd.merge(df1, df2, on="Employee_ID", how="right")
print("\nRight Join Result:")
print(right_merged)

# Merge the DataFrames using an outer join
outer_merged = pd.merge(df1, df2, on="Employee_ID", how="outer")
print("\nOuter Join Result:")
print(outer_merged)
