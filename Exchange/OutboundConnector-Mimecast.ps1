#Preferences
$ErrorActionPreference = 'SilentlyContinue'

#Mimecast Connection Filter Policy IPs
$user = $(Write-Host "Enter M365 Admin UserName" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)
Start-Sleep 15
Connect-ExchangeOnline -UserPrincipalName $user
New-OutboundConnector -Name "Office365 to Mimecast" -ConnectorType Partner -ConnectorSource AdminUI -RecipientDomains * -SmartHosts us-smtp-o365-outbound-1.mimecast.com, us-smtp-o365-outbound-2.mimecast.com -TlsSettings CertificateValidation -UseMXRecord $false
Write-Host "M365 Mail Connector Created" -ForegroundColor Green
Start-Sleep 5