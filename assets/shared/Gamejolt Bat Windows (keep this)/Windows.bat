@echo off
cls
title Gamejolt Requirements Windows Auto-Downloader
echo Made by Razalzy, readded by Josephjr05
echo.
echo.
echo Installing Tentools...
echo.
haxelib git tentools https://github.com/TentaRJ/tentools.git
echo.
echo.
echo Installing Systools...
echo.
haxelib git systools https://github.com/haya3218/systools
echo.
echo.
echo Rebuilding Systools...
echo.
haxelib run lime rebuild systools windows
echo.
echo.
echo Downloaded! Press any key to close the app!
pause