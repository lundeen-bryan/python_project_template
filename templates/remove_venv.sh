#!/bin/bash

# Function to handle error and exit the script
handle_error() {
  local error_message="${1:-An unspecified error occurred}"
  echo "Error: $error_message. Exiting..."
  exit 1
}

# Function to check if virtual environment exists
check_venv_exists() {
  if [ ! -d "$venv_dir" ]; then
    handle_error "Virtual environment not found"
  fi
}

# Function to update requirements.txt with installed packages
update_requirements() {
  source "$venv_dir/Scripts/activate" || handle_error "Failed to activate virtual environment"
  pip freeze > requirements.txt || handle_error "Failed to update requirements.txt"
  deactivate
}

# Function to uninstall all packages
uninstall_packages() {
  source "$venv_dir/Scripts/activate" || handle_error "Failed to activate virtual environment"
  pip uninstall -y -r requirements.txt || handle_error "Failed to uninstall packages"
  deactivate
}

# Function to remove virtual environment directory
remove_venv() {
  rm -rf "$venv_dir" || handle_error "Failed to remove virtual environment directory"
  echo "Virtual environment removed successfully."
}

# Main script execution starts here
echo "Starting virtual environment cleanup process..."

# Set the virtual environment directory
venv_dir="$PWD/.venv"

# Check if virtual environment exists
check_venv_exists

# Update requirements.txt
update_requirements
echo "requirements.txt updated successfully."

# Uninstall all packages
uninstall_packages
echo "All packages uninstalled successfully."

# Remove virtual environment directory
remove_venv

echo "Cleanup process completed."
