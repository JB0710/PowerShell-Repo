#requires -version 4.0

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process powershell.exe "-noProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force -Confirm:$false

$PCType = $(Write-Host "DESKTOP or LAPTOP" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)

#region Functions
function RegistryMods
{
	# Disable FastBoot
	$RegistryPath1 = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power'
	$Name1 = 'HiberbootEnabled'
	$Value1 = '0'
	# Create the key if it does not exist
	If (-NOT (Test-Path $RegistryPath1))
	{
		New-Item -Path $RegistryPath1 -Force | Out-Null
	}
	# Now set the value
	New-ItemProperty -Path $RegistryPath1 -Name $Name1 -Value $Value1 -PropertyType DWORD -Force

	# Enable Remote Desktop
	$RegistryPath2 = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'
	$Name2 = 'fDenyTSConnections'
	$Value2 = '1'
	# Create the key if it does not exist
	If (-NOT (Test-Path $RegistryPath2))
	{
		New-Item -Path $RegistryPath2 -Force | Out-Null
	}
	# Now set the value
	New-ItemProperty -Path $RegistryPath2 -Name $Name2 -Value $Value2 -PropertyType DWORD -Force

	# Enable Remote Desktop
	$RegistryPath3 = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'
	$Name3 = 'UserAuthentication'
	$Value3 = '1'
	# Create the key if it does not exist
	If (-NOT (Test-Path $RegistryPath3))
	{
		New-Item -Path $RegistryPath3 -Force | Out-Null
	}
	# Now set the value
	New-ItemProperty -Path $RegistryPath3 -Name $Name3 -Value $Value3 -PropertyType DWORD -Force

	# Hide Edge First Run
	$RegistryPath4 = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge'
	$Name4 = 'HideFirstRunExperience'
	$Value4 = '1'
	# Create the key if it does not exist
	If (-NOT (Test-Path $RegistryPath4))
	{
		New-Item -Path $RegistryPath4 -Force | Out-Null
	}
	# Now set the value
	New-ItemProperty -Path $RegistryPath4 -Name $Name4 -Value $Value4 -PropertyType DWORD -Force

	# Disable Auto Logon
	$RegistryPath5 = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
	$Name5 = 'AutoAdminLogon'
	$Value5 = '0'
	# Create the key if it does not exist
	If (-NOT (Test-Path $RegistryPath5))
	{
		New-Item -Path $RegistryPath5 -Force | Out-Null
	}
	# Now set the value
	New-ItemProperty -Path $RegistryPath5 -Name $Name5 -Value $Value5 -PropertyType DWORD -Force

	# Outlook Shared Mailbox Trash Setting
	$RegistryPath6 = 'HKLM:\Software\Microsoft\Office\16.0\Outlook\Options'
	$Name6 = 'DelegateWastebasketStyle'
	$Value6 = '4'
	# Create the key if it does not exist
	If (-NOT (Test-Path $RegistryPath6))
	{
		New-Item -Path $RegistryPath6 -Force | Out-Null
	}
	# Now set the value
	New-ItemProperty -Path $RegistryPath6 -Name $Name6 -Value $Value6 -PropertyType DWORD -Force

	# Set variables to indicate value and key to set
	$RegistryPath7 = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds'
	$Name7 = 'ShellFeedsTaskbarViewMode'
	$Value7 = '2'
	# Create the key if it does not exist
	If (-NOT (Test-Path $RegistryPath7))
	{
		New-Item -Path $RegistryPath7 -Force | Out-Null
	}
	# Now set the value
	New-ItemProperty -Path $RegistryPath7 -Name $Name7 -Value $Value7 -PropertyType DWORD -Force

	# Set variables to indicate value and key to set
	$RegistryPath8 = 'HKCU:\Control Panel\Desktop'
	$Name8 = 'LogPixels'
	$Value8 = '96'
	# Create the key if it does not exist
	If (-NOT (Test-Path $RegistryPath8))
	{
		New-Item -Path $RegistryPath8 -Force | Out-Null
	}
	# Now set the value
	New-ItemProperty -Path $RegistryPath8 -Name $Name8 -Value $Value8 -PropertyType DWORD -Force

	# Set Desktop Scaling to 100%
	$RegistryPath9 = 'HKCU:\Control Panel\Desktop'
	$Name9 = 'Win8DpiScaling'
	$Value9 = '0'
	# Create the key if it does not exist
	If (-NOT (Test-Path $RegistryPath9))
	{
		New-Item -Path $RegistryPath9 -Force | Out-Null
	}
	# Now set the value
	New-ItemProperty -Path $RegistryPath9 -Name $Name9 -Value $Value9 -PropertyType DWORD -Force
}
function DownloadSourceFiles
{
	#Creating Base Dir
	$FolderName1 = "C:\OEM\AdvisorsTech"
	if (Test-Path $FolderName1)
	{
		Write-Host "$FolderName1 Exists"
	}
	else
	{
		Write-Host "Creating $FolderName1"
		New-Item $FolderName1 -ItemType Directory -Force
	}
	
	#Creating Base Dir
	$FolderName2 = "C:\OEM\Apps"
	if (Test-Path $FolderName2)
	{
		Write-Host "$FolderName2 Exists"
	}
	else
	{
		Write-Host "Creating $FolderName2"
		New-Item $FolderName2 -ItemType Directory -Force
	}

	#Download Custom Files
	Set-Location "C:\OEM\AdvisorsTech"
	#Download Zip File
	$OEMFolder = "C:\OEM\AdvisorsTech\"
	$Url = "https://www.kljwtech.net/AdvisorsTech.zip"
	$ZipFile = $OEMFolder + $(Split-Path -Path $Url -Leaf)
	$Destination = $OEMFolder

	Invoke-WebRequest -Uri $Url -OutFile $ZipFile -UseBasicParsing

	#Extract Zip
	$ExtractShell = New-Object -ComObject Shell.Application
	$Files = $ExtractShell.Namespace($ZipFile).Items()
	$ExtractShell.NameSpace($Destination).CopyHere($Files)

	#Delete Zip File
	Remove-Item $OEMFolder* -Include *.zip
}
function UnpinAllTitles
{

	$START_MENU_LAYOUT = @"
			<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
    			<LayoutOptions StartTileGroupCellWidth="6" />
    		<DefaultLayoutOverride>
        	<StartLayoutCollection>
            	<defaultlayout:StartLayout GroupCellWidth="6" />
        	</StartLayoutCollection>
    		</DefaultLayoutOverride>
			</LayoutModificationTemplate>
"@

	$layoutFile = "C:\OEM\AdvisorsTech\StartMenuLayout.xml"

	#Delete layout file if it already exists
	If (Test-Path $layoutFile)
	{
		Remove-Item $layoutFile
	}

	#Creates the blank layout file
	$START_MENU_LAYOUT | Out-File $layoutFile -Encoding ASCII
	$regAliases = @("HKLM", "HKCU")

	#Assign the start layout and force it to apply with "LockedStartLayout" at both the machine and user level
	foreach ($regAlias in $regAliases)
	{
		$basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
		$keyPath = $basePath + "\Explorer"
		IF (!(Test-Path -Path $keyPath))
		{
			New-Item -Path $basePath -Name "Explorer"
		}
		Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
		Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile
	}

	#Restart Explorer, open the start menu (necessary to load the new layout), and give it a few seconds to process
	Stop-Process -name explorer
	Start-Sleep -s 5
	$wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('^{ESCAPE}')
	Start-Sleep -s 5

	#Enable the ability to pin items again by disabling "LockedStartLayout"
	foreach ($regAlias in $regAliases)
	{
		$basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
		$keyPath = $basePath + "\Explorer"
		Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0
	}

	#Restart Explorer and delete the layout file
	Stop-Process -name explorer

	# Uncomment the next line to make clean start menu default for all new users
	Import-StartLayout -LayoutPath $layoutFile -MountPath $env:SystemDrive\

	Remove-Item $layoutFile
}
function DebloadWindows10
{
    $packages = @(
    "Microsoft.BingWeather"
    "Microsoft.Office.OneNote"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.People"
    "Microsoft.SkypeApp"
    "Microsoft.WindowsMaps"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
)

$sponsors = @(
    "BubbleWitch3Saga"
    "CandyCrush"
    "Dolby"
    "Duolingo-LearnLanguagesforFree"
    "EclipseManager"
    "Facebook"
    "Flipboard"
    "PandoraMediaInc"
    "Royal Revolt"
    "Spotify"
    "Sway"
    "Twitter"
    "Wunderlist"
)

$optionals = @(
    "App.StepsRecorder"
    "Hello.Face.18967"
    "MathRecognizer"
    "Media.WindowsMediaPlayer"
    "OneCoreUAP.OneSync"
    "Print.Fax.Scan"
)

Write-Host ">> Starting Windows 10 Cleanup Script"

Write-Host "    ++ Removing Windows App Packages"
foreach ($package in $packages) {
    Write-Host "      + Removing App $package ..."
    Get-AppxPackage -Name $package | Remove-AppxPackage -ErrorAction SilentlyContinue
}

Write-Host "    ++ Removing Windows Sponsored App Packages"
foreach ($sponsor in $sponsors) {
    Write-Host "      + Removing Sponsored App $sponsor ..."
    Get-AppxPackage | Where-Object Name -cmatch $sponsor | Remove-AppxPackage -ErrorAction SilentlyContinue
}

Write-Host "    ++ Removing Windows Optional Apps"
foreach ($optional in $optionals) {
    Write-Host "      + Removing App $optional ..."
    Get-WindowsCapability -Online -LimitAccess | Where-Object { $_.Name -like $optional } | Remove-WindowsCapability -Online -ErrorAction SilentlyContinue
}

Write-Host ">> Windows 10 Cleanup Script Finished"
Write-Host "+++ Some Changes May Require Restarting Windows +++"
}
function InstallM365
{
    Set-Location "C:\OEM\AdvisorsTech\Office365"
    Install-Script -Name Install-Office365Suite
    .\Install-Office365Suite.ps1 -ConfigurationXMLFile "OfficeConfig.xml" -CleanUpInstallFiles

}
function InstallPowerShell7
{
	$source = "https://github.com/PowerShell/PowerShell/releases/download/v7.3.1/PowerShell-7.3.1-win-x64.msi"
	$destination = "C:\OEM\Apps\PowerShell-7.3.1-win-x64.msi"
	$file = "PowerShell-7.3.1-win-x64.msi"
	
	Invoke-WebRequest -Uri $source -OutFile $destination
	Set-Location -Path "C:\OEM\Apps\"
	msiexec.exe /package PowerShell-7.3.1-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1
}
function Onboard
{
	DownloadSourceFiles
	
    Start-Transcript -Path "C:\OEM\Onboarding.log" -Append -NoClobber

	#Install Chocolately
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	choco feature enable -n allowGlobalConfirmation
	choco upgrade chocolatey

	#Renaming PC
	$DellServiceTag = Get-WmiObject Win32_BIOS | Select-Object -ExpandProperty serialnumber
	Rename-Computer -NewName "$PCType-$DellServiceTag" -Force -ErrorAction SilentlyContinue

	#Install Package Manager
	Install-PackageProvider Nuget -Force
	Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    #Install Modules & Scripts
    Install-Script -Name Update-Office365 -Force
    Install-Module -Name Get-WindowsVersion -Force
    Install-Module -Name GetSystemInfo -Force
    Install-Module -Name WindowsOSBuild -Force
    Install-Module -Name IPv4Toolbox -Force
    Install-Module -Name AdministratorRole -Force
    Install-Module -Name PackageUpdateInfo -Force
    Install-Module -Name PSWindowsUpdate -Force

	#Appliying Registry Mods
	RegistryMods

	#Settings Power Settings
	powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
	powercfg /hibernate off
	powercfg /change monitor-timeout-ac 60
	powercfg /change monitor-timeout-dc 15
	powercfg /change disk-timeout-ac 0
	powercfg /change disk-timeout-dc 0
	powercfg /change standby-timeout-ac 0
	powercfg /change standby-timeout-dc 60

	#Set Windows Firewall

	#Set Network Profile to Private
	Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private -ErrorAction SilentlyContinue

	#Enable File and Printer Sharing
	Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled False -Profile Public -ErrorAction SilentlyContinue
	Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Private -ErrorAction SilentlyContinue
	Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Domain -ErrorAction SilentlyContinue

	#Enable SMBv1
    Get-SmbServerConfiguration | Select-Object -Property "EnableSMB1Protocol"
    Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol | Select-Object -Property "State"
	Set-SmbServerConfiguration -EnableSMB1Protocol $true -Force -ErrorAction SilentlyContinue
    Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart -ErrorAction SilentlyContinue

	#Disable BitLocker
	Get-BitLockerVolume -ErrorAction SilentlyContinue
	Disable-BitLocker -MountPoint "C:" -Confirm:$false -ErrorAction SilentlyContinue
	Get-BitlockerVolume -ErrorAction SilentlyContinue

#Debloat
DebloadWindows10
UnpinAllTitles

#Install Powershell 7
InstallPowerShell7

#Install Standard Apps via Chocolatey
	$chocos = @(
        "netfx-4.8.1"
        "dotnetfx"
        "vcredist2008"
        "vcredist2012"
		"vcredist2015"
        "vcredist2017"
		"adobereader"
		"googlechrome"
		"firefox"
		"vlc"
		"notepadplusplus.install"
		"7zip.install"
		"microsoft-teams.install"
        "dell-update"
        "dellcommandupdate"
		"psping"
		"cutepdf"
		"greenshot"
        "mysql-connector"

	)
	foreach ($choco in $chocos)
	{
		choco install $choco -y --force --ignore-checksums
	}

	Start-Sleep 3
	[System.Windows.Forms.SendKeys]::SendWait("{ESC}")
	
	Start-Sleep 3
	
	#Install Office365
    InstallM365

	#Running Dell Command Update
	#Start-Process -FilePath "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe" -ArgumentList "/applyUpdates -reboot=disable -autoSuspendBitLocker=enable -silent -outputLog=""C:\Dell\DellCommandUpdate.log"" " -Wait -WindowStyle Hidden
	#Remove-Item -Path "C:\Dell\UpdateNotNeeded.txt", "C:\Dell\UpdateNeeded.txt", "C:\Dell\Updating.txt" -ErrorAction SilentlyContinue
	#New-Item -Path "C:\Dell\UpdateNotNeeded.txt" -ItemType File -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue

	#Running and Install Windows Updates
	Get-WindowsUpdate
	Get-WindowsUpdate -AcceptAll -Install -AutoReboot
	Install-WindowsUpdate -AcceptAll -IgnoreReboot

	#Importing Start Menu Layout
	Import-StartLayout -LayoutPath "C:\OEM\AdvisorsTech\StartMenuLayout.xml" -MountPath %systemdrive% -ErrorAction SilentlyContinue

	#Review Dell Command Update
	Start-Process notepad.exe { "C:\Dell\DellCommandUpdate.log" } 
	Start-Sleep 10

	#Review Windows Update
	Start-Process notepad.exe { "C:\OEM\Onboarding.log" }
	Start-Sleep 10

	Stop-Transcript
	
}
function BootLogo
{
	$HackerBGRT = "C:\OEM\AdvisorsTech\HackBGRT\setup.exe"
	Start-Process $HackerBGRT -Verb runAs
	Start-Sleep 2
	[System.Windows.Forms.SendKeys]::SendWait("I")
	Start-Sleep 2
	TaskKill /im notepad.exe /f /t
	Start-Sleep 2
	TaskKill /im mspaint.exe /f /t
	Start-Sleep 2
	[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
	Start-Sleep 2
}
function CleanUP
{
	Remove-Item -Path "C:\Users\ATAdmin\Desktop\AdvisorsTechApp.exe" -Force
	Remove-Item -Path "C:\OEM\AdvisorsTechApp.exe" -Force
	Remove-Item -Path "C:\OEM\AdvisorsTechApp.exe.config" -Force
}
function AddToMySQL
{
    [System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")

    #Connection
[string]$sMySQLUserName = 'root'
[string]$sMySQLPW = 'R@ckne1807!!'
[string]$sMySQLDB = 'AdvisorsTech-NewPCs'
[string]$sMySQLHost = 'mysql.kljwtech.net'
[string]$sConnectionString = "server="+$sMySQLHost+";port=3306;uid=" + $sMySQLUserName + ";pwd=" + $sMySQLPW + ";database="+$sMySQLDB

#Open the Database
$oConnection = New-Object MySql.Data.MySqlClient.MySqlConnection($sConnectionString)
$Error.Clear()
try
{
    $oConnection.Open()
}
catch
{
    write-warning ("Could not open a connection to Database $sMySQLDB on Host $sMySQLHost. Error: "+$Error[0].ToString())
}



}

Onboard
BootLogo
CleanUP

shutdown /r
