import toml
import argparse
import re
import rich_click as click

click.rich_click.USE_MARKDOWN=True
click.rich_click.MAX_WIDTH = 72

@click.command(
    context_settings=dict(help_option_names=['-h', '--help']),
    help="""
    # BUMP THE PYPROJECT VERSION NUMBER

    This will bump the version number in your pyproject.toml

    **Arguments**
    - major
    - minor
    - patch
    """
)
@click.option(
    "--file",
    default="C:/Users/blundeen/AppData/Local/Apps/repos/today_reports/pyproject.toml",
    show_default=True,
)
@click.argument(
    "part",
    type=click.Choice([
        "major",
        "minor",
        "patch"
    ], case_sensitive=False),
)
def update_pyproject(file, part):
    try:
        #Load pyproject.toml
        # with open(file, 'r') as file:
        data = toml.load(file)

        # Find the current version
        version = data.get("project", {}).get("version")
        if not version or not re.match(r"^\d+\.\d+\.\d+$", version):
            raise ValueError("Invalid or missing version in pyproject.toml")

        # Bump the version
        new_version = bump_version(version, part)
        data["project"]["version"] = new_version

        # Save the updated pyproject.toml
        with open(file, 'w') as file:
            toml.dump(data, file)

        print(f"Version bumped from {version} to {new_version}")

    except Exception as e:
        print(f"Error: {e}")

def bump_version(version, part):
    parts = [int(p) for p in version.split('.')]
    if part == "major":
        parts[0] += 1
        parts[1] = 0
        parts[2] = 0
    elif part == "minor":
        parts[1] += 1
        parts[2] = 0
    elif part == "patch":
        parts[2] += 1
    return '.'.join(map(str, parts))

if __name__ == '__main__':
    update_pyproject()

