start /wait msiexec /i "\\scribe-dev-01\Winscribe Client Software\Desktop\SSCERuntime_x64-ENU" /passive
start /wait msiexec /i "C:\Users\adminlars\Desktop\Desktop\minimum\vc_runtimeMinimum_x64" /passive ADDEPLOY=1
start /wait msiexec /i "C:\Users\adminlars\Desktop\Desktop\Additional\vc_runtimeAdditional_x64" /passive ADDEPLOY=1
start /wait msiexec /i "\\scribe-dev-01\Winscribe Client Software\Desktop\x64\Winscribe Desktop x64.msi" /qb SERVERNAME="scribe-prod-01" RSDKCENTRALDBMS="LH-SQL-05\SCRIBE_PROD" RSDKCENTRALDBNAME="wsr" RSDKCENTRALDBLOGONUSER="winscribewsr" RSDKCENTRALDBLOGONPASSWORD="W1nscr1b3" RSDKLOCALCACHEPATH="C:\ProgramData\RSDK" RSDKTARGETDIR="C:\Program Files\RecognoscoSDK\"
