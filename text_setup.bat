REM Install text client:

setup /v"/l*v client2.log /qn COMPANYNAME="WinscribeText" SECONDSEQUENCE=0 MSDOTNETFOUND=C:\Windows\Microsoft.NET\Framework\ MDAC28IE4SIG=C:\Windows\system32\shdocvw.dll CLIENT_VERSION_DIR=\"c:\Program Files\Winscribe\Winscribe Text\Client\7.0.0.0\"


REM Copy connection string file

mkdir C:\ProgramData\Winscribe\WinscribeText\Configuration
copy "%~dp0ConnectionString.xml" "C:\ProgramData\Winscribe\WinscribeText\Configuration"

REM Remove setup installer to prevent problems installing newer versions
REM del "%~dp0setup.exe

REM Check if 64 bit or 32 bit
:CheckOS
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
echo 64-bit...
REM Step 1: Copy the application loader .config file to the Text folder
copy "C:\temp\64\AppStart.exe.config" "C:\Program Files (x86)\Winscribe\Winscribe Text\Client"

REM Step 2: Copy the Mediscribe Client .config file to the Text Client folder
copy "C:\temp\64\MediScribe.Applications.Main.exe.config" "C:\Program Files (x86)\Winscribe\Winscribe Text\Client\7.0.0.0"

REM Step 3: Register the .reg file:
regedit /s "C:\temp\64\LHtext.reg"

REM Step 4: Remove the HTI Ribbon Bridge (64-bit only)
del "C:\Program Files (x86)\Winscribe\Winscribe Text\Client\7.0.0.0\HTI.RibbonBridge.dll"
gacutil /u "HTI.Ribbonbridge,Version=7.0.5042.29098, Culture=neutral, PublicKeyToken=2cc584513c8f0d1c"
GOTO END

:32BIT
echo 32-bit...
REM Step 1: Copy the application loader .config file to the Text folder
copy "C:\temp\32\AppStart.exe.config" "C:\Program Files\Winscribe\Winscribe Text\Client"

REM Step 2: Copy the Mediscribe Client .config file to the Text Client folder
copy "C:\temp\32\MediScribe.Applications.Main.exe.config" "C:\Program Files\Winscribe\Winscribe Text\Client\7.0.0.0"

REM Step 3: Register the .reg file:
regedit /s "C:\temp\32\LHtext.reg"
GOTO END

:END