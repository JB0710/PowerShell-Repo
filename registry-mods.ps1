# Disable FastBoot
$RegistryPath1 = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power'
$Name1         = 'HiberbootEnabled'
$Value1        = '0'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath1)) {
  New-Item -Path $RegistryPath1 -Force | Out-Null
}
# Now set the value
New-ItemProperty -Path $RegistryPath1 -Name $Name1 -Value $Value1 -PropertyType DWORD -Force

# Enable Remote Desktop
$RegistryPath2 = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'
$Name2         = 'fDenyTSConnections'
$Value2        = '1'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath2)) {
  New-Item -Path $RegistryPath2 -Force | Out-Null
}
# Now set the value
New-ItemProperty -Path $RegistryPath2 -Name $Name2 -Value $Value2 -PropertyType DWORD -Force

# Enable Remote Desktop
$RegistryPath3 = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'
$Name3         = 'UserAuthentication'
$Value3        = '1'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath3)) {
  New-Item -Path $RegistryPath3 -Force | Out-Null
}
# Now set the value
New-ItemProperty -Path $RegistryPath3 -Name $Name3 -Value $Value3 -PropertyType DWORD -Force

# Hide Edge First Run
$RegistryPath4 = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge'
$Name4         = 'HideFirstRunExperience'
$Value4        = '1'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath4)) {
  New-Item -Path $RegistryPath4 -Force | Out-Null
}
# Now set the value
New-ItemProperty -Path $RegistryPath4 -Name $Name4 -Value $Value4 -PropertyType DWORD -Force

# Disable Auto Logon
$RegistryPath5 = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
$Name5         = 'AutoAdminLogon'
$Value5        = '0'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath5)) {
  New-Item -Path $RegistryPath5 -Force | Out-Null
}
# Now set the value
New-ItemProperty -Path $RegistryPath5 -Name $Name5 -Value $Value5 -PropertyType DWORD -Force

# Outlook Shared Mailbox Trash Setting
$RegistryPath6 = 'HKLM:\Software\Microsoft\Office\16.0\Outlook\Options'
$Name6         = 'DelegateWastebasketStyle'
$Value6        = '4'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath6)) {
  New-Item -Path $RegistryPath6 -Force | Out-Null
}
# Now set the value
New-ItemProperty -Path $RegistryPath6 -Name $Name6 -Value $Value6 -PropertyType DWORD -Force

# Set variables to indicate value and key to set
$RegistryPath7 = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds'
$Name7         = 'ShellFeedsTaskbarViewMode'
$Value7        = '2'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath7)) {
  New-Item -Path $RegistryPath7 -Force | Out-Null
}
# Now set the value
New-ItemProperty -Path $RegistryPath7 -Name $Name7 -Value $Value7 -PropertyType DWORD -Force

# Set variables to indicate value and key to set
$RegistryPath8 = 'HKCU:\Control Panel\Desktop'
$Name8         = 'LogPixels'
$Value8        = '96'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath8)) {
  New-Item -Path $RegistryPath8 -Force | Out-Null
}
# Now set the value
New-ItemProperty -Path $RegistryPath8 -Name $Name8 -Value $Value8 -PropertyType DWORD -Force

# Set variables to indicate value and key to set
$RegistryPath9 = 'HKCU:\Control Panel\Desktop'
$Name9         = 'Win8DpiScaling'
$Value9        = '0'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath9)) {
  New-Item -Path $RegistryPath9 -Force | Out-Null
}
# Now set the value
New-ItemProperty -Path $RegistryPath9 -Name $Name9 -Value $Value9 -PropertyType DWORD -Force