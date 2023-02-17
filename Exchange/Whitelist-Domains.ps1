#Preferences
$ErrorActionPreference = 'SilentlyContinue'

#Domain Whitelist
$user = $(Write-Host "Enter M365 Admin UserName" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)

#Connect to ExchangeOnline
Connect-ExchangeOnline -UserPrincipalName $user

#Domain Whitelist
$ruleName = $(Write-Host "Create Rule Name" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)
#Domain Whitelist
$domainListFilePath = "A:\Scripts\Exchange\domain-whitelist.txt"

#Read the contents of the text file into an array
$safeDomainList = Get-Content $domainListFilePath

#Create a new array and remove all text for each line up to and including the @ symbol, also remove whitespace
$newSafeDomainList = @()
$newSafeDomainList += foreach ($domain in $safeDomainList)
            {
              $tmpdomain = $domain -replace ".*@"
              $tmpdomain.trim()
            }
#If the rule already exists update the existing allowed sender domains, else create a new rule.
if (Get-TransportRule $ruleName -EA SilentlyContinue)
{
  "Updating existing rule..."
  $safeDomainList = Get-TransportRule $ruleName |Select-Object -ExpandProperty SenderDomainIs
  $completeList = $safeDomainList + $newSafeDomainList
  $completeList = $completeList | Select-Object -uniq | Sort-Object
  set-TransportRule $ruleName -SenderDomainIs $completeList
}
else
{
  "Creating new rule..."
  $newSafeDomainList = $newSafeDomainList | Sort-Object
  New-TransportRule $ruleName -SenderDomainIs $newSafeDomainList -SetSCL "-1"
}

