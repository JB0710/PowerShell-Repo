$domain = Read-Host "Enter name of the domain to join" 
[System.Management.Automation.PSCredential]$Credential = $(Get-Credential) 
(Get-WmiObject Win32_ComputerSystem ).JoinDomainOrWorkgroup($Domain,$Credential.GetNetworkCredential().Password,$Credential.UserName,$null,3) 
Write-Host "Computer joined to domain successfully " 
