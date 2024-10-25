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
    directory = "C:/Users/Federico Mencuccini/Mencuccini Dropbox/Federico Mencuccini/Aplicaciones/Cloud Projects/Azure/azure-resume/frontend"
    files = list_files_in_directory(directory)

    # Output as a JSON-encoded map directly to stdout
    # Flatten the dictionary to make sure both keys and values are strings
    output = {str(key): str(value) for key, value in files.items()}
    print(json.dumps(output))  # Ensure this is a flat JSON map of strings
