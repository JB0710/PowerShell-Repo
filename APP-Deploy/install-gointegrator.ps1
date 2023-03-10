
function InstallGoIntergrator 
{
	$AppFolder = "C:\OEM\Apps"
	if (Test-Path $AppFolder) 
	{
	    Write-Host "Folder Exists"
	}
	else
	{
	    New-Item $AppFolder -ItemType Directory
	    Write-Host "Folder Created successfully"
	}

	$source = "https://www.kljwtech.net/go-integrator.exe"
	$destination = "C:\OEM\Apps\go-integrator.exe"
	$file = "go-integrator.exe"
	Set-Location -Path $AppFolder
	Invoke-WebRequest -Uri $source -OutFile $destination
	Start-Process $file -Verb runAs -ArgumentList "/quiet /norestart"
}

InstallGoIntergrator