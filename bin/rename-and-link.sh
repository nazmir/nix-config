#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_path> <target_path>"
    exit 1
fi

source_path="$1"
target_path="$2"

# Function to create symbolic link
create_symbolic_link() {
    local file="$1"
    local file_name=$(basename "$file")
    # Rename the original file with .orig extension
    mv "$file" "$file.orig"
    # Create a symbolic link in the original file path
    ln -s "$target_path/$file_name" "$file"
    echo "Symbolic link created at $file pointing to $target_path/$file_name"
}

# Handle cases where the source_path is a file or directory
if [ -f "$source_path" ]; then
    # If source_path is a file
    if [ ! -d "$target_path" ]; then
        echo "Error: '$target_path' is not a directory or does not exist."
        exit 1
    fi
    create_symbolic_link "$source_path"

elif [ -d "$source_path" ]; then
    # If source_path is a directory
    if [ ! -d "$target_path" ]; then
        echo "Error: '$target_path' is not a directory or does not exist."
        exit 1
    fi
    # Loop through files in the directory
    for file in "$source_path"/*; do
        # Check if file is a regular file
        if [ -f "$file" ]; then
            create_symbolic_link "$file"
        fi
    done

else
    echo "Error: '$source_path' is not a file or directory."
    exit 1
fi
