<#        
    .SYNOPSIS
     A brief summary of the commands in the file.

    .DESCRIPTION
    A detailed description of the commands in the file.

    .NOTES
    ========================================================================
         Windows PowerShell Source File 
         Created with SAPIEN Technologies PrimalScript 2023
         
         NAME: 
         
         AUTHOR: ATSupport , Advisors Tech
         DATE  : 2/9/2023
         
         COMMENT: 
         
    ==========================================================================
#>

$FolderName = "C:\OEM\Apps"
if (Test-Path $FolderName) {
    Write-Host "Folder Exists"
}
else
{
    New-Item $FolderName -ItemType Directory
    Write-Host "Folder Created Successfully"
}

$source = "https://www.kljwtech.net/apps/CitrixFilesForOutlook-PerMachine-v22.7.17.0.msi"
$destination = "C:\OEM\Apps\CitrixFilesForOutlook-PerMachine-v22.7.17.0.msi"
$appMSI = "CitrixFilesForOutlook-PerMachine-v22.7.17.0.msi"
Invoke-WebRequest -Uri $source -OutFile $destination
Set-Location -Path $FolderName
Start-Process $FolderName\$appMSI -ArgumentList "/quiet"
