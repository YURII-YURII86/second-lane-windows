@echo off
setlocal
cd /d "%~dp0"

where py >nul 2>nul
if %errorlevel%==0 (
  py -3.13 gpts_agent_control.py
  goto :eof
)

where python >nul 2>nul
if %errorlevel%==0 (
  python gpts_agent_control.py
  goto :eof
)

echo Не найден Python. Для этой Windows-версии нужен Python 3.13.
pause
