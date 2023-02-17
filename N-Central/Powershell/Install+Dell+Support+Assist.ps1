 
# Silent Install Dell Support Assist
# https://downloads.dell.com/serviceability/catalog/SupportAssistInstaller.exe

# Path for the workdir
$workdir = "c:\temp\"
 
$DellSAInstalled = Test-Path -Path "C:\Program Files\Dell\SupportAssistAgent"
 
If ($DellSAInstalled){ 
    Write-Host "Installed!"
} ELSE { 
    Write-Host "Doing the installation first"
 
 
 
    # Check if work directory exists if not create it
 
    If (Test-Path -Path $workdir -PathType Container){ 
        Write-Host "$workdir already exists" -ForegroundColor Red
    } ELSE { 
        New-Item -Path $workdir  -ItemType directory 
    }
 
    # Download the installer
 
    $source = "https://downloads.dell.com/serviceability/catalog/SupportAssistInstaller.exe"
    $destination = "$workdir\SupportAssistInstaller.exe"
 
    # Check if Invoke-Webrequest exists otherwise execute WebClient
 
    if (Get-Command 'Invoke-Webrequest'){
        Invoke-WebRequest $source -OutFile $destination
    } else {
        $WebClient = New-Object System.Net.WebClient
        $webclient.DownloadFile($source, $destination)
    }
 
    # Start the installation
    Start-Process -FilePath "$workdir\SupportAssistInstaller.exe" -ArgumentList "/S"
    Write-Host "Doing the installation first"
}