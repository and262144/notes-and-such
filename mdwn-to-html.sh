#!/bin/bash

# Set up paths
SOURCE_DIR="./notes"       # Directory containing markdown files
OUTPUT_DIR="./public"      # Directory to output HTML files
TEMPLATE="template.html"    # HTML template file

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

generate_html() {
    local input_dir=$1
    local output_dir=$2

    # Create output directory if it doesn't exist
    mkdir -p "$output_dir"

    # Create or update index.md for the directory
    local index_md="$input_dir/index.md"
    if [[ ! -f "$index_md" ]]; then
        echo "# $(basename "$input_dir")" > "$index_md"
        for subitem in "$input_dir"/*; do
            local subitem_name=$(basename "$subitem")
            if [[ -d "$subitem" ]]; then
                echo "- [$subitem_name]($subitem_name/index.html)" >> "$index_md"
            elif [[ -f "$subitem" && "$subitem_name" == *.md && "$subitem_name" != "index.md" ]]; then
                echo "- [${subitem_name%.md}](${subitem_name%.md}.html)" >> "$index_md"
            fi
        done
    fi

    # Convert index.md to HTML
    echo "Converting $index_md to HTML"
    pandoc "$index_md" --from markdown --to html5 --template "$TEMPLATE" --mathjax \
    --metadata title="$(basename "$input_dir")" -o "$output_dir/index.html"

    # Convert each Markdown file in the directory to HTML
    for item in "$input_dir"/*.md; do
        local filename=$(basename "$item")
        if [[ "$filename" != "index.md" ]]; then
            local output_file="$output_dir/${filename%.md}.html"
            echo "Converting $filename to HTML"

            # Use Pandoc to convert with a backlink in metadata
            pandoc "$item" --from markdown --to html5 --template "$TEMPLATE" --mathjax \
            --metadata title="${filename%.md}" \
            --metadata=backlink="[Back to index](index.html)" -o "$output_file"
        fi
    done

    # Recursively process subdirectories
    for subdir in "$input_dir"/*/; do
        if [[ -d "$subdir" ]]; then
            generate_html "$subdir" "$output_dir/$(basename "$subdir")"
        fi
    done
}

# Start the conversion process
generate_html "$SOURCE_DIR" "$OUTPUT_DIR"
