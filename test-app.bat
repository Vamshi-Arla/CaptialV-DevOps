@echo off
echo === Running Pre-Build Static Validation on Windows ===

REM Check if index.html exists
if not exist "index.html" (
    echo ERROR: Required index.html file missing!
    exit /b 1
)

REM Check if closing html tag exists using findstr
findstr /C:"</html>" index.html >nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: index.html is missing closing HTML tags!
    exit /b 1
)

echo === Static Validation Passed Successfully ===
exit /b 0
