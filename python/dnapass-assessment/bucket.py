import pandas as pd
import numpy as np

# Load the data from the CSV file
data = pd.read_csv(r'C:\anbu\code\dnapass\climatedata\python\dnapass-assessment\data.csv')

# Convert percentage strings to float
data['Subject coverage'] = data['Subject coverage'].str.rstrip('%').astype('float') / 100.0
data['Weighted Score'] = data['Weighted Score'].str.rstrip('%').astype('float') / 100.0

# Remove outliers using the IQR method
Q1 = data[['Subject coverage', 'Weighted Score']].quantile(0.25)
Q3 = data[['Subject coverage', 'Weighted Score']].quantile(0.75)
IQR = Q3 - Q1

# Align the dataframes before performing operations
Q1, data = Q1.align(data, axis=1, copy=False)
Q3, data = Q3.align(data, axis=1, copy=False)

# Define outliers
outliers = ((data < (Q1 - 1.5 * IQR)) | (data > (Q3 + 1.5 * IQR))).any(axis=1)
outlier_records = data[outliers]

# Remove outliers from the data
data_cleaned = data[~outliers]

# Define the bucket ranges
bins = [0, 0.25, 0.5, 0.75, 1]
labels = ['0-25%', '25-50%', '50-75', '75-100%']
# Create a new column for the bucketed data
data_cleaned['Subject coverage bucket'] = pd.cut(data_cleaned['Subject coverage'], bins=bins, labels=labels, include_lowest=True)
data_cleaned['Weighted Score bucket'] = pd.cut(data_cleaned['Weighted Score'], bins=bins, labels=labels, include_lowest=True)
# Group by the buckets and count occurrences
grouped_data = data_cleaned.groupby(['Subject coverage bucket', 'Weighted Score bucket']).size().reset_index(name='Count')
# Save the cleaned data and grouped data to CSV files
data_cleaned.to_csv('cleaned_data.csv', index=False)
grouped_data.to_csv('grouped_data.csv', index=False)
# Print the cleaned data and grouped data
print("Cleaned Data:")
print(data_cleaned)
print("\nGrouped Data:")
print(grouped_data)
# Print outliers for reference
print("\nOutliers:")
print(outlier_records)

# Print the number of outliers
print(f"\nNumber of outliers: {len(outlier_records)}")
# Print the number of records in the cleaned data
print(f"Number of records in cleaned data: {len(data_cleaned)}")
# Print the number of records in the original data
print(f"Number of records in original data: {len(data)}")
# Print the percentage of records that were outliers
percentage_outliers = (len(outlier_records) / len(data)) * 100
print(f"Percentage of records that were outliers: {percentage_outliers:.2f}%")
# Print the percentage of records in each bucket
bucket_counts = data_cleaned['Subject coverage bucket'].value_counts(normalize=True) * 100
print("\nPercentage of records in each bucket:")
for bucket, percentage in bucket_counts.items():
    print(f"{bucket}: {percentage:.2f}%")
