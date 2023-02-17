#Auto Lock 5 Minutes
$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$name = 'InactivityTimeoutSecs'
$value= '900'
IF(!(Test-Path $path))
  {
    New-Item -Path $path -Force | Out-Null
    New-ItemProperty -Path $path -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}
 ELSE {
    New-ItemProperty -Path $path -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null}