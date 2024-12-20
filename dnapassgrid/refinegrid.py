import pandas as pd
import matplotlib.pyplot as plt
# Load the data from CSV file
#data = pd.read_csv('/c:/anbu/code/dnapass/climatedata/dnapassgrid/data.csv')

# Load the data
def load_data(file_path):
    """
    Load data from a CSV file.
    """
    try:
        df = pd.read_csv(file_path, sep=',', header=0)
        return df
    except FileNotFoundError:
        print("File not found. Please check the file path.")
        return None

# Define the function to assign buckets
def assign_bucket(weighted_score, coverage_score, thresholds):
    """
    Assign a rating bucket based on thresholds.
    """
    for bucket, range in thresholds.items():
        if range[0] <= weighted_score <= range[1] and range[2] <= coverage_score <= range[3]:
            return bucket
    return "No Rating"

# Define the main function
def main(file_path):
    # Step 1: Load the data
    df = load_data(file_path)
    if df is None:
        return
    
    # Step 2: Define bucket thresholds
    bucket_percentages = {
        "No Rating": (0, 0.1, 0, 0.1),
        "Novice": (0.1, 0.3, 0.1, 0.3),
        "Advanced Beginner": (0.3, 0.5, 0.3, 0.5),
        "Competent": (0.5, 0.7, 0.5, 0.7),
        "Proficient": (0.7, 0.9, 0.7, 0.9),
        "Expert": (0.9, 1.0, 0.9, 1.0)
    }

    # Step 3: Calculate Weighted Score and Subject Coverage are in 3rd and 4th columns respectively
    df['Weighted_Score'] = df['Weighted Score']
    df['Subject_Coverage'] = df['Subject coverage']

    

    # Step 4: Assign buckets
    df['Bucket'] = df.apply(
        lambda row: assign_bucket(row['Weighted_Score'], row['Subject_Coverage'], bucket_percentages), axis=1
    )

    # Step 5: Summarize results
    bucket_summary = df['Bucket'].value_counts()
    print("Bucket Summary:")
    print(bucket_summary)

    # Step 6: Visualize results
    bucket_summary.plot(kind='bar')
    plt.title('Students Distribution by Rating Buckets')
    plt.xlabel('Rating Buckets')
    plt.ylabel('Number of Students')
    plt.show()

    # Step 7: Save results (optional)
    output_file = "bucketed_data.csv"
    df.to_csv(output_file, index=False)
    print(f"Results saved to {output_file}")

# Entry point for the script
if __name__ == "__main__":
    # Provide the path to your CSV file here
    file_path = "c:/anbu/code/dnapass/climatedata/dnapassgrid/data.csv"
    main(file_path)
