<#        
    .SYNOPSIS
     A brief summary of the commands in the file.

    .DESCRIPTION
    A detailed description of the commands in the file.

    .NOTES
    ========================================================================
         Windows PowerShell Source File 
         Created with SAPIEN Technologies PrimalScript 2023
         
         NAME: 
         
         AUTHOR: ATSupport , Advisors Tech
         DATE  : 2/17/2023
         
         COMMENT: 
         
    ==========================================================================
#>
Start-Sleep -s 10

$User = [Environment]::UserName
$path = "C:\Outlook\" + "$User"
$ClearOutlook = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles"
If(-not(Test-Path -Path $path))
  {
   del $ClearOutlook -force -Recurse
   New-Item -Path $path -type directory
   }