<div align='center'>

# CREATE PYTHON PROJECT

*brief description*

</div>

__Table of Contents__

<!-- TOC -->

- [About](#about)

<!-- /TOC -->

## About

This 'Python Project Folders' extension helps in setting up a structured Python project environment. It enhances the 'Python Project Template' by raghavwastaken1, offering additional folders, README and changelog templates, and a run.sh script for environment setup and execution. As a new version of an existing concept, it simplifies project initiation and management for Python developers.

**Note:** remember to use "chmod +x" before every bash script. For example:
```chmod +x run.sh```

## Documentation

### Setup and Dependency Management (`run.sh`)

**Description**

`run.sh` is a Bash script designed to automate the setup of a Python development environment. It performs several tasks including creating a Python virtual environment, optionally upgrading pip, installing dependencies from a `requirements.txt` file, and potentially executing a Python script. The script provides interactive prompts to guide the user through each step.

**Parameters**

1. **Python Executable Path**: Path to the Python interpreter.
2. **Virtual Environment Name**: Name for the virtual environment (default is `.venv`).
3. **User Choices**: Various yes/no choices for proceeding with the script, upgrading pip, and running a Python script.

**Preconditions**

* **Python Installation**: Python must be installed on the system.
* **Bash Shell**: The script is intended to be run in a Bash shell environment.
* **`requirements.txt` File**: This file should be present in the same directory as the script, containing the list of Python packages to install.

**Limitations**

* **Platform Dependency**: The script is tailored for environments where Bash is available, primarily UNIX-like systems. It may not work as intended on non-UNIX systems like Windows without modifications.
* **Error Handling**: While the script has basic error handling, more complex or unexpected errors might not be managed effectively.
* **Python Version**: The script does not handle different Python versions or manage multiple versions.

**Example Usage**

1. **Running the Script**: Execute the script in the terminal with `./run.sh`.
2. **Providing Inputs**:
   * Enter the path to the Python executable when prompted.
   * Choose a name for the virtual environment or leave it as the default.
   * Respond to prompts about upgrading pip, installing dependencies, and running a Python script.
3. **Outcome**: The script will create a virtual environment, install specified packages, and optionally run a Python script.

**Sample Output**

```bash
$ ./run.sh This script has a few prerequisites: ...
Do you want to continue? (yes/no) yes
Enter the path to the Python executable: /usr/bin/python3
Enter the virtual environment name (default: .venv):
Creating virtual environment. Please wait...
Virtual environment created. Press Enter to activate and install dependencies...
Do you want to run main.py? (yes/no) yes
```

[⭡backtotop](#readme)

---

### [Python Package Version Manager (`update_package.sh`)](path-to-write-package-sh-doc)

**Description**

`update_package.sh` is a Bash script designed to manage and update Python package versions in a `requirements.txt` file. It allows users to add new packages or update existing packages to their latest versions available on PyPI (Python Package Index). The script includes interactive prompts for user input and incorporates error handling to guide the process.

**Parameters**

1. **Python Executable Path**: Path to the Python interpreter used for package management.
2. **Package Name**: Name of the Python package to be added or updated in the `requirements.txt` file.

**Preconditions**

* **Python Installation**: Python must be installed on the system.
* **Bash Shell**: The script is intended to be run in a Bash shell environment.
* **`requests` Package**: The Python `requests` package should be installed, as it is used to fetch package information from PyPI.
* **`requirements.txt` File**: This file should be present in the directory from which the script is run. It is used to list Python packages and their versions.

**Limitations**

* **Platform Dependency**: This script is primarily designed for UNIX-like systems and might require adjustments for other environments.
* **Internet Connection**: The script requires an active internet connection to fetch package information from PyPI.
* **Package Availability**: The script only works with packages available on PyPI.
* **Error Handling**: While the script includes basic error handling, complex errors related to network issues, Python environment problems, or incorrect package names might not be handled effectively.

**Example Usage**

1. **Running the Script**: Start the script by executing `./update_package.sh` in the terminal.
2. **Providing Inputs**:
   * Enter the path to the Python executable when prompted.
   * Input the package name for which you want to update or add to the `requirements.txt` file.
3. **Iterative Process**: The script can be used iteratively to add or update multiple packages.

**Sample Output**

```bash
$ ./update_package.sh Enter the path to the Python executable: /usr/bin/python3
This script will write a package name and the latest version number to the requirements file.
Do you want to continue? (yes/no): yes
Enter the package name: requests
Package 'requests' (version 2.25.1) has been added to requirements.txt.
Do you want to add another package? (yes/no): no
Script execution completed.
```

[⭡backtotop](#readme)

---

### [Dynamic Module Importer and Config Loader (`main.py`)](path-to-main-py-doc)

**Description**

`main.py` is a Python script designed for dynamically importing modules and loading configuration data. It primarily focuses on adding flexibility and modularity to Python applications. The script adds a specified import directory to the Python module search path, loads a JSON configuration file, and dynamically imports Python modules from the specified directory.

**Parameters**

This script does not take command-line parameters but relies on the following:

1. **Import Directory**: A predefined directory from which the script imports modules. It is typically a subdirectory relative to the script's location.
2. **Configuration File**: A JSON file (`config.json`) located in the import directory.

**Preconditions**

* **Python Installation**: Python must be installed on the system.
* **Configuration File**: A valid JSON configuration file named `config.json` must be present in the import directory.
* **Module Files**: Python module files (`.py`) to be dynamically imported should exist in the import directory.

**Limitations**

* **Error Handling**: Errors during dynamic import or configuration loading are logged but may not be handled comprehensively.
* **Security**: Dynamic importing of modules could pose a security risk if not properly managed, especially when dealing with untrusted sources.
* **Dependency Management**: The script assumes that all dependencies required by the dynamically imported modules are already installed and available.

**Example Usage**

1. **Running the Script**: Execute the script using a Python interpreter: `python main.py`.
2. **Outcome**: The script will dynamically import modules from the specified directory and load configuration data from the `config.json` file.

**Sample Output**

```python
$ python main.py

Importing from:
/path/to/imports

This is what the config file looks like:
{
	"key": "value",
	...
}

Imported modules: module1:
module 'module1' from '/path/to/imports/module1.py'
module2: module 'module2' from '/path/to/imports/module2.py'
...
```

---

[⭡backtotop](#readme)

## Author Info

- Github - [lundeen-bryan](https://github.com/lundeen-bryan)
- LinkedIn - [BryanLundeen](https://www.linkedin.com/in/bryanlundeen/)
- Twitter – [@LundeenBryan](https://twitter.com/LundeenBryan)
- Facebook – [realbryanlundeen](https://www.facebook.com/realbryanlundeen)

[⭡backtotop](#readme)
