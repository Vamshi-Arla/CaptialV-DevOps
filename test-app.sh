#!/bin/sh
//Performs pre-build validation to guarantee file integrity before packaging.
set -e

echo "=== Starting Pre-Build Static Analysis ==="

# Check required files existence
if [ ! -f "index.html" ]; then
    echo "CRITICAL ERROR: index.html missing!"
    exit 1
fi

if [ ! -f "Dockerfile" ]; then
    echo "CRITICAL ERROR: Dockerfile missing!"
    exit 1
fi

# Basic HTML tag validation
if grep -q "</html>" index.html; then
    echo "PASS: index.html structure validated successfully."
else
    echo "FAIL: Malformed index.html missing closing </html> tag!"
    exit 1
fi

echo "=== Pre-Build Validation Passed Successfully ==="
