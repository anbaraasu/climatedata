import os

def split_file(file_path, chunk_size=25*1024*1024):
    file_size = os.path.getsize(file_path)
    with open(file_path, 'rb') as f:
        chunk_num = 0
        while True:
            chunk = f.read(chunk_size)
            if not chunk:
                break
                
            chunk_file_path = f"{file_path}.part{chunk_num}"
            chunk_file_path = re.sub(r"-\d{8}_\d{6}-", "", chunk_file_path.replace("LearningCarnivalDec24-", "").replace("MeetingRecording", ""))
            with open(chunk_file_path, 'wb') as chunk_file:
                chunk_file.write(chunk)
            chunk_num += 1

# Get the current directory # os.getcwd()
current_dir = r"C:\Users\anbarasuv\Downloads\Learning Carnival Recordings - Dec'24"

# Get all mp4 files in the current directory
mp4_files = [f for f in os.listdir(current_dir) if f.endswith('.mp4')]

# Process each mp4 file
for mp4_file in mp4_files:
    # Remove the text "LearningCarnivalDec24-", "MeetingRecording", and "-20241210_170133-" from the file name
    import re
    new_file_name = re.sub(r"-\d{8}_\d{6}-", "", mp4_file.replace("LearningCarnivalDec24-", "").replace("MeetingRecording", ""))
    
    # Split the video file into 75 MB chunks and save them in the current directory
    split_file(os.path.join(current_dir, mp4_file))
    
    # Create a shell script to join the files back together
    shell_script_path = os.path.join(current_dir, f"join_{new_file_name}.sh")
    with open(shell_script_path, 'w') as shell_script:
        shell_script.write("#!/bin/bash\n")
        shell_script.write(f"cat {new_file_name}.part* > {new_file_name}\n")
    
    # Make the shell script executable
    os.chmod(shell_script_path, 0o755)
    
    # Create a batch file to add, commit, and push the split files
    batch_file_path = os.path.join(current_dir, f"git_{new_file_name}.bat")
    with open(batch_file_path, 'w') as batch_file:
        batch_file.write("@echo off\n")
        batch_file.write(f"git add {new_file_name}.part*\n")
        batch_file.write(f'git commit -m "Add split files for {new_file_name}"\n')
        batch_file.write("git push\n")
    
    # Create a batch file for each split file to add, commit, and push
    chunk_num = 0
    while os.path.exists(f"{os.path.join(current_dir, mp4_file)}.part{chunk_num}"):
        split_file_batch_path = os.path.join(current_dir, f"git_{new_file_name}.part{chunk_num}.bat")
        with open(split_file_batch_path, 'w') as split_file_batch:
            split_file_batch.write("@echo off\n")
            split_file_batch.write(f"git add {new_file_name}.part{chunk_num}\n")
            split_file_batch.write(f'git commit -m "Add split file {new_file_name}.part{chunk_num}"\n')
            split_file_batch.write("git push\n")
        chunk_num += 1

print("All video files have been split, shell scripts and batch files have been created.")