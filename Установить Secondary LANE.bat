@echo off
chcp 65001 >nul 2>nul
setlocal EnableDelayedExpansion
cd /d "%~dp0"

set "SCRIPT=%~dp0second_lane_installer.py"
set "PYEXE="
set "PYWEXE="

:resolvepython
set "PYEXE="
set "PYWEXE="
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
"!PYEXE!" -c "import tkinter as tk; root=tk.Tk(); root.withdraw(); root.update_idletasks(); root.destroy()" >nul 2>nul
if errorlevel 1 goto :notk

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
echo   This installer needs Python 3.13 to show the setup window.
echo =========================================================
echo.
echo What to do:
echo 1. Browser will open the Python 3.13 download page.
echo 2. Install Python 3.13 for Windows.
echo 3. IMPORTANT: check "Add python.exe to PATH".
echo 4. After the install finishes, come back to this window.
echo 5. Press Enter here and I will try again automatically.
echo.
start "" "https://www.python.org/downloads/windows/"
:retryafterpython
set /p _retry="Press Enter to re-check Python, or type Q to quit: "
if /I "!_retry!"=="Q" goto :eof
goto :resolvepython

:notk
echo.
echo =========================================================
echo   Python was found, but its GUI components are not ready.
echo =========================================================
echo.
echo What to do:
echo 1. Reinstall Python 3.13 from python.org.
echo 2. Use the full Windows installer, not a minimal or embedded build.
echo 3. Then come back here and press Enter to try again.
echo.
start "" "https://www.python.org/downloads/windows/"
set /p _retrytk="Press Enter to re-check Python GUI, or type Q to quit: "
if /I "!_retrytk!"=="Q" goto :eof
goto :resolvepython
