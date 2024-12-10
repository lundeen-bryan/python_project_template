import toml
import argparse
import re
import rich_click as click

click.rich_click.USE_MARKDOWN=True
click.rich_click.MAX_WIDTH = 72

@click.command(
    context_settings=dict(help_option_names=['-h', '--help']),
    help="""
    # GET PYPROJECT VERSION

    This will return the version number in your pyproject.toml

    """
)
@click.option(
    "--file",
    default="./pyproject.toml",
    show_default=True,
)
@click.option(
    "--section",
    default="project",
    show_default=True,
)
@click.option(
    "--key",
    default="version",
    show_default=True,
)
def read_toml_value(file, section, key):
    try:
        data = toml.load(file)

        value = data.get(section, {}).get(key)
        if value is None:
            raise KeyError(f"Key '{key}' not found in section '{section}'")
        print(f"Current version: {value}")
        return value
    except Exception as e:
        raise RunTimeError(f"Error reading TOML file: {e}")

if __name__ == '__main__':
    read_toml_value()