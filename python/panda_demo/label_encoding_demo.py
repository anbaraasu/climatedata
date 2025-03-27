import pandas as pd
from sklearn.preprocessing import LabelEncoder

# -------------------------------
# Example: Label Encoding
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

# Perform label encoding on the 'Department' column
label_encoder = LabelEncoder()
df["Department_Encoded"] = label_encoder.fit_transform(df["Department"])

# Display the label encoded DataFrame
print("\nLabel Encoded DataFrame:")
print(df)

# Display the mapping of labels to encoded values
print("\nLabel Mapping:")
for label, encoded in zip(label_encoder.classes_, range(len(label_encoder.classes_))):
    print(f"{label}: {encoded}")
