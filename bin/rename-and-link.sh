# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_file_or_directory> <target_file_or_directory>"
    exit 1
fi

source_path="$1"
target_path="$2"

# Function to create symbolic link for files
create_symbolic_link_for_file() {
    local file="$1"
    local target="$2"
    # Rename the original source file with .orig extension
    mv "$file" "$file.orig"
    # Create a symbolic link pointing to the target file
    ln -s "$target" "$file"
    echo "Symbolic link created at $file pointing to $target"
}

# Function to handle directories
process_directories() {
    local source_dir="$1"
    local target_dir="$2"
    
    # Loop through files in the source directory
    for source_file in "$source_dir"/*; do
        if [ -f "$source_file" ]; then
            local file_name=$(basename "$source_file")
            local target_file="$target_dir/$file_name"
            
            # Check if a matching file exists in the target directory
            if [ -f "$target_file" ]; then
                # Rename the source file and create the symbolic link
                create_symbolic_link_for_file "$source_file" "$target_file"
            else
                echo "Warning: No matching file found for '$source_file' in target directory."
            fi
        fi
    done
}

# Main Logic
if [ -f "$source_path" ] && [ -f "$target_path" ]; then
    # If both arguments are files
    create_symbolic_link_for_file "$source_path" "$target_path"

elif [ -d "$source_path" ] && [ -d "$target_path" ]; then
    # If both arguments are directories
    process_directories "$source_path" "$target_path"

else
    echo "Error: Both arguments must either be files or directories."
    exit 1
fi
