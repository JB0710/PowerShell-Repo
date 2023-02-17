#Add permission to install printer drivers for non-admin

reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DriverInstall\Restrictions" /v AllowUserDeviceClasses /t REG_DWORD/d 1 /f

