#Deleted emails are stored for Shared Mailboxes
$path3 = 'HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Options'
$name3 = 'DelegateWastebasketStyle'
$value3 = '4'

IF(!(Test-Path $path3))
  {
    New-Item -Path $path3 -Force | Out-Null
    New-ItemProperty -Path $path3 -Name $name3 -Value $value3 `
    -PropertyType DWORD -Force | Out-Null}

 ELSE {
    New-ItemProperty -Path $path3 -Name $name3 -Value $value3 `
    -PropertyType DWORD -Force | Out-Null}