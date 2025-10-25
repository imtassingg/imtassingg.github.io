@echo off
setlocal EnableDelayedExpansion

:: Obtener fecha y hora (tu código actual)
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (
    set dia=%%a
    set fecha=%%b-%%c-%%d
)
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
    set hora=%%a
    set min=%%b
)


set timestamp=%dia%. %fecha%_%hora%-%min%

:: Pedir al usuario que ingrese la ruta destino
set /p DESTINO="Choose a route for backup (DRBackupCreator needs it) >> "

:: Confirmar que la ruta existe o crearla
if not exist "%DESTINO%" (
    echo The route doesn't exist, creating...
    mkdir "%DESTINO%"
)

:: Variables de origen y destino
set ORIGEN=%LOCALAPPDATA%\DELTARUNE

:: Crear backup
xcopy "%ORIGEN%" "%DESTINO%\%timestamp%" /E /I /Y >nul

:: Crear/actualizar log
set LOG=F:\backup de deltarune\log_backup.txt
echo [%timestamp%] Backup its in: %DESTINO%\%timestamp% >> "%LOG%"

:: Confirmación
echo ====================================
echo Backup of DELTARUNE finished.
echo Saved in: %DESTINO%\%timestamp%
echo Log Updated: %LOG%
echo ====================================
pause
