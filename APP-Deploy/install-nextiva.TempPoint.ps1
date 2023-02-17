Invoke-WebRequest -Uri $Url -OutFile $ZipFile -UseBasicParsing
Start-Process -FilePath "C:\OEM\src\apps\nextiva.exe" -Verb runAs -ArgumentList '/S','/v"/qn"'