@echo off
ECHO ===================================
ECHO Did you update the config.txt file?
ECHO ===================================
pause
call create_new_desktop7z_sprint_27.bat
copy /b 7zsd.sfx + config.txt + desktop27.7z dt.exe
ECHO ===================================
ECHO new installer created!
ECHO ===================================
pause