#!/bin/bash
set -e

# Set up paths
SOURCE_DIR="./notes"             # Directory containing markdown files
OUTPUT_DIR="./public"            # Directory to output HTML files
TEMPLATE="template.html"         # HTML template file
RESOURCES_DIR_NAME="resources"   # Directory name to hold images

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Copy resources directory and its contents, preserving relative paths
copy_resources() {
    local src="$1"
    local src_base="$2"  # Base source directory for calculating relative paths
    local dst_base="$3"  # Base destination directory

    if [ ! -d "$src" ]; then
        echo "Error: Source directory $src not found"
        return 1
    fi

    # Calculate relative path from source base
    local rel_path="${src#$src_base/}"
    local dst="$dst_base/$rel_path"

    mkdir -p "$dst"

    # Copy files
    for file in "$src"/*; do
        if [ -f "$file" ]; then
            cp "$file" "$dst/"
            echo "Copied $(basename "$file") to $dst/"
        elif [ -d "$file" ]; then
            copy_resources "$file" "$src_base" "$dst_base"
        fi
    done
}

# Find and copy all resources directories recursively
find_and_copy_resources() {
    local current_dir="$1"

    # Process resources in current directory
    if [ -d "$current_dir/$RESOURCES_DIR_NAME" ]; then
        # Calculate relative path from SOURCE_DIR
        local rel_path="${current_dir#$SOURCE_DIR/}"
        if [ "$rel_path" = "$current_dir" ]; then
            rel_path=""
        fi

        # Create target directory
        local target_dir="$OUTPUT_DIR/$rel_path/$RESOURCES_DIR_NAME"
        mkdir -p "$target_dir"

        # Copy resources
        echo "Found resources in $current_dir"
        copy_resources "$current_dir/$RESOURCES_DIR_NAME" "$current_dir" "$OUTPUT_DIR/$rel_path"
    fi

    # Recursively search subdirectories (excluding resources directories)
    for dir in "$current_dir"/*/; do
        if [ -d "$dir" ] && [ "$(basename "$dir")" != "$RESOURCES_DIR_NAME" ]; then
            find_and_copy_resources "$dir"
        fi
    done
}

# Generate HTML files from markdown
generate_html() {
    local input_dir="$1"
    local output_dir="$2"

    mkdir -p "$output_dir"

    # Skip resources directory
    if [ "$(basename "$input_dir")" = "$RESOURCES_DIR_NAME" ]; then
        return
    fi

    # Create index.md if it doesn't exist
    local index_md="$input_dir/index.md"
    if [ ! -f "$index_md" ]; then
        echo "# $(basename "$input_dir")" > "$index_md"

        # Add links to subdirectories and markdown files
        for item in "$input_dir"/*; do
            if [ -d "$item" ] && [ "$(basename "$item")" != "$RESOURCES_DIR_NAME" ]; then
                echo "- [$(basename "$item")]($(basename "$item")/index.html)" >> "$index_md"
            elif [ -f "$item" ] && [ "$(basename "$item")" != "index.md" ] && [[ "$item" == *.md ]]; then
                local name=$(basename "$item" .md)
                echo "- [$name]($name.html)" >> "$index_md"
            fi
        done
    fi

    # Convert index.md to HTML
    echo "Converting $index_md to HTML"
    pandoc "$index_md" \
        --from gfm \
        --to html5 \
        --template "$TEMPLATE" \
        --mathjax \
        --highlight-style=pygments \
        --metadata title="$(basename "$input_dir")" \
        -o "$output_dir/index.html"

    # Convert other markdown files
    for md_file in "$input_dir"/*.md; do
        if [ -f "$md_file" ] && [ "$(basename "$md_file")" != "index.md" ]; then
            local name=$(basename "$md_file" .md)
            echo "Converting $md_file to HTML"
            pandoc "$md_file" \
                --from gfm \
                --to html5 \
                --template "$TEMPLATE" \
                --mathjax \
                --highlight-style=pygments \
                --metadata title="$name" \
                --metadata backlink="[Back to index](index.html)" \
                -o "$output_dir/$name.html"
        fi
    done

    # Process subdirectories
    for dir in "$input_dir"/*/; do
        if [ -d "$dir" ] && [ "$(basename "$dir")" != "$RESOURCES_DIR_NAME" ]; then
            local dirname=$(basename "$dir")
            generate_html "$dir" "$output_dir/$dirname"
        fi
    done
}

# First, find and copy all resources
echo "Finding and copying resources..."
find_and_copy_resources "$SOURCE_DIR"

# Then generate HTML files
echo "Generating HTML files..."
generate_html "$SOURCE_DIR" "$OUTPUT_DIR"

echo "Site generation complete!"

#!/bin/bash

# Ask the user for confirmation
echo "Do you want to run the script? (yes/no)"
read answer

# Check the user's answer
if [ "$answer" == "yes" ]; then
    # Run the other script if the answer is "yes"
    /home/satvik64/Apps/notes-and-such/update-notes.sh
elif [ "$answer" == "no" ]; then
    # Exit if the answer is "no"
    echo "Exiting."
    exit 0
else
    # Handle invalid input
    echo "Invalid input. Please enter 'yes' or 'no'."
    exit 1
fi
