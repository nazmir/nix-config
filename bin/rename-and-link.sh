#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file_path> <directory_path>"
    exit 1
fi

file_path="$1"
directory_path="$2"

# Check if the file path exists and is a directory
if [ ! -d "$file_path" ]; then
    echo "Error: '$file_path' is not a directory or does not exist."
    exit 1
fi

# Check if the directory path exists and is a directory
if [ ! -d "$directory_path" ]; then
    echo "Error: '$directory_path' is not a directory or does not exist."
    exit 1
fi

# Function to create symbolic link
create_symbolic_link() {
    local file="$1"
    local file_name=$(basename "$file")
    # Rename the original file with .orig extension
    mv "$file" "$file.orig"
    # Create a symbolic link in the original file path
    ln -s "$directory_path/$file_name" "$file"
    echo "Symbolic link created at $file pointing to $directory_path/$file_name"
}

# Loop through files in the file path
for file in "$file_path"/*; do
    # Check if file is a regular file
    if [ -f "$file" ]; then
        create_symbolic_link "$file"
    fi
done
