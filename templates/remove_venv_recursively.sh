#!/bin/bash

function delete_contents() {
    local directory="$1"
    for file in "$directory"/*; do
        if [[ -d "$file" ]]; then
            rm -r "$file"
        else
            rm "$file"
        fi
    done

    # Once the contents are deleted, remove the directory itself
    rm -r "$directory"
}

# Get the parent directory of the script location and append '.venv'
script_dir="$(dirname "$(realpath "$0")")"
venv_path="$script_dir/../.venv"

# Delete the contents of the .venv folder recursively
delete_contents "$venv_path"
