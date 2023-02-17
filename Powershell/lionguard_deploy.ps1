#Source URL
$url = https://kljwtech.net/shared/lionguard/LiongardAgent-lts.msi
#Destination
$dest = "C:\Temp\LiongardAgent-lts.msi"
#
Invoke-WebRequest -Uri $url -OutFile $dest
#
cd c:\Temp
#
msiexec /i LiongardAgent-lts.msi LIONGARDURL=us7.app.liongard.com LIONGARDACCESSKEY="c60a68ba87f753f20a57" LIONGARDACCESSSECRET="17abb810c379a4503c3fe37ad4218e3ba5a54e1d5ba8a6a6a1f2be83353eb360" LIONGARDENVIRONMENT="KLJWTech LLC"/qn
#