@echo off
REM ============================================================================
REM Master Chess Application Deployment Script (Root Level)
REM Automatically finds and deploys chess-app
REM ============================================================================

setlocal enabledelayedexpansion

echo.
echo ============================================================================
echo                    CHESS APPLICATION DEPLOYMENT
echo ============================================================================
echo.

REM Find chess-app directory
if exist "chess-app" (
    set "CHESS_APP_DIR=chess-app"
    echo Found chess-app directory
) else if exist "%~dp0chess-app" (
    set "CHESS_APP_DIR=%~dp0chess-app"
    echo Found chess-app at root
) else (
    echo Error: chess-app directory not found!
    echo Please run this script from the project root directory
    pause
    exit /b 1
)

echo.
echo Starting deployment...
echo.

REM Change to chess-app directory and run deployment
cd /d "!CHESS_APP_DIR!"
call deploy.bat

endlocal
