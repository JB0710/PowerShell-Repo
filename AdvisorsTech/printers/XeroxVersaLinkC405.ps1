#Written by Jonathan Wood
#Printer Deployment
Write-Host "Input Printer Details" -ForegroundColor Green
$PrinterIP = Read-Host -Prompt "Enter Printer IP Address"
$PrinterName = Read-Host -Prompt "Enter Printer Name"

#Check to see if directory exists
$FolderName = "C:\OEM\Printers\Xerox-C405"
if (Test-Path $FolderName) {
}
else
{ New-Item $FolderName -ItemType Directory }

#Download Drivers
$DriverFolder= "C:\OEM\Printers\Xerox-C405"
If (Test-Path $DriverFolder){ Remove-Item $DriverFolder -Recurse }

#Xerox Universal Printer
$Url = 'https://www.kljwtech.net/files/drivers/printers/xerox-c405.zip' 
New-Item -ItemType Directory -Force -Path $DriverFolder
$ZipFile = $DriverFolder + $(Split-Path -Path $Url -Leaf) 
$Destination = $DriverFolder
 
Invoke-WebRequest -Uri $Url -OutFile $ZipFile 
 
$ExtractShell = New-Object -ComObject Shell.Application 
$Files = $ExtractShell.Namespace($ZipFile).Items() 
$ExtractShell.NameSpace($Destination).CopyHere($Files) 

Remove-Item C:\OEM\Printers\Xerox* -Include *.zip

#Load Drivers into Driver Store
Invoke-Command {pnputil /add-driver "C:\OEM\Printers\Xerox-C405\*.inf" /install} 

Remove-Printer -Name "VersaLink" -ErrorAction SilentlyContinue
Remove-PrinterPort -Name XeroxPrinter -ErrorAction SilentlyContinue

#Install Printer
$portName = "XeroxPrinter"
$printDriverName = "Xerox VersaLink C405 PCL6"

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