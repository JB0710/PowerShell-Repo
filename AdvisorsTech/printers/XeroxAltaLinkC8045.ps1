#Written by Jonathan Wood
#Printer Deployment
Write-Host "Input Printer Details" -ForegroundColor Green
$PrinterIP = Read-Host -Prompt "Enter Printer IP Address"

$driverDir = "xerox-altalinkC8045"
$driverFile = "xerox-altalinkC8045.zip"
$PrinterName = "XeroxAltaLinkPrinter"
$printDriverName = "Xerox AltaLink C8045 PCL6"
$portName = $PrinterIP


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
$Url = "https://www.kljwtech.net/files/drivers/printers/$driverFile"
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

#Install Printer
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