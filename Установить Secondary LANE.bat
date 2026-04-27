@echo off
chcp 65001 >nul 2>nul
setlocal EnableDelayedExpansion
cd /d "%~dp0"

set "SCRIPT=%~dp0second_lane_installer.py"
set "PYEXE="

where py >nul 2>nul
if %errorlevel%==0 (
    for /f "delims=" %%i in ('py -3.13 -c "import sys; print(sys.executable)" 2^>nul') do set "PYEXE=%%i"
    if not defined PYEXE (
        for /f "delims=" %%i in ('py -c "import sys; print(sys.executable)" 2^>nul') do set "PYEXE=%%i"
    )
)

if not defined PYEXE (
    where python >nul 2>nul
    if %errorlevel%==0 (
        for /f "delims=" %%i in ('python -c "import sys; print(sys.executable)" 2^>nul') do set "PYEXE=%%i"
    )
)

if not defined PYEXE goto :nopython

set "PYWEXE=!PYEXE:python.exe=pythonw.exe!"
if exist "!PYWEXE!" (
    start "" "!PYWEXE!" "!SCRIPT!"
    goto :eof
)

start "" "!PYEXE!" "!SCRIPT!"
goto :eof

:nopython
echo.
echo =========================================================
echo   Python not found on this computer.
echo   This installer needs Python to show the setup window.
echo =========================================================
echo.
echo What to do:
echo 1. Browser will open the Python 3.13 download page.
echo 2. Install Python 3.13 for Windows.
echo 3. IMPORTANT: check "Add python.exe to PATH".
echo 4. Then double-click this installer again.
echo.
start "" "https://www.python.org/downloads/windows/"
pause
