@echo off
setlocal

set "PBO=C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe"

for /d %%F in ("%~dp0*") do (
    echo.
    echo Packing %%~nxF...
    "%PBO%" -pack "%%~fF" "%%~fF.pbo"
)

echo.
echo All folders packed.
pause