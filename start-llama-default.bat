@echo off
chcp 65001 >nul
title Llama.cpp Server Launcher [default]
::--------------------------------------------------------
set MODEL_DIR=models
set THREADS=4
set GPU_LAYERS=99
set CONTEXT_SIZE=32768
set MAX_TOKENS=-1
set BATCH_SIZE=4096
set /a U_BATCH_SIZE=%BATCH_SIZE% / 4
set PORT=8080
set HOST=0.0.0.0
set CORS_ORIGINS=*
::--------------------------------------------------------
if not exist "%MODEL_DIR%" (
    echo [ERROR] Model directory "%MODEL_DIR%" not found. Please verify your folder structure.
    pause
    exit /b
)

for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4 Address"') do (
    set LOCAL_IP=%%a
    goto :found_ip
)
:found_ip
set LOCAL_IP=%LOCAL_IP: =%

echo Starting Llama-server (default)...
echo Model Directory   : %MODEL_DIR%
echo GPU Layers        : %GPU_LAYERS%
echo Context Size      : %CONTEXT_SIZE%
echo CPU Threads       : %THREADS%
echo Batch Size        : %BATCH_SIZE%
echo U-Batch Size      : %U_BATCH_SIZE%
echo Max Tokens        : %MAX_TOKENS%
echo Host Binding      : %HOST%
echo Localhost Access  : http://127.0.0.1:%PORT%
echo Network Access    : http://%LOCAL_IP%:%PORT%
echo --------------------------------------------------------
llama-server.exe --models-dir ./%MODEL_DIR% -t %THREADS% -ngl %GPU_LAYERS% -c %CONTEXT_SIZE% -n %MAX_TOKENS% -fa on -b %BATCH_SIZE% -ub %U_BATCH_SIZE% --port %PORT% --host %HOST% --cors-origins "%CORS_ORIGINS%"
pause
