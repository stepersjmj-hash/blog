@echo off
cd /d "%~dp0"

set PORT=8000
set URL=http://localhost:%PORT%

echo ========================================
echo  Photo Blog Generator - Local Server
echo ========================================
echo.
echo Server URL: %URL%
echo Exit: Ctrl+C or close this window
echo.

REM Open browser before server starts
start "" "%URL%"

REM Try python first
where python >nul 2>nul
if %errorlevel%==0 (
    echo [Python] Starting server...
    python -m http.server %PORT%
    goto end
)

REM Try py (Python Launcher)
where py >nul 2>nul
if %errorlevel%==0 (
    echo [py] Starting server...
    py -m http.server %PORT%
    goto end
)

REM Try Node.js npx
where npx >nul 2>nul
if %errorlevel%==0 (
    echo [Node.js] Starting http-server...
    npx --yes http-server -p %PORT% -c-1
    goto end
)

REM All failed
echo.
echo [ERROR] Python or Node.js not found.
echo.
echo Install one of:
echo   1. Python from Microsoft Store (free) or https://www.python.org
echo   2. Node.js from https://nodejs.org
echo.
pause

:end
