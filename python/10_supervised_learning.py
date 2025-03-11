from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.metrics import classification_report

# Load dataset
iris = load_iris()
X = iris.data
y = iris.target

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
model = SVC()
model.fit(X_train, y_train)

# Predict
y_pred = model.predict(X_test)

# Evaluate
report = classification_report(y_test, y_pred)
print(report)
