#!/bin/bash

# Check if a file to delete is specified
if [ -z "$1" ]; then
    echo "Usage: $0 <file_to_delete>"
    exit 1
fi

# Assign the file to delete
file_to_delete="$1"
file_name=$(basename "$file_to_delete")

# Check if the specified file exists
if [ ! -f "$file_to_delete" ]; then
    echo "Error: File '$file_to_delete' does not exist."
    exit 1
fi

# Loop through all directories in ./public, excluding any directory named "resources"
find ./public -type d ! -name "resources" | while read -r dir; do
    # Delete the file if it exists
    if [ -f "$dir/$file_name" ]; then
        rm "$dir/$file_name"
        echo "Deleted file $file_name in $dir"
    fi
done

echo "Deletion process completed for $file_name in all folders and subfolders in ./public, except 'resources' directories."