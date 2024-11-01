#!/bin/bash

# Set up paths
SOURCE_DIR="./notes"       # Directory containing markdown files
OUTPUT_DIR="./public"   # Directory to output HTML files
TEMPLATE="template.html"     # HTML template file

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Function to generate HTML from Markdown with links to subdirectories and backlinks
generate_html() {
    local input_dir=$1
    local output_dir=$2

    # Create output directory if it doesn't exist
    mkdir -p "$output_dir"

    # Loop through each file and directory
    for item in "$input_dir"/*; do
        local filename=$(basename "$item")
        local output_file="$output_dir/${filename%.md}.html"

        if [[ -d $item ]]; then
            # Generate index.html with links for subdirectories
            local sub_output_dir="$output_dir/$filename"
            echo "Generating index for directory: $filename"
            echo "# $filename" > "$item/index.md"
            for subdir in "$item"/*/; do
                local subdir_name=$(basename "$subdir")
                echo "- [$subdir_name]($subdir_name/index.html)" >> "$item/index.md"
            done
            generate_html "$item" "$sub_output_dir"

        elif [[ -f $item && $filename == *.md ]]; then
            echo "Converting $filename to HTML"

            # Add backlink at the beginning of the file
            backlink="../index.html"  # Default backlink goes one directory up
            if [[ $output_dir == "$OUTPUT_DIR" ]]; then
                backlink="index.html"  # Set backlink to main index for top-level files
            fi
            echo "[Back to previous page]($backlink)" | cat - "$item" > temp.md

            # Convert to HTML with Pandoc using template
            pandoc temp.md --from markdown --to html5 --template "$TEMPLATE" --mathjax \
            -o "$output_file"
            rm temp.md
        fi
    done
}

# Start the conversion process
generate_html "$SOURCE_DIR" "$OUTPUT_DIR"
