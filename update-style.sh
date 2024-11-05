#!/bin/bash

# Check if a source file is specified
if [ -z "$1" ]; then
    echo "Usage: $0 <file_to_copy>"
    exit 1
fi

# Assign the file to copy
file_to_copy="$1"
file_name=$(basename "$file_to_copy")

# Check if the specified file exists
if [ ! -f "$file_to_copy" ]; then
    echo "Error: File '$file_to_copy' does not exist."
    exit 1
fi

# Loop through all directories in ./public, excluding any directory named "resources"
find ./public -type d ! -name "resources" | while read -r dir; do
    # Delete the pre-existing file if it exists
    if [ -f "$dir/$file_name" ]; then
        rm "$dir/$file_name"
        echo "Deleted existing file $file_name in $dir"
    fi
    # Copy the new file
    cp "$file_to_copy" "$dir"
    echo "Copied $file_to_copy to $dir"
done

echo "File copied to all folders and subfolders in ./public, except 'resources' directories."
