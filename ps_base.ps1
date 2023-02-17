#Preferences
$ErrorActionPreference = 'SilentlyContinue'

#M365 User Name
$user = $(Write-Host "Enter M365 Admin UserName" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host) 

#Connect to ExchangeOnline
Connect-ExchangeOnline -UserPrincipalName $user
