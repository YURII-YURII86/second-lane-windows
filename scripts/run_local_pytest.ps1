#!/usr/bin/env pwsh
# Second Lane
# Copyright (c) 2026 Yurii Slepnev
# Licensed under the Apache License, Version 2.0.
# Official: https://t.me/yurii_yurii86 | https://youtube.com/@yurii_yurii86 | https://instagram.com/yurii_yurii86
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# See verify_local.ps1 for the rationale behind Invoke-Checked.
function Invoke-Checked {
  param([string]$Label, [scriptblock]$Block)
  & $Block
  if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: $Label failed (exit code $LASTEXITCODE)." -ForegroundColor Red
    Write-Host "Fix this before re-running." -ForegroundColor Red
    exit $LASTEXITCODE
  }
}

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
    Invoke-Checked "create venv (py -3.13)" { py -3.13 -m venv $VenvDir }
  } else {
    Invoke-Checked "create venv (python)" { python -m venv $VenvDir }
  }
  $PythonExe = Join-Path $VenvDir "Scripts\python.exe"
}

if (-not (Test-Path $PythonExe)) {
  Write-Host "ERROR: expected Python at $PythonExe but it is missing." -ForegroundColor Red
  exit 1
}

$StampFile = Join-Path (Split-Path $PythonExe -Parent | Split-Path -Parent) ".requirements_installed"
if (-not (Test-Path $StampFile) -or ((Get-Item (Join-Path $ProjectDir "requirements.txt")).LastWriteTimeUtc -gt (Get-Item $StampFile -ErrorAction SilentlyContinue).LastWriteTimeUtc)) {
  Invoke-Checked "pip upgrade" { & $PythonExe -m pip install --upgrade pip }
  Invoke-Checked "pip install -r requirements.txt" { & $PythonExe -m pip install -r (Join-Path $ProjectDir "requirements.txt") }
  New-Item -ItemType File -Force -Path $StampFile | Out-Null
}

$Targets = @($args)
if ($Targets.Count -eq 0) {
  $Targets = @("tests/test_smoke.py", "tests/test_project_memory_smoke.py", "tests/test_super_actions.py")
}

Push-Location $ProjectDir
try {
  & $PythonExe -m pytest -q @Targets
} finally {
  Pop-Location
}
