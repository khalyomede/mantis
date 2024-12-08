#!/bin/bash

# Usage: ./flatten.sh [-e exclude_dir] source_dir target_dir
# Example: ./flatten.sh -e docs . claude

exclude_dir=""

# Parse command line options
while getopts "e:" opt; do
    case $opt in
        e) exclude_dir="$OPTARG";;
        \?) echo "Invalid option -$OPTARG" >&2; exit 1;;
    esac
done

# Shift past the options to get positional arguments
shift $((OPTIND-1))

source_dir="${1:-.}"  # Default to current directory if not specified
target_dir="${2:-claude}"  # Default to 'claude' if not specified

# Create or clean target directory
if [ -d "$target_dir" ]; then
    echo "Cleaning $target_dir directory..."
    rm -f "$target_dir"/*.{v,md,yml}
else
    echo "Creating $target_dir directory..."
    mkdir -p "$target_dir"
fi

# Build the find command with exclusions
find_cmd="find $source_dir -type f \( -name \"*.v\" -o -name \"*.md\" -o -name \"*.yml\" \) -not -path \"*/$target_dir/*\""
if [ -n "$exclude_dir" ]; then
    find_cmd="$find_cmd -not -path \"*/$exclude_dir/*\""
    echo "Excluding directory: $exclude_dir"
fi

# Execute the find command and process files
eval "$find_cmd" | while read -r file; do
    # Get the relative path from source_dir
    rel_path="${file#$source_dir/}"

    # Replace directory separators with underscores
    new_name=$(echo "$rel_path" | sed 's/\//_/g')

    # Copy the file to target directory with new name
    cp "$file" "$target_dir/$new_name"

    echo "Copied: $rel_path -> $target_dir/$new_name"
done

echo "Done!"
