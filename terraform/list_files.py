import os
import json

def list_files_in_directory(directory):
    files = {}
    for root, _, filenames in os.walk(directory):
        for filename in filenames:
            filepath = os.path.join(root, filename)
            # Strip the root directory to use the relative path as the blob name
            blob_name = os.path.relpath(filepath, directory)
            # Use blob_name as key and ensure filepath is a string
            files[blob_name] = filepath  # blob_name is the key and filepath is the value

    return files

if __name__ == "__main__":
    # Define the directory you want to list
    base_directory = os.path.normpath(os.getcwd() + os.sep + os.pardir)  # Gets the current working directory)
    directory = os.path.join(base_directory, "frontend")  # Join base directory and 'frontend'
    files = list_files_in_directory(directory)


    output = {str(key): str(value) for key, value in files.items()}
    print(json.dumps(output))  
