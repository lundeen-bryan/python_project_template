import os
import json
import sys
import glob
import importlib
import logging

logger = logging.getLogger(__name__)

# Define the import directory
import_dir = os.path.abspath(
    os.path.join(os.path.dirname(__file__), "..", "imports")
)
print(f"\nImporting from: \n{import_dir}\n")

# Add the import directory to the Python module search path
sys.path.append(import_dir)

# Load the configuration file
def load_config():
    global config_data
    config_path = os.path.join(import_dir, "./config.json")
    with open(config_path, "r") as con:
        config_data = json.load(con)
    print("This is what the config file looks like:")
    print(json.dumps(config_data, indent=4))


# Import all modules from the import directory
def import_modules():
    global imported_modules
    imported_modules = {}
    try:
        modules = glob.glob(os.path.join(import_dir, "*.py"))
        for module in modules:
            if module.endswith(".py"):
                module_name = module.replace(os.path.sep, ".").replace(
                    ".py", ""
                )[len(import_dir) + 1 :]
                imported_modules[
                    module_name.split(".")[-1]
                ] = importlib.import_module(module_name)
    except ImportError as e:
        logger.error(f"Error importing module {module_name}: {e}")
    print("Imported modules:")
    for key, value in imported_modules.items():
        print(f"{key}: {value}")
    print()


def main():
    ...


if __name__ == "__main__":
    import_modules()
    main()
