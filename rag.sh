#!/usr/bin/env bash

# Create or clean target directory
target_dir="claude"
if [ -d "$target_dir" ]; then
    echo "Cleaning $target_dir directory..."
    rm -f "$target_dir"/*
else
    echo "Creating $target_dir directory..."
    mkdir -p "$target_dir"
fi

# Function to check if a path should be included
should_include() {
    local file="$1"

    # Only include specific folders
    [[ ! "$file" =~ ^\./(tests|mantis|_docs)/ ]] && return 1

    # Only include specific file extensions
    [[ ! "$file" =~ \.(v|md)$ ]] && return 1

    # Exclude specific _docs paths
    [[ "$file" =~ ^\./_docs/[0-9]+\. ]] && return 1
    [[ "$file" =~ ^\./_docs/\.vitepress ]] && return 1

    # For _docs, only include first level and http folder
    if [[ "$file" =~ ^\./_docs/ ]]; then
        # Allow first level files
        [[ "$file" =~ ^\./_docs/[^/]+$ ]] && return 0
        # Allow http folder
        [[ "$file" =~ ^\./_docs/http ]] && return 0
        return 1
    fi

    return 0
}

# Find and process files
find . -type f | while read -r file; do
    # Skip if file shouldn't be included
    should_include "$file" || continue

    # Remove leading ./ from path
    rel_path="${file#./}"

    # Replace directory separators with underscores
    new_name=$(echo "$rel_path" | sed 's/\//_/g')

    # Copy the file to target directory with new name
    cp "$file" "$target_dir/$new_name"

    echo "Copied: $rel_path -> $target_dir/$new_name"
done

echo "Done!"
