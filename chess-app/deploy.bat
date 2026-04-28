@echo off
REM ============================================================================
REM Chess Application Automated Deployment Script (Windows)
REM This script builds and deploys the entire chess application in one go
REM ============================================================================

setlocal enabledelayedexpansion

REM Configuration
set "PROJECT_ROOT=%CD%"
set "CHESS_APP_DIR=%PROJECT_ROOT%\chess-app"
set "BACKEND_DIR=%CHESS_APP_DIR%\backend"

echo.
echo ================================
echo Chess Application Deployment
echo ================================
echo.

REM Step 1: Verify environment
echo [Step 1] Verifying environment...
if not exist "%CHESS_APP_DIR%" (
    echo Error: Chess app directory not found!
    exit /b 1
)
echo OK - Chess app directory found
echo.

REM Step 2: Build Backend
echo [Step 2] Building Java Backend...
cd /d "%BACKEND_DIR%"
call mvn clean package -DskipTests
if errorlevel 1 (
    echo Error: Backend build failed!
    exit /b 1
)
echo OK - Backend build complete
echo.

REM Step 3: Build Frontend
echo [Step 3] Building Frontend...
cd /d "%CHESS_APP_DIR%"
call npm install
if errorlevel 1 (
    echo Error: npm install failed!
    exit /b 1
)
call npm run build
if errorlevel 1 (
    echo Error: npm build failed!
    exit /b 1
)
echo OK - Frontend build complete
echo.

REM Step 4: Build Docker Image
echo [Step 4] Building Docker Image...
call docker build -t chess-app-backend:latest "%BACKEND_DIR%"
if errorlevel 1 (
    echo Error: Docker build failed!
    exit /b 1
)
echo OK - Docker image built
echo.

REM Step 5: Stop existing containers
echo [Step 5] Stopping existing containers...
call docker-compose down
echo OK - Containers stopped
echo.

REM Step 6: Start new containers
echo [Step 6] Starting application...
call docker-compose up -d
if errorlevel 1 (
    echo Error: Docker-compose failed!
    exit /b 1
)
echo OK - Containers started
echo.

REM Step 7: Wait for services
echo [Step 7] Waiting for services to be ready...
timeout /t 5 /nobreak
echo.

REM Step 8: Check status
echo [Step 8] Checking container status...
call docker-compose ps
echo.

REM Summary
echo.
echo ================================
echo DEPLOYMENT COMPLETE!
echo ================================
echo.
echo Chess Application is now RUNNING!
echo.
echo Access Points:
echo   Frontend:   http://localhost:3000
echo   Backend:    http://localhost:8080
echo   API Health: http://localhost:8080/api/health
echo.
echo Useful Commands:
echo   View logs:       docker-compose logs -f
echo   Stop service:    docker-compose down
echo   Restart service: docker-compose restart
echo   Backend logs:    docker logs chess-backend
echo   Frontend logs:   docker logs chess-frontend
echo.
echo Happy playing!
echo.

endlocal
