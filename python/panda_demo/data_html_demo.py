import pandas as pd

# -------------------------------
# Example: Reading and Writing HTML Files
# -------------------------------

# Create a sample DataFrame
data = {
    "Employee_ID": [1, 2, 3],
    "Name": ["Alice", "Bob", "Charlie"],
    "Department": ["HR", "IT", "Finance"],
    "Salary": [50000, 60000, 55000]
}
df = pd.DataFrame(data)

# Write the DataFrame to an HTML file
html_file_path = "data.html"
df.to_html(html_file_path, index=False)  # Save the DataFrame to an HTML file without the index
print(f"Data written to HTML file: {html_file_path}")

# Read the HTML file back into a DataFrame
df_from_html = pd.read_html(html_file_path)[0]  # Read the first table from the HTML file
print("\nData read from HTML file:")
print(df_from_html)
