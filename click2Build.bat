@echo off
title Compilazione Normal Map Separator
echo.

:: Move to the folder where this .bat file lives
cd /d %~dp0

:: ──────────────────────────────────────────────────────
:: STEP 1 – Ensure the virtual environment is ready
:: ──────────────────────────────────────────────────────
set VENV_DIR=.venv

echo Verifica dell'ambiente virtuale...

:: If .venv is missing or pip is missing inside it, recreate from scratch
if not exist "%VENV_DIR%\Scripts\pip.exe" (
    echo Ambiente virtuale non trovato o incompleto. Creazione in corso...
    if exist "%VENV_DIR%" rd /s /q "%VENV_DIR%"
    python -m venv "%VENV_DIR%"
    if errorlevel 1 (
        echo ERRORE: impossibile creare l'ambiente virtuale. Assicurati che Python sia installato.
        pause
        exit /b 1
    )
    echo Ambiente virtuale creato.
)

:: Activate the virtual environment
call "%VENV_DIR%\Scripts\activate.bat"

:: Install / update dependencies
echo Installazione delle dipendenze da requirements.txt...
pip install -r requirements.txt --quiet
if errorlevel 1 (
    echo ERRORE: installazione delle dipendenze fallita.
    call "%VENV_DIR%\Scripts\deactivate.bat" 2>nul
    pause
    exit /b 1
)

echo Ambiente virtuale pronto.
echo.

:: ──────────────────────────────────────────────────────
:: STEP 2 – Build
:: ──────────────────────────────────────────────────────
echo Avvio della build con PyInstaller...
echo.

pyinstaller --onefile --windowed --icon=normal_icon.ico --add-data "normal_icon.png;." Normal2Mesh.py

if errorlevel 1 (
    echo.
    echo ERRORE: la build e' fallita.
    call "%VENV_DIR%\Scripts\deactivate.bat" 2>nul
    pause
    exit /b 1
)

echo.
echo ==================================================
echo Build completata! Troverai l'eseguibile (.exe)
echo all'interno della cartella dist.
echo ==================================================
echo.

:: ──────────────────────────────────────────────────────
:: STEP 3 – Reset: deactivate and remove the venv
:: ──────────────────────────────────────────────────────
call "%VENV_DIR%\Scripts\deactivate.bat" 2>nul
echo Pulizia: rimozione dell'ambiente virtuale...
rd /s /q "%VENV_DIR%"
echo Ambiente virtuale rimosso.
echo.

pause