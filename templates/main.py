# main.py - Version 1.1
# This script dynamically imports Python modules from a specified directory
# and provides a template for main application logic.

import os
import json
import sys
import glob
import importlib
import logging

# Configure basic logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Define the import directory for external modules
# The directory is set relative to this script's location
import_dir = os.path.abspath(
    os.path.join(os.path.dirname(__file__), "..", "imports")
)
logger.info(f"Importing modules from: {import_dir}")

# Add the import directory to the system path to enable module imports
sys.path.append(import_dir)

def load_config():
    """
    Load a configuration file from the import directory.
    Returns a dictionary containing configuration data.
    """
    config_path = os.path.join(import_dir, "config.json")
    try:
        with open(config_path, "r") as con:
            logger.info(f"Loading configuration file: {config_path}")
            return json.load(con)
    except Exception as e:
        logger.error(f"Error loading config file: {e}")
        return {}

config_data = load_config()

def import_modules():
    """
    Dynamically import all Python modules (.py files) from the import directory.
    Returns a dictionary with module names as keys and module objects as values.
    """
    imported_modules = {}
    modules = glob.glob(os.path.join(import_dir, "*.py"))
    for module in modules:
        if module.endswith(".py"):
            module_name = os.path.basename(module).replace(".py", "")
            try:
                imported_modules[module_name] = importlib.import_module(module_name)
            except ImportError as e:
                logger.error(f"Error importing module {module_name}: {e}")
    return imported_modules

def main():
    """
    The main function of the application.
    Use this function to call functions or classes from the dynamically imported modules.
    Example: (given that the module_name is 'myapp' and the function_name is 'function_name'):
        imported_modules['myapp'].function_name()
    ---
    We can also retreive information from the configuration file.
    Example:
        version = config_data.get("app_notes", {}).get("version", "unknown version")
        logger.info(f"Application version: {version}")
    """
    # Enter application logic below:
    # Use snippets from .vscode folder (gentry) and (loadrunapp)
    ...

if __name__ == "__main__":
    # Import modules and start the main application
    imported_modules = import_modules()
    main()

