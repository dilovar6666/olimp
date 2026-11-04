@echo off
setlocal enabledelayedexpansion
title GitHub Push - dilovar6666/olimp

set "PATH=%LOCALAPPDATA%\MinGit\cmd;%LOCALAPPDATA%\MinGit\ucrt64\bin;%LOCALAPPDATA%\MinGit\usr\bin;%PATH%"
cd /d "%~dp0"

echo ===================================================
echo     GitHub Push: https://github.com/dilovar6666/olimp
echo ===================================================
echo.

echo [1] Simple Push (Open Browser Login)
echo [2] Push with Token
echo [3] Generate Token on GitHub
echo.
set /p choice="Select (1, 2, or 3): "

if "%choice%"=="2" goto with_token
if "%choice%"=="3" goto open_token_url

:simple_push
echo.
echo Running: git push -u origin main...
git push -u origin main
goto end

:open_token_url
start "" "https://github.com/settings/tokens/new?scopes=repo&description=olimp_upload"
echo GitHub opened in browser. Create token and copy it.
echo.

:with_token
set /p mytoken="Paste your GitHub Token: "
if "!mytoken!"=="" goto with_token
git remote set-url origin "https://dilovar6666:!mytoken!@github.com/dilovar6666/olimp.git"
echo Sending...
git push -u origin main
goto end

:end
echo.
pause
