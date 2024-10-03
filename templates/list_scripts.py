import click
import importlib.metadata

@click.command(
    context_settings=dict(help_option_names=['-h', '--help']),
    help="""List all registered console_scripts in the current Python environment.

    This command scans the installed packages and lists all commands registered
    under the 'console_scripts' entry point group. It helps users discover available
    CLI tools without needing to manually check each package.

    Examples:

        $ list-scripts --help

    Output:

        - Command: add
          Module: imports.add:add

        - Command: subtract
          Module: imports.subtract:subtract

        - Command: auth
          Module: imports.auth:auth

    If no console_scripts are found, the command will display a message indicating
    that no commands are registered.
    """
)
def list_console_scripts():
    """
    Lists all console_scripts registered in the current environment.
    """
    # Fetch all entry points in the 'console_scripts' group
    entry_points = importlib.metadata.entry_points(group='console_scripts')

    if not entry_points:
        click.echo("No console_scripts found.")
        return

    click.echo("Registered console_scripts:")
    for entry_point in entry_points:
        click.echo(f"- Command: {entry_point.name}")
        click.echo(f"  Module: {entry_point.value}")
        click.echo()

if __name__ == "__main__":
    # Invoke the command and show the list directly when called with --help
    list_console_scripts()
