#!/usr/bin/env pwsh
# Second Lane
# Copyright (c) 2026 Yurii Slepnev
# Licensed under the Apache License, Version 2.0.
# Official: https://t.me/yurii_yurii86 | https://youtube.com/@yurii_yurii86 | https://instagram.com/yurii_yurii86
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ProjectDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$VenvDir = Join-Path $ProjectDir ".venv"
$LegacyVenvDir = Join-Path $ProjectDir ".venv313"

if (Test-Path (Join-Path $VenvDir "Scripts\python.exe")) {
  $PythonExe = Join-Path $VenvDir "Scripts\python.exe"
} elseif (Test-Path (Join-Path $LegacyVenvDir "Scripts\python.exe")) {
  $PythonExe = Join-Path $LegacyVenvDir "Scripts\python.exe"
  Write-Host "Using legacy local venv at $LegacyVenvDir"
} else {
  if (Get-Command py -ErrorAction SilentlyContinue) {
    py -3.13 -m venv $VenvDir
  } else {
    python -m venv $VenvDir
  }
  $PythonExe = Join-Path $VenvDir "Scripts\python.exe"
}

$StampFile = Join-Path (Split-Path $PythonExe -Parent | Split-Path -Parent) ".requirements_installed"
if (-not (Test-Path $StampFile) -or ((Get-Item (Join-Path $ProjectDir "requirements.txt")).LastWriteTimeUtc -gt (Get-Item $StampFile -ErrorAction SilentlyContinue).LastWriteTimeUtc)) {
  & $PythonExe -m pip install --upgrade pip
  & $PythonExe -m pip install -r (Join-Path $ProjectDir "requirements.txt")
  New-Item -ItemType File -Force -Path $StampFile | Out-Null
}

Push-Location $ProjectDir
try {
  & $PythonExe scripts\smoke_local.py
} finally {
  Pop-Location
}
