import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix

# Load the data from the CSV file
data = pd.read_csv(r'C:\anbu\code\dnapass\climatedata\fraud_detection\transactions.csv')

# Handle missing values
# Impute missing values in numerical columns with the mean
numerical_imputer = SimpleImputer(strategy='mean')
data[['Amount', 'Transaction Time']] = numerical_imputer.fit_transform(data[['Amount', 'Transaction Time']])

# Encode categorical variables
# One-hot encode the 'Transaction Type' column
encoder = OneHotEncoder(sparse=False)
encoded_features = encoder.fit_transform(data[['Transaction Type']])
encoded_df = pd.DataFrame(encoded_features, columns=encoder.get_feature_names_out(['Transaction Type']))

# Concatenate the encoded features with the original data
data = pd.concat([data, encoded_df], axis=1)
data.drop(columns=['Transaction Type'], inplace=True)

# Define features and target variable
X = data.drop(columns=['Fraud'])
y = data['Fraud']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Train a RandomForestClassifier
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Make predictions on the test set
y_pred = model.predict(X_test)

# Evaluate the model
print("Confusion Matrix:")
print(confusion_matrix(y_test, y_pred))
print("\nClassification Report:")
print(classification_report(y_test, y_pred))
