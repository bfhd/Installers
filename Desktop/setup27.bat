@echo off
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

REM Non-supported OS
goto ERROR

REM Windows XP
:VER_XP
start /wait dotNetFx40_Full_x86_x64.exe /q /norestart
start /wait msiexec /i SSCERuntime_x86-ENU /passive
start /wait msiexec /i %~dp0x86\minimum\vc_runtimeMinimum_x86 /passive ADDEPLOY=1
start /wait msiexec /i %~dp0x86\additional\vc_runtimeAdditional_x86 /passive ADDEPLOY=1
%~dp0x86\setup.exe /qb SERVERNAME="wscloudau2.winscribe.com" RSDKCENTRALDBMS="wscloudau2.winscribe.com" RSDKCENTRALDBNAME="wsr" RSDKCENTRALDBLOGONUSER="wsrsqluser" RSDKCENTRALDBLOGONPASSWORD="W1nscr1b3" RSDKLOCALCACHEPATH="C:\Documents and Settings\All Users\Application Data\RSDK" RSDKTARGETDIR="C:\Program Files\RecognoscoSDK\" RECOGNITIONADDRESS="net.tcp://wscloudau2.winscribe.com:8086/RcgServer" TRANSPORTTYPE="HTTPS"

goto END

REM Windows 7/8/8.1
:VER_7

REM Check if 64 bit or 32 bit
:CheckOS
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
start /wait dotNetFx40_Full_x86_x64.exe /q /norestart
start /wait msiexec /i SSCERuntime_x64-ENU /passive
start /wait msiexec /i %~dp0x64\minimum\vc_runtimeMinimum_x64 /passive ADDEPLOY=1
start /wait msiexec /i %~dp0x64\additional\vc_runtimeAdditional_x64 /passive ADDEPLOY=1
%~dp0x64\setup.exe /qb SERVERNAME="wscloudau2.winscribe.com" RSDKCENTRALDBMS="wscloudau2.winscribe.com" RSDKCENTRALDBNAME="wsr" RSDKCENTRALDBLOGONUSER="wsrsqluser" RSDKCENTRALDBLOGONPASSWORD="W1nscr1b3" RSDKLOCALCACHEPATH="C:\ProgramData\RSDK" RSDKTARGETDIR="C:\Program Files\RecognoscoSDK\" RECOGNITIONADDRESS="net.tcp://wscloudau2.winscribe.com:8086/RcgServer" TRANSPORTTYPE="HTTPS"
goto END

:32BIT
start /wait dotNetFx40_Full_x86_x64.exe /q /norestart
start /wait msiexec /i SSCERuntime_x86-ENU /passive
start /wait msiexec /i %~dp0x86\minimum\vc_runtimeMinimum_x86 /passive ADDEPLOY=1
start /wait msiexec /i %~dp0x86\additional\vc_runtimeAdditional_x86 /passive ADDEPLOY=1
%~dp0x86\setup.exe /qb SERVERNAME="wscloudau2.winscribe.com" RSDKCENTRALDBMS="wscloudau2.winscribe.com" RSDKCENTRALDBNAME="wsr" RSDKCENTRALDBLOGONUSER="wsrsqluser" RSDKCENTRALDBLOGONPASSWORD="W1nscr1b3" RSDKLOCALCACHEPATH="C:\ProgramData\RSDK" RSDKTARGETDIR="C:\Program Files\RecognoscoSDK\" RECOGNITIONADDRESS="net.tcp://wscloudau2.winscribe.com:8086/RcgServer" TRANSPORTTYPE="HTTPS"



:END
del /q %~dp0\*.*
popd
color a0
echo ==================================================
echo Installation complete!  Press any key to continue.
echo ==================================================
pause

:ERROR
REM del /q %~dp0\*.*
color c0
echo ======================================================
echo Error: Operating System not detected or not supported!
echo ======================================================
pause
popd