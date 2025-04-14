import fitz  # PyMuPDF
import csv

# Open the PDF file
pdf_document = r"C:\Users\mytech\mytech - mytech TECHNOLOGIES LIMITED\D&A\dnapass\gtm-azure-cloud\Microsite\Microsite_SAST_ScanReport.pdf"
pdf = fitz.open(pdf_document)

# Extract text from each page
text = ""
for page_num in range(len(pdf)):
    page = pdf.load_page(page_num)
    text += page.get_text()

# Define the headers for the CSV file
headers = [
    "Vulnerability Type",
    "Severity",
    "Result State",
    "Online Results",
    "Status",
    "Detection Date",
    "Description",
    "Source File",
    "Destination File",
    "Line Numbers",
    "Code Snippet"
]

# Split the text into sections based on the pattern "File Disclosure\Path"
# Description
vulTypes = [
    {"Vulnerability Type": "File Disclosure\\Path", "Occurrences": 6, "Severity": "High"},
    {"Vulnerability Type": "Reflected XSS All Clients\\Path", "Occurrences": 6, "Severity": "High"},
    {"Vulnerability Type": "Client DOM XSS\\Path", "Occurrences": 4, "Severity": "High"},
    {"Vulnerability Type": "Client Potential XSS\\Path", "Occurrences": 14, "Severity": "Medium"},
    {"Vulnerability Type": "Missing HSTS Header\\Path", "Occurrences": 1, "Severity": "Medium"},
    {"Vulnerability Type": "Client Weak Cryptographic Hash\\Path", "Occurrences": 148, "Severity": "Low"},
    {"Vulnerability Type": "Client Use Of Iframe Without Sandbox\\Path", "Occurrences": 24, "Severity": "Low"},
    {"Vulnerability Type": "Client Hardcoded Domain\\Path", "Occurrences": 18, "Severity": "Low"},
    {"Vulnerability Type": "Client DOM Open Redirect\\Path", "Occurrences": 2, "Severity": "Low"},
    {"Vulnerability Type": "JSON Hijacking\\Path", "Occurrences": 1, "Severity": "Low"},
    {"Vulnerability Type": "Missing CSP Header\\Path", "Occurrences": 1, "Severity": "Low"},
    {"Vulnerability Type": "Potential Clickjacking on Legacy Browsers\\Path", "Occurrences": 1, "Severity": "Low"}
]

data = []

# loop vulTypes and extract the data
for vulType in vulTypes:
    sections = text.split(vulType["Vulnerability Type"])


    # Process each section and extract relevant information
    
    for section in sections[1:]:  # Skip the first split part as it will be empty
        # print section for debugging
        #print(section)
        lines = section.split("\n")
        
        # Initialize a dictionary to store extracted data
        record = {header: "" for header in headers}
        
        # Extract data from lines
        record["Vulnerability Type"] = vulType["Vulnerability Type"] + lines[0].split(":")[0].strip()
        # find the index of the severity text and extract the data in next line if "PAGE " text not found, if found move to next line
        if "Severity" in lines[1]:
            if "PAGE " in lines[2]:
                record["Severity"] = lines[3].strip()
            else:
                record["Severity"] = lines[2].strip()
        # Extract Result State
        if "Result State" in lines[4]:
            record["Result State"] = lines[5].strip()
        else:
            record["Result State"] = lines[4].strip()
        
        # Extract Online Results
        if "Online Results" in lines[6]:
            record["Online Results"] = lines[7].strip()
        else:
            record["Online Results"] = lines[6].strip()
        
        # Extract Status
        if "Status" in lines[10]:
            record["Status"] = lines[11].strip()
        else:
            record["Status"] = lines[10].strip()
        
        # Extract Detection Date
        if "Detection Date" in lines[12]:
            record["Detection Date"] = lines[13].strip()
        else:
            record["Detection Date"] = lines[12].strip()
        
        
        # Extract Description
        if "Description" in lines[13]:
            record["Description"] = lines[14].strip() + lines[15].strip() + lines[16].strip() + lines[17].strip() + lines[18].strip()
        else:
            record["Description"] = lines[13].strip() + lines[14].strip() + lines[15].strip() + lines[16].strip() + lines[17].strip()
        
        # Extract the file name after finding the index  between line with "File" and "Line" as text
        file_start = lines.index("File")
        file_end = lines.index("Line")
        for i in range(file_start, file_end):
            record["Source File"] =   record["Source File"] + lines[i].strip()

        # Extract fhe lines number after finding the index  between line with "Line" and "Object" as text
        line_start = lines.index("Line")
        line_end = lines.index("Object")
        
        for i in range(line_start, line_end):
            record["Line Numbers"] =   record["Line Numbers"] + ":" + lines[i].strip()

        # Combine code snippet lines until reaching the next header
        code_snippet_lines = []
        for line in lines[line_end+9 :line_end+15]:
            code_snippet_lines.append(line.strip())
        
        record["Code Snippet"] = " ".join(code_snippet_lines)
        
        # Add the extracted data to the list
        data.append(record)

# Write the extracted data to a CSV file
csv_file = r"C:\Users\mytech\mytech - mytech TECHNOLOGIES LIMITED\D&A\dnapass\gtm-azure-cloud\Microsite\Microsite_SAST_ScanReport.csv"
with open(csv_file, mode='w', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=headers)
    
    writer.writeheader()
    
    for row in data:
        writer.writerow(row)

print(f"Data has been successfully extracted and saved to {csv_file}.")