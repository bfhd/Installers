REM set local folder variable
pushd "%~dp0"

REM Find out OS version
REM Windows XP
ver | findstr /i "5\.1\."
if %ERRORLEVEL% EQU 0 (
goto VER_XP
)

REM Windows 7/8/8.1
ver | findstr /i "6\.1\." > nul
if %ERRORLEVEL% EQU 0 (
goto VER_7
)
ver | findstr /i "6\.2\." > nul
if %ERRORLEVEL% EQU 0 (
goto VER_7
)
ver | findstr /i "6\.3\." > nul
if %ERRORLEVEL% EQU 0 (
goto VER_7
)

REM Windows XP
:VER_XP
start /wait dotNetFx40_Full_x86_x64.exe /q /norestart
start /wait msiexec /i SSCERuntime_x86-ENU /passive
start /wait msiexec /i vc_runtimeMinimum_x86 /passive ADDEPLOY=1
start /wait msiexec /i vc_runtimeAdditional_x86 /passive ADDEPLOY=1
goto END

REM Windows 7/8/8.1
:VER_7

REM Check if 64 bit or 32 bit
:CheckOS
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
start /wait dotNetFx40_Full_x86_x64.exe /q /norestart
start /wait msiexec /i SSCERuntime_x64-ENU /passive
start /wait msiexec /i vc_runtimeMinimum_x64 /passive ADDEPLOY=1
start /wait msiexec /i vc_runtimeAdditional_x64 /passive ADDEPLOY=1
goto END

:32BIT
start /wait dotNetFx40_Full_x86_x64.exe /q /norestart
start /wait msiexec /i SSCERuntime_x86-ENU /passive
start /wait msiexec /i vc_runtimeMinimum_x86 /passive ADDEPLOY=1
start /wait msiexec /i vc_runtimeAdditional_x86 /passive ADDEPLOY=1




setup.exe /qb SERVERNAME="scribe-prod-01" RSDKCENTRALDBMS="LH-SQL-05\SCRIBE-PROD" RSDKCENTRALDBNAME="wsr" RSDKCENTRALDBLOGONUSER="winscribewsr" RSDKCENTRALDBLOGONPASSWORD="W1nscr1b3" RSDKLOCALCACHEPATH="C:\ProgramData\RSDK" RSDKTARGETDIR="C:\Program Files\RecognoscoSDK\"



:END
popd
pause