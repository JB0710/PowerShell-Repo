$AllReciepient = Get-MessageTrace -StartDate (Get-Date).Adddays(-10) -EndDate (Get-Date) | Group-Object -Property ReciepientAddress | Select-Object name
$AllReciepient = $AllReciepient.name
$ErrorActionPreference = "SilentlyContinue"
ForEach ($sender in $AllReciepient)
{
Get-MessageTrace -StartDate (Get-Date).Adddays(-3) -EndDate (Get-Date) -ReciepientAddress $sender | Export-Csv "A:\Clients\PTFT Group\$sender.csv" -NoTypeInformation -Encoding UTF8
}