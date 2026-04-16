@echo off
REM Second Lane
REM Copyright (c) 2026 Yurii Slepnev
REM Licensed under the Apache License, Version 2.0.
REM Official: https://t.me/yurii_yurii86 | https://youtube.com/@yurii_yurii86 | https://instagram.com/yurii_yurii86
setlocal
cd /d "%~dp0"

where py >nul 2>nul
if %errorlevel%==0 (
  py -3.13 gpts_agent_control.py
  goto :eof
)

echo Не найден launcher py с Python 3.13.
echo Для этой Windows-версии нужен именно Python 3.13.
echo.
echo Что сделать:
echo 1. Установи Python 3.13
echo 2. Проверь команду: py -3.13 --version
echo 3. Снова запусти этот .bat
pause
