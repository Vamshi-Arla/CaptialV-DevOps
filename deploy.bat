@echo off
echo === Deploying Web Application to Target Directory ===

set TARGET_DIR=C:\inetpub\wwwroot\my-web-app

REM Create target directory if it does not exist
if not exist "%TARGET_DIR%" (
    echo Creating target folder %TARGET_DIR%...
    mkdir "%TARGET_DIR%"
)

REM Copy index.html to the web server directory
echo Copying application files to %TARGET_DIR%...
xcopy /Y /F "index.html" "%TARGET_DIR%\"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to copy application files!
    exit /b 1
)

echo === Deployment Completed Successfully ===
exit /b 0
