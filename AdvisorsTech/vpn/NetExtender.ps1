#Preferences
$ErrorActionPreference = 'SilentlyContinue'

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
    Write-Host "SSL VPN IP $textEntered" 
    Write-Host "SSL VPN Domain $SSLVPNDomain"
}

function InstallNetExtender 
{

param(
    
    [string]$SSLSERVER,
    [string]$SSLDOMAIN
    
    )

#Creating App Dir
$FolderName = "C:\OEM\Apps"
if (Test-Path $FolderName)
{
    Write-Host -Message "$FolderName Exists"
}
else
{
    Write-Host -Message "Creating $Foldername"
    New-Item $FolderName -ItemType Directory -Force
}

#NOTES: out-null keeps powershell from running the next line of code until the previous line has finished all its work.
#VARIABLES
$ToolDownload = "https://software.sonicwall.com/NetExtender/NXSetupU-x64-10.2.331.exe"
$OutFile = "C:\OEM\Apps\NetExtender.exe"
$containsTest = 'NetExtender.exe'
$InstallCommand = "C:\OEM\Apps\NetExtender.exe"
$Arguments = "/Q", "/S"
$NETCLI = "C:\Program Files (x86)\SonicWAll\SSL-VPN\NetExtender\NECLI.exe"
$NETCLIARG = "addprofile -s $SSLSERVER -d $SSLDOMAIN"

#Test Variables
$ToolTest = get-childitem C:\

if($ToolTest.name -contains $containsTest ){
    Remove-Item $OutFile -Recurse -force
    }
#Downloads netextender MSI
Invoke-WebRequest -Uri $ToolDownload  -OutFile $OutFile | Out-Null

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
   Start-Process "\C:\Program Files (x86)\SonicWall\SSL-VPN\NetExtender\NEGui.exe"