$groupName = $(Write-Host "Enter AD Group Name" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)
$export_dest = "C:\Users\Administrator\Documents\AD_Group_Members.csv"

Get-ADGroupMember -Identity $groupName | Get-ADUser -Properties DisplayName,EmailAddress | Select-Object Name,DisplayName,EmailAddress,SAMAccountName | Export-CSV -Path $export_dest -NoTypeInformation