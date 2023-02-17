$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://www.kljwtech.net/nextiva-win.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'nextiva-one'

  checksum      = '02109430005390E780C3BEF8DA665A903CCDAAB4292C85A2E7372046B59D4147'
  checksumType  = 'sha256' 

  # MSI
  silentArgs   = '/S'           
  validExitCodes= @(0, 3010, 1641)
  
}

Install-ChocolateyPackage @packageArgs 

