@echo off
chcp 65001 >nul
title Llama.cpp Server Launcher [Localhost]
::--------------------------------------------------------
set MODEL_DIR=models
set GPU_LAYERS=99
set CONTEXT_SIZE=32768
set THREADS=8
set BATCH_SIZE=4096
set /a U_BATCH_SIZE=%BATCH_SIZE% / 4
set PORT=8080
::--------------------------------------------------------
if not exist "%MODEL_DIR%" (
    echo [ERROR] Model directory "%MODEL_DIR%" not found. Please verify your folder structure.
    pause
    exit /b
)
echo Starting Llama-server (localhost)...
echo Model Directory   : %MODEL_DIR%
echo CPU Threads       : %THREADS%
echo GPU Layers        : %GPU_LAYERS%
echo Context Size      : %CONTEXT_SIZE%
echo Batch Size        : %BATCH_SIZE%
echo U-Batch Size      : %U_BATCH_SIZE%
echo Server Address    : http://127.0.0.1:%PORT%
echo --------------------------------------------------------
llama-server.exe --models-dir ./%MODEL_DIR% -t %THREADS% -ngl %GPU_LAYERS% -c %CONTEXT_SIZE% -n -1 -fa on -b %BATCH_SIZE% -ub %U_BATCH_SIZE% --port %PORT%
pause
