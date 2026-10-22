@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Life Archive Sync

echo ==========================================
echo   Life Archive - Sync
echo ==========================================
echo.

echo [1/3] Pulling from GitHub...
git pull --rebase --autostash
if errorlevel 1 (
    echo.
    echo [ERROR] Pull failed. There may be a conflict.
    echo Open this folder in a terminal and run: git status
    echo.
    pause
    exit /b 1
)

echo.
echo [2/3] Committing local changes...
git add -A
git commit -m "sync: %date% %time%" >nul 2>&1
if errorlevel 1 (
    echo No local changes to commit.
) else (
    echo Local changes committed.
)

echo.
echo [3/3] Pushing to GitHub...
git push
if errorlevel 1 (
    echo.
    echo [ERROR] Push failed. Check your network or proxy.
    echo.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo   Done. Everything is in sync.
echo ==========================================
echo.
pause
