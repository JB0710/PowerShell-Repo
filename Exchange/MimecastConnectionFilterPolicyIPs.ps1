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

dehydrated
Start-Sleep 5
Connect-ExchangeOnline -UserPrincipalName $user

Enable-OrganizationCustomization
Write-Host "OrganizationCustomization Enabled" -ForegroundColor Green

Write-Host "This will take some time to udpate, timer set for 1hr" -ForegroundColor DarkYellow
Start-Sleep 3600
Set-HostedConnectionFilterPolicy -Identity Default -IPAllowList @{Add="207.211.31.0/25", "207.211.30.0/24", "205.139.110.0/24", "205.139.111.0/24", "170.10.132.0/24", "170.10.133.0/24", "170.10.128.0/24", "170.10.129.0/24", "170.10.131.0/24", "170.10.130.0/24"}
