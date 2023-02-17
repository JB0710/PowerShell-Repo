#Preferences
$ErrorActionPreference = 'SilentlyContinue'

#Mimecast Connection Filter Policy IPs
$user = $(Write-Host "Enter M365 Admin UserName" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host) 

#Connect to ExchangeOnline
Connect-ExchangeOnline -UserPrincipalName $user