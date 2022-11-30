@echo off
cd .venv
cd Scripts
activate
cd ../..
pip install -r requirements.txt

cls
python main.py

set /p tmp = Hit Enter to close...