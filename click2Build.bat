@echo off
title Compilazione Normal Map Separator
echo.
echo Avvio della build con PyInstaller...
echo.

 Sposta l'esecuzione nella cartella esatta in cui si trova questo file .bat
cd d %~dp0

 Esegue il comando di build
pyinstaller --onefile --windowed --icon=normal_icon.ico --add-data "normal_icon.png;." Normal2Mesh.py

echo.
echo ==================================================
echo Build completata! Troverai l'eseguibile (.exe) 
echo all'interno della cartella dist.
echo ==================================================
echo.

pause