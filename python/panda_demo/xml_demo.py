import pandas as pd
import xml.etree.ElementTree as ET
from lxml import etree

# -------------------------------
# Example: Working with XML Files
# -------------------------------

# Step 1: Write data to an XML file
def write_xml(file_path):
    # Create an XML structure
    root = ET.Element("Employees")
    employees = [
        {"Employee_ID": "1", "Name": "Alice", "Department": "HR", "Salary": "50000"},
        {"Employee_ID": "2", "Name": "Bob", "Department": "IT", "Salary": "60000"},
        {"Employee_ID": "3", "Name": "Charlie", "Department": "Finance", "Salary": "55000"}
    ]
    for emp in employees:
        employee = ET.SubElement(root, "Employee")
        for key, value in emp.items():
            ET.SubElement(employee, key).text = value

    # Write the XML to a file
    tree = ET.ElementTree(root)
    tree.write(file_path, encoding="utf-8", xml_declaration=True)
    print(f"XML data written to {file_path}")

# Step 2: Read data from an XML file
def read_xml(file_path):
    # Parse the XML file
    tree = ET.parse(file_path)
    root = tree.getroot()

    # Convert XML data to a list of dictionaries
    data = []
    for employee in root.findall("Employee"):
        emp_data = {child.tag: child.text for child in employee}
        data.append(emp_data)

    # Convert the list of dictionaries to a DataFrame
    df = pd.DataFrame(data)
    print("\nData read from XML file:")
    print(df)
    return df

# Step 3: Filter records
def filter_records(df):
    # Filter employees with Salary > 55000
    filtered_df = df[df["Salary"].astype(float) > 55000]
    print("\nFiltered Records (Salary > 55000):")
    print(filtered_df)

# Step 4: Sort records
def sort_records(df):
    # Sort employees by Salary in descending order
    sorted_df = df.sort_values(by="Salary", ascending=False, key=lambda col: col.astype(float))
    print("\nSorted Records (by Salary, descending):")
    print(sorted_df)

# Step 5: Validate XML against an XSD schema
def validate_xml(file_path, schema_path):
    # Parse the XML and XSD files
    xml_doc = etree.parse(file_path)
    with open(schema_path, "r") as schema_file:
        schema_doc = etree.XML(schema_file.read())
    schema = etree.XMLSchema(schema_doc)

    # Validate the XML file
    is_valid = schema.validate(xml_doc)
    print(f"\nXML validation against schema: {'Valid' if is_valid else 'Invalid'}")
    if not is_valid:
        print(schema.error_log)

# Step 6: Transform XML using XSLT
def transform_xml(file_path, xslt_path):
    # Parse the XML and XSLT files
    xml_doc = etree.parse(file_path)
    with open(xslt_path, "r") as xslt_file:
        xslt_doc = etree.XML(xslt_file.read())
    transform = etree.XSLT(xslt_doc)

    # Apply the transformation
    transformed_doc = transform(xml_doc)
    print("\nTransformed XML:")
    print(str(transformed_doc))

# -------------------------------
# Main Execution
# -------------------------------
xml_file = "employees.xml"
xsd_file = "employees.xsd"
xslt_file = "employees.xslt"

# Write XML data
write_xml(xml_file)

# Read XML data
df = read_xml(xml_file)

# Filter records
filter_records(df)

# Sort records
sort_records(df)

# Validate XML against schema
validate_xml(xml_file, xsd_file)

# Transform XML using XSLT
transform_xml(xml_file, xslt_file)
