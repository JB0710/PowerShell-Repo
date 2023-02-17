#Preferences
$ErrorActionPreference = 'SilentlyContinue'

#Mimecast Connection Filter Policy IPs
$user = $(Write-Host "Enter M365 Admin UserName" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)
Start-Sleep 15
Connect-ExchangeOnline -UserPrincipalName $user

New-OutboundConnector -Name "Global Relay Outbound Connector" -ConnectorType Partner -ConnectorSource AdminUI -RecipientDomains mso365.globalrelay.com -UseMXRecord $true -TlsSettings CertificateValidation
Write-Host "M365 Mail Connector Created" -ForegroundColor Green
Start-Sleep 5