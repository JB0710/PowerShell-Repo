$FolderName1 = "C:\OEM\Apps"
if (Test-Path $FolderName1) {
    Write-Host "Folder Exists"
}
else
{
    New-Item $FolderName1 -ItemType Directory
    Write-Host "Folder Created successfully"
}

$source = "https://www.kljwtech.net/sfproc-3.6.51-63c9540d6ddc7e8d9e4137df.msi"
$destination = "C:\OEM\Apps\sfproc-3.6.51-63c9540d6ddc7e8d9e4137df.msi"
$TimeDrMSI = "sfproc-3.6.51-63c9540d6ddc7e8d9e4137df.msi"
Invoke-WebRequest -Uri $source -OutFile $destination
#Expand-Archive -LiteralPath $destination -DestinationPath $FolderName2
Set-Location -Path $FolderName1
Start-Process $FolderName1\$TimeDrMSI -ArgumentList "/quiet"