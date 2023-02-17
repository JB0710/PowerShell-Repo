
#Variaable
$downloadURL = "https://kljwtech.net/"
$FileDownload = "NetExtender.zip"
$vpnLocation = "C:\OEM\src\scripts\vpn"
$NEGUI = "C:\Program Files (x86)\SonicWall\SSL-VPN\NetExtender\NEGui.exe"
$NETCLI = "C:\Program Files\SonicWAll\SSL-VPN\NetExtender\NECLI.exe"
#region Download and Extract

#User input
function Read-InputBoxDialog([string]$Message, [string]$WindowTitle, [string]$DefaultText)
{
    Add-Type -AssemblyName Microsoft.VisualBasic
    return [Microsoft.VisualBasic.Interaction]::InputBox($Message, $WindowTitle, $DefaultText)
}
$SSLVPNServer = Read-InputBoxDialog -Message "SSL VPN Server IP" -WindowTitle "SSL VPN Profile" -DefaultText ""
$SSLVPNDomain = Read-InputBoxDialog -Message "SSL VPN Domain" -WindowTitle "SSL VPN Profile" -DefaultText "LocalDomain"
if ($SSLVPNServer -eq $null)
{ Write-Host "Canceled" }
else
{
    Write-Host "SSL VPN IP $$SSLVPNServer"
    Write-Host "SSL VPN Domain $SSLVPNDomain"
}

#Download SonicWall NetExtender
Set-Location $vpnLocation

#Create Dir
function CreateVPNDir {
Write-Host "Creating VPN Working Dir"
$FolderName = $vpnLocation
    if (Test-Path $FolderName)
    {
        Write-Host -Message "$FolderName Exists"
    }
    else
    {
        Write-Host -Message "Creating $Foldername"
        New-Item $FolderName -ItemType Directory -Force
    }
}

#Download Zip File
function DownloadFiles {

    Write-Output "Extracting Zip File"
    $OEMFolder = $vpnLocation
    $Url = "https://kljwtech.net/NetExtender.zip"
    New-Item -ItemType Directory -Force -Path $OEMFolder
    $ZipFile = $OEMFolder + $(Split-Path -Path $Url -Leaf)
    Invoke-WebRequest -Uri $Url -OutFile $ZipFile
}

#Extract Zip
function ExtractFiles {

    Write-Output "Extracting Files"
    $ExtractShell = New-Object -ComObject Shell.Application
    $Files = $ExtractShell.Namespace($ZipFile).Items()
    $ExtractShell.NameSpace($Destination).CopyHere($Files)
    Write-Output "Cleaning Up"
    #Delete Zip File
    Remove-Item $OEMFolder* -Include *.zip
}

#endregion

#Install NetExtender
$ErrorActionPreference = 'SilentlyContinue'

Write-Host - "Creating VPN Working Dir"
CreateVPNDir
Write-Host "Downloading Required Files"
DownloadFiles
ExtractFiles

Set-Location "$vpnLocation"

function InstallNetExtender
{

param(

    [string]$SSLSERVER,
    [string]$SSLDOMAIN

    )

$OutFile = "C:\OEM\src\scripts\vpn\NetExtender\NetExtender-x64.exe"
$containsTest = 'NetExtender-x64.exe'
$InstallCommand = "C:\OEM\src\scripts\vpn\NetExtender\NetExtender-x64.exe"
$Arguments = "/Q", "/S"
$NETCLIARG = "addprofile -s $SSLSERVER -d $SSLDOMAIN"

#Test Variables
$ToolTest = get-childitem C:\

if($ToolTest.name -contains $containsTest ){
    Remove-Item $OutFile -Recurse -force
    }

#Installs netextender
start-process $InstallCommand -ArgumentList $Arguments -wait

#checks contents of $sslserver and $ssldomain
if($SSLSERVER -eq "" -or $SSLDOMAIN -eq ""){
    Write-warning '-SSLSERVER AND/OR -SSLDOMAIN NOT DEFINED SKIPPING PROFILE CREATION'
    }
#Creates netextender profile if $ssldomain and $sslserver have values
else{
    start-process $NETCLI -ArgumentList $NETCLIARG
    }
}
   InstallNetExtender -SSLSERVER $SSLVPNServer -SSLDOMAIN $SSLVPNDomain
   Start-Process "$NEGUI"