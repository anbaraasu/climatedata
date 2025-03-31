import xml.etree.ElementTree as ET
from deepdiff import DeepDiff

def compare_xml(file1, file2):
    # Parse XML files
    tree1 = ET.parse(file1)
    tree2 = ET.parse(file2)
    
    # Convert XML trees to dictionaries
    dict1 = parse_element(tree1.getroot())
    dict2 = parse_element(tree2.getroot())
    
    # Compare using DeepDiff
    diff = DeepDiff(dict1, dict2, ignore_order=True)
    return diff

def parse_element(element):
    # Convert XML element and its children to a dictionary
    if len(element) == 0:
        return element.text
    return {child.tag: parse_element(child) for child in element}

# Example usage
import os

# Add current script directory path to file names
script_dir = os.path.dirname(os.path.abspath(__file__))  # Get the script's directory
file1 = os.path.join(script_dir, 'JavaScript-CodeRunner-L1.xml')
file2 = os.path.join(script_dir, 'questions-js_advance_beginner-JavaScript CodeRunner - L1-20250328-1726.xml')

# Compare the XML files and print the result
diff_result = compare_xml(file1, file2)
print(diff_result)
