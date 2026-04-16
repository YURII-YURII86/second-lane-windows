@echo off
REM Second Lane
REM Copyright (c) 2026 Yurii Slepnev
REM Licensed under the Apache License, Version 2.0.
REM Official: https://t.me/yurii_yurii86 | https://youtube.com/@yurii_yurii86 | https://instagram.com/yurii_yurii86

REM Force UTF-8 console so Russian messages do not turn into mojibake
REM on English-localized Windows. Safe no-op on ru-RU systems.
chcp 65001 >nul 2>nul

setlocal
cd /d "%~dp0"

REM -----------------------------------------------------------------
REM Preferred: Python 3.13 via the py launcher.
REM Fallback order: py -3.13  ->  py -3.12  ->  py (default)  ->  python
REM We still RECOMMEND 3.13 (pydantic 2.9.2 tested against it), but we
REM try to launch on adjacent versions with a warning rather than
REM leaving a beginner stuck at a dead end.
REM -----------------------------------------------------------------

where py >nul 2>nul
if %errorlevel%==0 (
  py -3.13 -c "import sys" >nul 2>nul
  if not errorlevel 1 (
    py -3.13 gpts_agent_control.py
    goto :eof
  )
  py -3.12 -c "import sys" >nul 2>nul
  if not errorlevel 1 (
    echo [warn] Python 3.13 not found, trying Python 3.12...
    echo [warn] Recommended version is 3.13. See docs if something breaks.
    py -3.12 gpts_agent_control.py
    goto :eof
  )
  py -c "import sys" >nul 2>nul
  if not errorlevel 1 (
    echo [warn] Python 3.13/3.12 not found, trying default Python via py launcher.
    echo [warn] Recommended version is 3.13. See docs if something breaks.
    py gpts_agent_control.py
    goto :eof
  )
)

where python >nul 2>nul
if %errorlevel%==0 (
  echo [warn] py launcher not found, trying plain 'python'.
  echo [warn] Recommended version is 3.13. See docs if something breaks.
  python gpts_agent_control.py
  goto :eof
)

echo.
echo =========================================================
echo   Python not found on this computer.
echo   Для Secondary LANE нужен Python 3.13 (Windows).
echo =========================================================
echo.
echo Что сделать:
echo 1. Открой страницу: https://www.python.org/downloads/windows/
echo 2. Скачай Python 3.13 для Windows (64-bit installer).
echo 3. При установке ОБЯЗАТЕЛЬНО отметь "Add python.exe to PATH".
echo 4. Перезагрузи компьютер.
echo 5. Снова запусти этот .bat двойным кликом.
echo.
echo Проверить установку можно командой в новом окне cmd:
echo   py -3.13 --version
echo.
pause
