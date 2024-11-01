#!/bin/bash

# Set up paths
SOURCE_DIR="./notes"        # Directory containing markdown files
OUTPUT_DIR="./public"       # Directory to output HTML files
TEMPLATE="template.html"    # HTML template file

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Function to generate HTML from Markdown with backlinks and links to subdirectories
generate_html() {
    local input_dir="$1"
    local output_dir="$2"

    # Create output directory if it doesn't exist
    mkdir -p "$output_dir"

    # Loop through each item in the directory
    for item in "$input_dir"/*; do
        local filename=$(basename "$item")
        local output_file="$output_dir/${filename%.md}.html"
        local title="${filename%.md}"  # Set title based on filename

        if [[ -d $item ]]; then
            # Directory: generate index.md with links for subdirectories
            local sub_output_dir="$output_dir/$filename"
            mkdir -p "$sub_output_dir"
            local index_file="$item/index.md"

            echo "Generating index for directory: $filename"
            echo "# $filename" > "$index_file"
            echo -e "\n[Back to previous page](../index.html)\n" >> "$index_file"

            # Add links to each subdirectory or markdown file
            for subitem in "$item"/*; do
                local subitem_name=$(basename "$subitem")
                echo "- [$subitem_name]($subitem_name)" >> "$index_file"
            done

            # Recursively generate HTML for subdirectory
            generate_html "$item" "$sub_output_dir"

        elif [[ -f $item && $filename == *.md ]]; then
            # Markdown file: check if HTML needs to be regenerated
            echo "Checking $filename for updates"

            if [[ ! -f $output_file || "$item" -nt "$output_file" ]]; then
                echo "Converting $filename to HTML"

                # Set backlink based on directory level
                local backlink="../index.html"
                [[ $output_dir == "$OUTPUT_DIR" ]] && backlink="index.html"

                # Add backlink, blank line, and convert to HTML
                (echo -e "[Back to previous page]($backlink)\n"; cat "$item") > temp.md
                pandoc temp.md --from markdown --to html5 --template "$TEMPLATE" --mathjax \
                --metadata title="$title" -o "$output_file"
                rm temp.md
            else
                echo "Skipping $filename, HTML is up to date."
            fi
        fi
    done
}

# Generate the main index with links to each subject directory
main_index="$SOURCE_DIR/index.md"
echo "# Main Index" > "$main_index"
for dir in "$SOURCE_DIR"/*/; do
    dirname=$(basename "$dir")
    echo "- [$dirname]($dirname/index.html)" >> "$main_index"
done

# Start the conversion process for all directories and files
generate_html "$SOURCE_DIR" "$OUTPUT_DIR"
