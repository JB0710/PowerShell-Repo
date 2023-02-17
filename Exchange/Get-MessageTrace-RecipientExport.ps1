$AllReciepient = Get-MessageTrace -StartDate (Get-Date).Adddays(-10) -EndDate (Get-Date) | Group-Object -Property ReciepientAddress | Select-Object name
$AllReciepient = $AllReciepient.name
$ErrorActionPreference = "SilentlyContinue"
ForEach ($reciepient in $AllReciepient)
{
Get-MessageTrace -StartDate (Get-Date).Adddays(-3) -EndDate (Get-Date) -ReciepientAddress $reciepient | Export-Csv "A:\Clients\PTFT Group\$sender.csv" -NoTypeInformation -Encoding UTF8
}

Start-HistoricalSearch -ReportTitle "Export for Mimecast" -StartDate 08/01/2022 -EndDate 11/15/2022 -ReportType MessageTrace | Select-Object RecipientAddress, SenderAddress, OriginalClientIP