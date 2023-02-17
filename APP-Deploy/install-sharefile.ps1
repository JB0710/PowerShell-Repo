$FolderName = "C:\OEM\Apps"
if (Test-Path $FolderName) {
    Write-Host "Folder Exists"
}
else
{
    New-Item $FolderName -ItemType Directory
    Write-Host "Folder Created Successfully"
}

$source = "https://www.kljwtech.net/apps/CitrixFilesForWindows_x64_v22.11.17.0.msi"
$destination = "C:\OEM\Apps\CitrixFilesForWindows_x64_v22.11.17.0.msi"
$appDrMSI = "CitrixFilesForWindows_x64_v22.11.17.0.msi"
Invoke-WebRequest -Uri $source -OutFile $destination
Set-Location -Path $FolderName
Start-Process $FolderName\$appDrMSI -ArgumentList "/quiet"
