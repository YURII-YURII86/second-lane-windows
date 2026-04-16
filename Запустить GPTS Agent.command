#!/bin/zsh
# Second Lane
# Copyright (c) 2026 Yurii Slepnev
# Licensed under the Apache License, Version 2.0.
#
# This is a macOS helper for the maintainer / developer use only.
# Windows users: run "Запустить GPTS Agent.bat" instead.
# This .command file is NOT executed by Windows Explorer.

case "$OSTYPE" in
  darwin*) ;;
  *)
    echo "This launcher is for macOS only."
    echo "On Windows, double-click: Запустить GPTS Agent.bat"
    echo "On Linux, run: python3.13 gpts_agent_control.py"
    exit 1
    ;;
esac

cd "$(dirname "$0")"
python3.13 gpts_agent_control.py
