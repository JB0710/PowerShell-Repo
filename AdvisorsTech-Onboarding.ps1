Clear-Host
##Post-Installer
#by: Jonathan Wood / AdvisorsTech
#09/30/2022
#V1.0.6

Write-Output "Renaming PC"
#Rename PC to Dell Service Tag
Start-Sleep 10
$DellServiceTag = Get-WmiObject Win32_BIOS | Select-Object -ExpandProperty serialnumber

Rename-Computer -NewName "DESKTOP-$DellServiceTag" -Force -Restart
#Creating Base Dir
New-Item -Path 'C:\OEM' -ItemType Directory

Write-Output "Install Package Manager"

# Package Manager Settings and Config
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process powershell.exe "-noProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

Write-Output "Package Manager Install Complete"

Write-Output "Base Folders Created"
Start-Sleep 2
Write-Output "Downloading Automation Scripts"

#Download Custom Files
Set-Location "C:\OEM"
#Download Zip File 
$OEMFolder = "C:\OEM\"
$Url = "https://kljwtech.net/files/CustomWin10.zip"
New-Item -ItemType Directory -Force -Path $OEMFolder
$ZipFile = $OEMFolder + $(Split-Path -Path $Url -Leaf) 
$Destination = $OEMFolder 
Invoke-WebRequest -Uri $Url -OutFile $ZipFile 

Write-Output "Extracting Zip File"

#Extract Zip 
$ExtractShell = New-Object -ComObject Shell.Application 
$Files = $ExtractShell.Namespace($ZipFile).Items() 
$ExtractShell.NameSpace($Destination).CopyHere($Files) 

Write-Output "Cleaning Up"
#Delete Zip File
Remove-Item $OEMFolder* -Include *.zip

Start-Sleep 2
Write-Output "Creating Base Folders"

Set-Location "C:\OEM\src\scripts"
.\create-folders.ps1 .\folder_list.txt
.\optimize-user-interface.ps1
.\remove-onedrive.ps1
.\fix-privacy-settings.ps1
#
Set-Location "C:\Windows\system32"

Start-Sleep 2
Write-Output "Installing Chocolatey"

#Install Chocolatey
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
# Enable Global confirmation (auto accept any prompts)
choco feature enable -n=allowGlobalConfirmation

Start-Sleep 5

choco install vagrant -y

Write-Output "Setting Power Settings"

#Disable Windows 10 fast boot via Powershell
$path1 = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power'
$name1 = 'HiberbootEnabled'
$value1 = '0'

IF(!(Test-Path $path1))
  {
    New-Item -Path $path1 -Force | Out-Null
    New-ItemProperty -Path $path1 -Name $name1 -Value $value1 `
    -PropertyType DWORD -Force | Out-Null}

 ELSE {
    New-ItemProperty -Path $path1 -Name $name1 -Value $value1 `
    -PropertyType DWORD -Force | Out-Null}

#Set Power Settings.
powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg /hibernate off
powercfg /change monitor-timeout-ac 60
powercfg /change monitor-timeout-dc 15
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 60

Write-Output "Power Settings Configured"
Start-Sleep 2
Write-Output "Debloating Windows"

#Debloat App Remover
Set-ExecutionPolicy -ExecutionPolicy Bypass
Set-Location "C:\OEM\Debloat\scripts"
.\remove-default-apps.ps1
.\optimize-user-interface.ps1
.\remove-onedrive.ps1
.\fix-privacy-settings.ps1
#
Set-Location "C:\Windows\system32"
 
Write-Output "Debloatin Complete"
Start-Sleep 2
Write-Output "Installing PowerShell Modules and Standard Apps"

#Powershell Modules
Install-Module -Name PSWindowsUpdate -Force

#Standard Apps
choco install adobereader --ignore-checksums
choco install googlechrome --ignore-checksums
choco install firefox --ignore-checksums
choco install notepadplusplus.install --ignore-checksums
choco install 7zip.install --ignore-checksums
choco install microsoft-teams.install --ignore-checksums
choco install dellcommandupdate-uwp --ignore-checksums -y

#Office 365 Business
choco install microsoft-office-deployment  /64bit /Language en-us /Product O365ProPlusRetail /eula /updates /Exclude Publisher Access Lync Groove --ignore-checksums

Write-Output "PowerShell Modules and Standard Apps Installed"
Start-Sleep 2
Write-Output "Applying Custom Windows Settings"

Write-Output "Enabling Remote Desktop"
#Enable Remote Desktop
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Output "Setting Outlook Shared Mailboxes Deleted Items"
#Deleted emails are stored for Shared Mailboxes
$path3 = 'HKCU:\Software\Microsoft\Office\16.0\Outlook\Options'
$name3 = 'DelegateWastebasketStyle'
$value3 = '4'

IF(!(Test-Path $path3))
  {
    New-Item -Path $path3 -Force | Out-Null
    New-ItemProperty -Path $path3 -Name $name3 -Value $value3 `
    -PropertyType DWORD -Force | Out-Null}

 ELSE {
    New-ItemProperty -Path $path3 -Name $name3 -Value $value3 `
    -PropertyType DWORD -Force | Out-Null}
  
Write-Output "Disabling Edge First Run Experience"
#Disabl Edge First Run Experience
$path4 = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge'
$name4 = 'HideFirstRunExperience'
$value4 = '1'

IF(!(Test-Path $path4))
  {
    New-Item -Path $path4 -Force | Out-Null
    New-ItemProperty -Path $path4 -Name $name4 -Value $value4 `
    -PropertyType DWORD -Force | Out-Null}

 ELSE {
    New-ItemProperty -Path $path4 -Name $name4 -Value $value4 `
    -PropertyType DWORD -Force | Out-Null}

Write-Output "Setting Auto Screen Lockout"
#Auto Lock 15 Minutes
$path5 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$name5 = 'InactivityTimeoutSecs'
$value5= '900'
IF(!(Test-Path $path5))
  {
    New-Item -Path $path5 -Force | Out-Null
    New-ItemProperty -Path $path5 -Name $name5 -Value $value5 `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $path5 -Name $name5 -Value $value5 `
    -PropertyType DWORD -Force | Out-Null}

Write-Output "Disable Last User Logon"
#Disabl Last User Logon
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "dontdisplaylastusername" -Type String -Value 1

Write-Output 'Disable Auto Logon'
#Disable Auto Logon
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "AutoAdminLogon" -Type String -Value 0

Write-Output "Running Dell Command Update"
#Dell Command Update
Set-Location "C:\OEM\src\scripts"
.\DellCommandUpdate.ps1 -debug
Start-Sleep 30

Write-Output "Dell Command Update Complete"

Write-Output "Running Windows Update"

Write-Output "Reset ATSuport Local Admin Password"
#Reset Local ATSupport Passwod
param (
  [Parameter(Mandatory=$true)]
  [string]$var1
)
$argumentlist = "/c powershell.exe -file `"C:\OEM\src\scripts\PasswordResetter.ps1`" -param1 `"-WindowStyle Hidden`""
Start-Process cmd.exe -WindowStyle Hidden -ArgumentList $argumentlist

#Run Windows Update
Set-Location "C:\OEM\src\scripts"
.\PSWindowsUpdate.ps1
#end
