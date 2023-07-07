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

  ask_upgrade_pip

  "$python_exe" -m pip install --no-deps -r requirements.txt || handle_error "Failed to install dependencies from requirements.txt"
}

# Function to validate user input
validate_path() {
  local path="${1}"
  # Convert any backslashes in the path to forward slashes
  path="${path//\\//}"

  if [[ ! -x "$path" ]]; then
    echo "Invalid path. Exiting..."
    exit 1
  fi
}

# Function to validate yes/no user input
validate_input() {
  local input="${1}"

  if [[ "$input" != "yes" && "$input" != "no" ]]; then
    echo "Invalid choice. You can only enter yes or no to this question. Exiting..."
    exit 1
  fi
}

# Function to ask user if they want to upgrade pip
ask_upgrade_pip() {
  pip_version=$("$python_exe" -m pip --version)
  echo "Current pip version is $pip_version"

  read -p "Do you want to upgrade pip to the latest version? (yes/no) " upgrade_pip
  validate_input "$upgrade_pip"

  if [[ "$upgrade_pip" == "yes" ]]; then
    echo "Upgrading pip. Please wait..."
    "$python_exe" -m pip install --upgrade pip || handle_error "Failed to upgrade pip"
  fi
}

# Preamble
echo "This script has a few prerequisites:"
echo "1. You should have a Python executable installed on your system."
echo "2. You should know the path to the Python executable."
echo "3. A requirements.txt file should be present in the same directory as this script."
echo "4. The requirements.txt file should specify exact versions of the packages to be installed."
echo ""
echo "If these prerequisites are met, the script will perform the following actions:"
echo "1. Create a Python virtual environment."
echo "2. Hide the virtual environment directory."
echo "3. Optionally, upgrade pip to the latest version in the virtual environment."
echo "4. Install the packages listed in requirements.txt within the virtual environment, without upgrading existing packages or installing dependencies."
echo "5. Optionally, run a Python script named main.py located in a subdirectory named src."
echo ""

# Ask for confirmation before proceeding
read -p "Do you want to continue? (yes/no) " proceed
validate_input "$proceed"
if [[ "$proceed" != "yes" ]]; then
  echo "Aborted by user. Exiting..."
  exit 0
fi

# Clear the terminal screen
clear

# Set up the trap to catch the SIGINT signal
trap 'echo "Installation interrupted. Exiting..."; exit 1' INT

# Prompt the user for the path to the Python executable
read -p "Enter the path to the Python executable: " python_exe
validate_path "$python_exe"

# Prompt the user for the virtual environment name
read -p "Enter the virtual environment name (default: .venv): " venv_name
venv_name=${venv_name:-.venv}

# Set the virtual environment directory
venv_dir="$PWD/$venv_name"

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
validate_input "$run_main"

# Execute the main.py Python script if the user answered "yes"
if [[ "$run_main" == "yes" ]]; then
  "$python_exe" ./src/main.py
fi

# Pause the script and wait for the user to press Enter
read -p "Hit Enter to close..."
