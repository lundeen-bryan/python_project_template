from setuptools import setup, find_packages

setup(
    name='cli_tools', # rename this to match your project name
    version='1.0.0',
    author='lundeen-bryan',
    description='Command-line tools for various tasks.',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',  # If you're using Markdown for the README
    url='Enter your URL here',
    license='MIT',
    keywords='cli, tools, command-line, click',
    packages=find_packages(where='imports'),
    package_dir={'': 'imports'},
    include_package_data=True,
    install_requires=[
        'rich_click',
    ],
    entry_points={
        'console_scripts': [
            'scripts=list_scripts:list_console_scripts'
        ]
    },
    classifiers=[
        'Programming Language :: Python :: 3'
    ],
    python_requires='>=3.6',
)
