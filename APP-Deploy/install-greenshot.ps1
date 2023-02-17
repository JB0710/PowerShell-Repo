$FolderName1 = "C:\OEM\src\apps"
if (Test-Path $FolderName1) {
    Write-Host "Folder Exists"
}
else
{
    New-Item $FolderName1 -ItemType Directory
    Write-Host "Folder Created successfully"
}

$FolderName2 = "C:\OEM\src\apps\Greenshot"
if (Test-Path $FolderName2) {
    Write-Host "Folder Exists"
}
else
{
    New-Item $FolderName2 -ItemType Directory
    Write-Host "Folder Created successfully"
}

$source = 'https://www.kljwtech.net/Greenshot.zip'
$destination = 'C:\OEM\src\apps\Greenshot.zip'
Invoke-WebRequest -Uri $source -OutFile $destination
Expand-Archive -LiteralPath $destination -DestinationPath $FolderName2
Set-Location -Path $FolderName2
Powershell.exe -ExecutionPolicy Bypass .\Deploy-Greenshot.ps1 -DeploymentType "Install" -DeployMode "NonInteractive"
.\Greenshot-INSTALLER-1.2.10.6-RELEASE.exe /LOADINF=Greenshot.inf /VERYSILENT /NORESTART

Remove-Item -Path $FolderName2
