@echo off
setlocal

:: Function to check if Chocolatey is installed
:CheckChoco
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is not installed. Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "Set-ExecutionPolicy Bypass -Scope Process -Force; ^
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ^
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    if %errorlevel% neq 0 (
        echo Failed to install Chocolatey.
        exit /b 1
    )
) else (
    echo Chocolatey is already installed.
)

:: Ensure running as admin
:CheckAdmin
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges. Please run as administrator.
    exit /b 1
)

:: Install Python 3.12.3 using Chocolatey
echo Installing Python 3.12.3...
choco install python --version=3.12.3 -y
if %errorlevel% neq 0 (
    echo Failed to install Python 3.12.3.
    exit /b 1
)

echo Python 3.12.3 installed successfully.
python --version
if %errorlevel% neq 0 (
    echo Python installation verification failed.
    exit /b 1
)

:: Install discord.py using pip
echo Installing discord.py...
python -m pip install discord.py
if %errorlevel% neq 0 (
    echo Failed to install discord.py.
    exit /b 1
)

echo discord.py installed successfully.
endlocal
pause
