#!/bin/bash

# Clear the terminal screen
clr

# Get the current project directory
project_dir=$(pwd)

# Define the default Python executable path based on the presence of a .venv folder
default_python_executable="$project_dir/.venv/Scripts/python.exe"

# Prompt the user for the path to the Python executable with the default value
read -p "Enter the path to the Python executable 
  [$default_python_executable]: " python_executable

# Use the default value if the user doesn't provide one
python_executable=${python_executable:-$default_python_executable}

# Check if the Python executable exists
if [ -x "$python_executable" ]; then
  # Create a temporary alias for the Python executable
  alias mypy="$python_executable"
  echo "Alias 'mypy' created for '$python_executable'."
  echo "From this point forward, you can run Python scripts 
    using 'mypy' followed by the path to the Python file."
  echo "Example: mypy /path/to/your/python_script.py"
else
  echo "Python executable not found at '$python_executable'. 
    Alias not created."
fi
