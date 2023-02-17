Start-Transcript -Path "C:\OEM\Onboarding.log" -Append -NoClobber
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco upgrade chocolatey
function DownloadNextiva 
{
	$source = "https://www.kljwtech.net/nextiva-win.exe"
	$destination = "C:\OEM\Apps\nextiva-win.exe"
	$file = "nextiva-win.exe"
	
	$AppFolder = "C:\OEM\Apps\"
	if (Test-Path $AppFolder) 
	{
	    Write-Host "Folder Exists"
	    Set-Location -Path $AppFolder
		Invoke-WebRequest -Uri $source -OutFile $destination	    
	}
	else
	{
	    New-Item $AppFolder -ItemType Directory
	    Write-Host "Folder Created successfully"
	    Set-Location -Path $AppFolder
		Invoke-WebRequest -Uri $source -OutFile $destination
	}

}

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
	Start-Process -FilePath $file -Verb runAs -ArgumentList "/quiet /norestart"
}

DownloadNextiva
choco install nextiva
InstallGoIntergrator
Write-Host "Nextiva Installed Successfully"
