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
$source = "A:\Scripts\*"
$destination = "A:\Github\PowerShell-Repo\"
Copy-Item -Path $source -Destination $destination -Recurse