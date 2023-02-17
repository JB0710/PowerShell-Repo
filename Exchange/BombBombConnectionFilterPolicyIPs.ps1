#Preferences
$ErrorActionPreference = 'SilentlyContinue'

#Mimecast Connection Filter Policy IPs
$user = $(Write-Host "Enter M365 Admin UserName" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)

Function dehydrated {
    [cmdletbinding()]

    $dehyStatus = Get-OrganizationConfig | Select-Object -ExpandProperty IsDehydrated

    Write-Host ('{0,-10}' -f "`nStatus")
    Write-Host ('{0,-10}' -f '------')

    $dehyStatusRestuls | ForEach-Object{
                $color = if(-not ($dehyStatus -eq '$false')){'green'}elseif($dehyStatus -contains '$true'){'red'}else{'Yellow'}
                $line = "{0,-10}" -f $dehyStatus
                Write-Host $line -fore $color
                If ($color -eq 'red') {
                Write-Host "`nIsDehydrated" -fore $color
                }
                else {
                Write-Host "`nNot Dehydrated" -fore $color
               }
        }
    }

Start-Sleep 5
Connect-ExchangeOnline -UserPrincipalName $user
Start-Sleep 5
dehydrated
Enable-OrganizationCustomization -ErrorAction SilentlyContinue
Write-Host "OrganizationCustomization Enabled" -ForegroundColor Green
Write-Host "This will take some time to udpate, timer set for 1hr" -ForegroundColor DarkYellow
Start-Sleep 5400
Set-HostedConnectionFilterPolicy -Identity Default -IPAllowList @{Add="104.193.74.128/27", "173.213.231.164/30", "173.213.231.168/29"}
