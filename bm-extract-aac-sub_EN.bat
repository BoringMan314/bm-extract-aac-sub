@echo off
chcp 65001 >nul
color 0b
cls
title [B.M] Audio Subtitle Extractor (AAC + Sub) By. [B.M] 圓周率 3.14
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
set "PS1=%SCRIPT_DIR%bm-extract-aac-sub.ps1"
set "INPUT_LIST=%TEMP%\extract_inputs_%RANDOM%_%RANDOM%.txt"

if not exist "%PS1%" (
    echo [ERROR] Missing script: "%PS1%"
    pause
    exit /b 1
)

if "%~1"=="" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1%" -Language EN
    goto :AfterRun
)

break > "%INPUT_LIST%"
:ArgLoop
if "%~1"=="" goto :RunWithList
>> "%INPUT_LIST%" echo("%~f1"
shift
goto :ArgLoop

:RunWithList
powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1%" -Language EN -InputListFile "%INPUT_LIST%"

:AfterRun
set "RC=%ERRORLEVEL%"
if exist "%INPUT_LIST%" del /q "%INPUT_LIST%" >nul 2>nul
echo.
if not defined BM_NO_PAUSE pause
exit /b %RC%
