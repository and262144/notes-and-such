#!/bin/bash
set -e

# Configuration
SOURCE_DIR="./notes"             # Directory containing markdown files
OUTPUT_DIR="./public"            # Directory to output HTML files
TEMPLATE="template.html"         # HTML template file
RESOURCES_DIR_NAME="resources"   # Directory name to hold images
TIMESTAMP_FILE=".timestamps"     # File to store modification timestamps
FORCE_BUILD=${FORCE_BUILD:-false} # Environment variable to force build all files

# Initialize timestamp file if it doesn't exist
if [ ! -f "$TIMESTAMP_FILE" ]; then
    touch "$TIMESTAMP_FILE"
fi

# Function to check if file needs updating
needs_update() {
    local input_file="$1"
    local output_file="$2"

    # If force build is enabled, always return true
    if [ "$FORCE_BUILD" = "true" ]; then
        return 0
    fi

    # If output file doesn't exist, needs update
    if [ ! -f "$output_file" ]; then
        return 0
    fi

    # Get last build timestamp from timestamps file
    local last_build
    last_build=$(grep "^${input_file}:" "$TIMESTAMP_FILE" | cut -d: -f2) || true

    # If no timestamp found, needs update
    if [ -z "$last_build" ]; then
        return 0
    fi

    # Get file's current modification time
    local current_mod
    current_mod=$(stat -c %Y "$input_file")

    # If current modification time is newer than last build, needs update
    if [ "$current_mod" -gt "$last_build" ]; then
        return 0
    fi

    # Check if template is newer than last build
    local template_mod
    template_mod=$(stat -c %Y "$TEMPLATE")
    if [ "$template_mod" -gt "$last_build" ]; then
        return 0
    fi

    return 1
}

# Function to update timestamp
update_timestamp() {
    local file="$1"
    local current_time
    current_time=$(date +%s)

    # Remove existing entry if present
    sed -i "\|^${file}:|d" "$TIMESTAMP_FILE"

    # Add new timestamp
    echo "${file}:${current_time}" >> "$TIMESTAMP_FILE"
}

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Rest of your resource copying functions remain the same
copy_resources() {
    local src="$1"
    local src_base="$2"
    local dst_base="$3"

    if [ ! -d "$src" ]; then
        echo "Error: Source directory $src not found"
        return 1
    fi

    local rel_path="${src#$src_base/}"
    local dst="$dst_base/$rel_path"

    mkdir -p "$dst"

    for file in "$src"/*; do
        if [ -f "$file" ]; then
            cp "$file" "$dst/"
            echo "Copied $(basename "$file") to $dst/"
        elif [ -d "$file" ]; then
            copy_resources "$file" "$src_base" "$dst_base"
        fi
    done
}

find_and_copy_resources() {
    local current_dir="$1"

    if [ -d "$current_dir/$RESOURCES_DIR_NAME" ]; then
        local rel_path="${current_dir#$SOURCE_DIR/}"
        if [ "$rel_path" = "$current_dir" ]; then
            rel_path=""
        fi

        local target_dir="$OUTPUT_DIR/$rel_path/$RESOURCES_DIR_NAME"
        mkdir -p "$target_dir"

        echo "Found resources in $current_dir"
        copy_resources "$current_dir/$RESOURCES_DIR_NAME" "$current_dir" "$OUTPUT_DIR/$rel_path"
    fi

    for dir in "$current_dir"/*/; do
        if [ -d "$dir" ] && [ "$(basename "$dir")" != "$RESOURCES_DIR_NAME" ]; then
            find_and_copy_resources "$dir"
        fi
    done
}

# Modified generate_html function with timestamp checking
generate_html() {
    local input_dir="$1"
    local output_dir="$2"

    mkdir -p "$output_dir"

    if [ "$(basename "$input_dir")" = "$RESOURCES_DIR_NAME" ]; then
        return
    fi

    local index_md="$input_dir/index.md"
    if [ ! -f "$index_md" ]; then
        echo "# $(basename "$input_dir")" > "$index_md"

        for item in "$input_dir"/*; do
            if [ -d "$item" ] && [ "$(basename "$item")" != "$RESOURCES_DIR_NAME" ]; then
                echo "- [$(basename "$item")]($(basename "$item")/index.html)" >> "$index_md"
            elif [ -f "$item" ] && [ "$(basename "$item")" != "index.md" ] && [[ "$item" == *.md ]]; then
                local name=$(basename "$item" .md)
                echo "- [$name]($name.html)" >> "$index_md"
            fi
        done
    fi

    # Check if index.md needs updating
    local index_html="$output_dir/index.html"
    if needs_update "$index_md" "$index_html"; then
        echo "Converting $index_md to HTML"
        pandoc "$index_md" \
            --from gfm+yaml_metadata_block+implicit_figures+bracketed_spans+fenced_divs \
            --to html5 \
            --template "$TEMPLATE" \
            --mathjax \
            --quiet \
            -o "$index_html"
        update_timestamp "$index_md"
    else
        echo "Skipping $index_md (not modified)"
    fi

    # Convert other markdown files
    for md_file in "$input_dir"/*.md; do
        if [ -f "$md_file" ] && [ "$(basename "$md_file")" != "index.md" ]; then
            local name=$(basename "$md_file" .md)
            local html_file="$output_dir/$name.html"

            if needs_update "$md_file" "$html_file"; then
                echo "Converting $md_file to HTML"
                pandoc "$md_file" \
                    --from gfm+yaml_metadata_block+implicit_figures+bracketed_spans+fenced_divs \
                    --to html5 \
                    --template "$TEMPLATE" \
                    --mathjax \
                    --quiet\
                    -o "$html_file"
                update_timestamp "$md_file"
            else
                echo "Skipping $md_file (not modified)"
            fi
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

# Main execution

# Check for force build flag
if [ "$FORCE_BUILD" = "true" ]; then
    echo "Force build enabled - will rebuild all files"
fi

# First, find and copy all resources
echo "Finding and copying resources..."
find_and_copy_resources "$SOURCE_DIR"

# Then generate HTML files
echo "Generating HTML files..."
generate_html "$SOURCE_DIR" "$OUTPUT_DIR"

echo "Site generation complete!"

# If this is being run via the update script, add confirmation
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    # Ask the user for confirmation
    echo "Do you want to run the script? (yes/no)"
    read -r answer

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
fi
