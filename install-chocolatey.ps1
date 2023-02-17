Set-ExecutionPolicy Bypass -Force -Confirm:$false
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco upgrade chocolatey