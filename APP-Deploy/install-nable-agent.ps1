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
         DATE  : 1/31/2023
         
         COMMENT: 
         
    ==========================================================================
#>
$customerID = 296
$customerSpecific = 1
$registrationToken = 161775fc-fe5d-b002-9a37-daeb795cb895
$serverProtocol = https
$serverAddress = msp.advisorstech.com
$serverPort = 443

$fileDownload = "WindowsAgentSetup.exe"

$FolderName = "C:\OEM\Apps"

if (Test-Path $FolderName) 
{

}
else
{
    New-Item $FolderName -ItemType Directory
}






$source = "https://www.kljwtech.net/apps/$fileDownload"
$destination = "C:\OEM\Apps\$fileDownload"
Invoke-WebRequest -Uri $source -OutFile $destination
Set-Location -Path $FolderName
Start-Process $FolderName\$fileDownload -ArgumentList "/quiet /v" /qn CUSTOMERID=$customerID CUSTOMERSPECIFIC=$customerSpecific REGISTRATION_TOKEN=$registrationToken SERVERPROTOCOL=$serverProtocol SERVERADDRESS=$serverAddress SERVERPORT=$serverPort ""

WindowsAgentSetup.exe /quiet /v" /qn CUSTOMERID=$customerID CUSTOMERSPECIFIC=$customerSpecific REGISTRATION_TOKEN=$registrationToken SERVERPROTOCOL=$serverProtocol SERVERADDRESS=$serverAddress SERVERPORT=$serverPort "