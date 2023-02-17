#Written by Jonathan Wood
#Printer Deployment

function Read-InputBoxDialog([string]$Message, [string]$WindowTitle, [string]$DefaultText)
{
    Add-Type -AssemblyName Microsoft.VisualBasic
    return [Microsoft.VisualBasic.Interaction]::InputBox($Message, $WindowTitle, $DefaultText)
}

$textEntered = Read-InputBoxDialog -Message "Enter Printer IP" -WindowTitle "Printer IP" -DefaultText ""
if ($textEntered -eq $null)
{ Write-Host "Canceled" }
else
{ Write-Host "IP Address Entered $textEntered" }

Write-Host "Input Printer Details" -ForegroundColor Green
$PrinterIP = $textEntered

$driverDir = "TOSHIBA Universal PS3"
$driverFile = "Toshiba-eStudio5506AC.zip"
$PrinterName = "Toshiba-eStudio5506AC"

#Check to see if directory exists
$FolderName = "C:\OEM\Printers\$driverDir"
if (Test-Path $FolderName) {
}
else
{ New-Item $FolderName -ItemType Directory }

#Download Drivers
$DriverFolder= "C:\OEM\Printers\$driverDir"
If (Test-Path $DriverFolder){ Remove-Item $DriverFolder -Recurse }

#Xerox Universal Printer
$Url = "https://www.kljwtech.net/printers/$driverFile"
New-Item -ItemType Directory -Force -Path $DriverFolder
$ZipFile = $DriverFolder + $(Split-Path -Path $Url -Leaf)
$Destination = $DriverFolder

Invoke-WebRequest -Uri $Url -OutFile $ZipFile

$ExtractShell = New-Object -ComObject Shell.Application
$Files = $ExtractShell.Namespace($ZipFile).Items()
$ExtractShell.NameSpace($Destination).CopyHere($Files)

Remove-Item C:\OEM\Printers\Xerox* -Include *.zip

#Load Drivers into Driver Store
Invoke-Command {pnputil /add-driver "C:\OEM\Printers\$driverDir\*.inf" /install}

#Remove-Printer -Name "VersaLink" -ErrorAction SilentlyContinue
#Remove-PrinterPort -Name XeroxPrinter -ErrorAction SilentlyContinue

#Install Printer
$portName = $PrinterIP
$printDriverName = $PrinterName

$portExists = Get-Printerport -Name $portname -ErrorAction SilentlyContinue
if (-not $portExists) {
  Add-PrinterPort -name $portName -PrinterHostAddress $PrinterIP
}
$printDriverExists = Get-PrinterDriver -name $printDriverName -ErrorAction SilentlyContinue
if ($printDriverExists) {
    Add-Printer -Name $PrinterName -PortName $portName -DriverName $printDriverName
}else{
    Add-PrinterDriver -Name $printDriverName -Verbose
    Add-Printer -Name $PrinterName -PortName $portName -DriverName $printDriverName
}

#Sets Color Preference to Black and White Default
Set-PrintConfiguration -PrinterName $PrinterName -Color $true