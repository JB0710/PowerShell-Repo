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
         DATE  : 2/7/2023
         
         COMMENT: 
         
    ==========================================================================
#>
$folder1 ="D:\"

function CleanUpDownloads 
	{
		Remove-Item $folder1* -Include *.crdownload
		Remove-Item $folder1* -Include *.jnlp
		Remove-Item $folder1* -Include *.apk
		Remove-Item $folder1* -Include *.gpg
		Remove-Item $folder1* -Include *.wri
		Remove-Item $folder1* -Include *.dmg
		Remove-Item $folder1* -Include *.key
		Remove-Item $folder1* -Include *.diagcab
		Remove-Item $folder1* -Include *.one
		Remove-Item $folder1* -Include *.onepkg
		Remove-Item $folder1* -Include *.reg
		Remove-Item $folder1* -Include *.nupkg
		Remove-Item $folder1* -Include *.url
		Remove-Item $folder1* -Include *.wav
		Remove-Item $folder1* -Include *.txt
		Remove-Item $folder1* -Include *.vcs
		
		
	}

function CleanUpDiskSpace
	{
		param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string[]]$Section
)

		$sections = @(
		    'Active Setup Temp Folders',
		    'BranchCache',
		    'Content Indexer Cleaner',
		    'Device Driver Packages',
		    'Downloaded Program Files',
		    'GameNewsFiles',
		    'GameStatisticsFiles',
		    'GameUpdateFiles',
		    'Internet Cache Files',
		    'Memory Dump Files',
		    'Offline Pages Files',
		    'Old ChkDsk Files',
		    'Previous Installations',
		    'Recycle Bin',
		    'Service Pack Cleanup',
		    'Setup Log Files',
		    'System error memory dump files',
		    'System error minidump files',
		    'Temporary Files',
		    'Temporary Setup Files',
		    'Temporary Sync Files',
		    'Thumbnail Cache',
		    'Update Cleanup',
		    'Upgrade Discarded Files',
		    'User file versions',
		    'Windows Defender',
		    'Windows Error Reporting Archive Files',
		    'Windows Error Reporting Queue Files',
		    'Windows Error Reporting System Archive Files',
		    'Windows Error Reporting System Queue Files',
		    'Windows ESD installation files',
		    'Windows Upgrade Log Files'
		)
		
		if ($PSBoundParameters.ContainsKey('Section')) {
		    if ($Section -notin $sections) {
		        throw "The section [$($Section)] is not available. Available options are: [$($Section -join ',')]."
		    }
		} else {
		    $Section = $sections
		}
		
		Write-Verbose -Message 'Clearing CleanMgr.exe automation settings.'
		
		$getItemParams = @{
		    Path        = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\*'
		    Name        = 'StateFlags0001'
		    ErrorAction = 'SilentlyContinue'
		}
		Get-ItemProperty @getItemParams | Remove-ItemProperty -Name StateFlags0001 -ErrorAction SilentlyContinue
		
		Write-Verbose -Message 'Adding enabled disk cleanup sections...'
		foreach ($keyName in $Section) {
		    $newItemParams = @{
		        Path         = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\$keyName"
		        Name         = 'StateFlags0001'
		        Value        = 1
		        PropertyType = 'DWord'
		        ErrorAction  = 'SilentlyContinue'
		    }
		    $null = New-ItemProperty @newItemParams
		}
		
		Write-Verbose -Message 'Starting CleanMgr.exe...'
		Start-Process -FilePath CleanMgr.exe -ArgumentList '/sagerun:1' -NoNewWindow -Wait
		
		Write-Verbose -Message 'Waiting for CleanMgr and DismHost processes...'
		Get-Process -Name cleanmgr, dismhost -ErrorAction SilentlyContinue | Wait-Process
	
	
	}
Start-Transcript -Path "C:\OEM\Logs\DiskCleanUp.log" -Append -NoClobber
CleanUpDownloads
Clear-RecycleBin -Force
CleanUpDiskSpace

