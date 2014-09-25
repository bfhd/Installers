REM Find out OS version

REM Windows XP
ver | findstr /i "5\.1\."
if %ERRORLEVEL% EQU 0 (
goto ver_xp
)

REM Windows 7/8/8.1
ver | findstr /i "6\.1\." > nul
if %ERRORLEVEL% EQU 0 (
goto ver_7
)
ver | findstr /i "6\.2\." > nul
if %ERRORLEVEL% EQU 0 (
goto ver_7
)
ver | findstr /i "6\.3\." > nul
if %ERRORLEVEL% EQU 0 (
goto ver_7
)


:ver_xp








pushd "\\scribe-dev-01\Winscribe Client Software\Desktop"
start /wait dotNetFx40_Full_x86_x64.exe /q /norestart
start /wait msiexec /i SSCERuntime_x64-ENU /passive
start /wait msiexec /i minimum\vc_runtimeMinimum_x64 /passive ADDEPLOY=1
start /wait msiexec /i Additional\vc_runtimeAdditional_x64 /passive ADDEPLOY=1
setup.exe /qb SERVERNAME="scribe-prod-01" RSDKCENTRALDBMS="LH-SQL-05\SCRIBE-PROD" RSDKCENTRALDBNAME="wsr" RSDKCENTRALDBLOGONUSER="winscribewsr" RSDKCENTRALDBLOGONPASSWORD="W1nscr1b3" RSDKLOCALCACHEPATH="C:\ProgramData\RSDK" RSDKTARGETDIR="C:\Program Files\RecognoscoSDK\"
popd


pause