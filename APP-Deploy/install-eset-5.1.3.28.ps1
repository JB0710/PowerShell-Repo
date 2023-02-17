$FolderName = "C:\OEM\Apps"
if (Test-Path $FolderName) {
    Write-Host "Folder Exists"
}
else
{
    New-Item $FolderName -ItemType Directory
    Write-Host "Folder Created Successfully"
}

$file = "eee_nt64_enu.msi"
$source = "https://www.kljwtech.net/apps/$file"
$destination = "C:\OEM\Apps\$file"
Invoke-WebRequest -Uri $source -OutFile $destination
Set-Location -Path $FolderName

$DataStamp = get-date -Format yyyyMMddTHHmmss
$logFile = '{0}-{1}.log' -f $file,$DataStamp
$MSIArguments = @(
    "/i"
    ('"{0}"' -f $file)
    "/qbn"
    "/norestart"
    "/L*v"
    $logFile
)
Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow

