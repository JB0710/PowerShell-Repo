Start-Transcript -Path "C:\OEM\Onboarding.log" -Append -NoClobber
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Confirm:$false
Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet -AddToPath"

Install-Module -Name WifiTools