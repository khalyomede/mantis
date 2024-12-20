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

    # Exclude claude directory
    [[ "$file" =~ ^./claude/ ]] && return 1

    # Include .v files from anywhere except certain directories
    if [[ "$file" =~ \.v$ ]]; then
        # Exclude certain directories if needed
        [[ "$file" =~ /\..* ]] && return 1  # Exclude hidden directories
        [[ "$file" =~ /build/ ]] && return 1 # Exclude build directory
        return 0
    fi

    # For _docs, include only direct files and ignore version numbers and .vitepress
    if [[ "$file" =~ ^\./_docs/ ]]; then
        # Exclude .vitepress folder
        [[ "$file" =~ ^\./_docs/\.vitepress ]] && return 1
        # Exclude version number folders
        [[ "$file" =~ ^\./_docs/[0-9]+\.[0-9]+\.[0-9]+ ]] && return 1
        # Include only .md files
        [[ "$file" =~ \.md$ ]] && return 0
        return 1
    fi

    return 1
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
