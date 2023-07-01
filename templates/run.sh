#!/bin/bash

# Function to handle error and exit the script
handle_error() {
  local error_message="${1:-An unspecified error occurred}"
  echo "Error: $error_message. Exiting..."
  exit 1
}

# Function to create a virtual environment
create_virtualenv() {
  echo "Creating virtual environment. Please wait..."
  "$python_exe" -m venv "$venv_name" || handle_error "Failed to create virtual environment"
}

# Function to add the hidden attribute to the .venv directory
add_hidden_attribute() {
  attrib +h "$venv_dir" || handle_error "Failed to hide the virtual environment directory"
}

# Function to install dependencies, using the virtual environment
install_dependencies() {
  source "$venv_dir/Scripts/activate" || handle_error "Failed to activate virtual environment"

  "$venv_dir/Scripts/activate" -m pip install --upgrade pip || handle_error "Failed to upgrade pip"

  if [[ ! -f requirements.txt ]]; then
    handle_error "requirements.txt file does not exist in the current directory"
  fi

  "$venv_dir/Scripts/pip" install --no-deps --no-upgrade -r requirements.txt || handle_error "Failed to install dependencies from requirements.txt"
}

# Function to validate user input
validate_input() {
  # Convert any backslashes in the path to forward slashes
  python_exe="${python_exe//\\//}"

  if [[ ! -x "$python_exe" ]]; then
    echo "Invalid Python executable path. Exiting..."
    exit 1
  fi

  if [[ "$run_main" != "yes" && "$run_main" != "no" ]]; then
    echo "Invalid choice for running main.py. Exiting..."
    exit 1
  fi
}

# Clear the terminal screen
clear

# Set up the trap to catch the SIGINT signal
trap 'echo "Installation interrupted. Exiting..."; exit 1' INT

# Prompt the user for the path to the Python executable
read -p "Enter the path to the Python executable: " python_exe

# Prompt the user for the virtual environment name
read -p "Enter the virtual environment name (default: .venv): " venv_name
venv_name=${venv_name:-.venv}

# Set the virtual environment directory
venv_dir="$PWD/$venv_name"

# Validate user input
validate_input

# Ask for confirmation before creating the virtual environment
read -p "About to create a new virtual environment at $venv_dir with Python executable $python_exe. Do you want to continue? (yes/no) " confirm
if [[ "$confirm" != "yes" ]]; then
  echo "Aborted by user. Exiting..."
  exit 0
fi

# Create the virtual environment
create_virtualenv

# Add the hidden attribute to the virtual environment directory
add_hidden_attribute

# Wait for the user to press any key before continuing
read -p "Virtual environment created. Press Enter to activate and install dependencies..."

# Install dependencies
install_dependencies

# Ask user if they want to run main.py
read -p "Do you want to run main.py? (yes/no) " run_main

# Execute the main.py Python script if the user answered "yes"
if [[ "$run_main" == "yes" ]]; then
  "$python_exe" ../src/main.py
fi

# Pause the script and wait for the user to press Enter
read -p "Hit Enter to close..."

