#Function to download a library from SharePoint Online
Function Download-PnPLibrary
{
    [cmdletbinding()]
    param
    (
        [Parameter(Mandatory=$true)][Microsoft.SharePoint.Client.List]$List,
        [Parameter(Mandatory=$true)][string]$DownloadPath
    )
    Try {
        Write-host -f Yellow "Downloading Document Library:"$List.Title
        #Create a Local Folder for the Document Library, if it doesn't exist
        $LibraryFolder = $DownloadPath +"\" +$List.RootFolder.Name
        If (!(Test-Path -Path $LibraryFolder)) {
                New-Item -ItemType Directory -Path $LibraryFolder | Out-Null
        }
 
        #Get all Items from the Library - with progress bar
        $global:counter = 0
        $ListItems = Get-PnPListItem -List $List -PageSize 500 -Fields ID -ScriptBlock { Param($items) $global:counter += $items.Count; Write-Progress -PercentComplete `
                    ($global:Counter / ($List.ItemCount) * 100) -Activity "Getting Items from Library:" -Status "Processing Items $global:Counter to $($List.ItemCount)";}
        Write-Progress -Activity "Completed Retrieving Items from Library $($List.Title)" -Completed
 
        #Get all Subfolders of the library
        $SubFolders = $ListItems | Where {$_.FileSystemObjectType -eq "Folder" -and $_.FieldValues.FileLeafRef -ne "Forms"}
        $SubFolders | ForEach-Object {
            #Ensure All Folders in the Local Path
            $LocalFolderPath = $DownloadPath + ($_.FieldValues.FileRef.Substring($Web.ServerRelativeUrl.Length)) -replace "/","\"
            #Create Local Folder, if it doesn't exist
            If (!(Test-Path -Path $LocalFolderPath)) {
                    New-Item -ItemType Directory -Path $LocalFolderPath | Out-Null
            }
            Write-host -f Green "`tEnsured Folder '$LocalFolderPath'"
        }
 
        #Get all Files from the folder
        $FilesColl =  $ListItems | Where {$_.FileSystemObjectType -eq "File"}
 
        #Iterate through each file and download
        $FilesColl | ForEach-Object {
            #Frame the Parameters to download file
            $FileDownloadPath = ($DownloadPath + ($_.FieldValues.FileRef.Substring($Web.ServerRelativeUrl.Length)) -replace "/","\").Replace($_.FieldValues.FileLeafRef,'')
            $FileName = $_.FieldValues.FileLeafRef
            $SourceURL = $_.FieldValues.FileRef
            #Download the File
            Get-PnPFile -ServerRelativeUrl $SourceURL -Path $FileDownloadPath -FileName $FileName -AsFile -force
            Write-host -f Green "`tDownloaded File '$FileName' from '$SourceURL'"
        }
    }
    Catch {
        Write-Host -f Red "Error Downloading Library '$($List.Title)' :"$_.Exception.Message
    }
}
 
#Parameters
$SiteURL = "https://harlowwealth1.sharepoint.com/sites/Compliance"
$DownloadPath ="A:\Clients\Harlow Wealth Management\SharePoint\Compliance"
 
#Connect to SharePoint Online
Connect-PnPOnline $SiteURL -Interactive
$Web = Get-PnPWeb
 
#Exclude certain libraries
$ExcludedLists = @("Form Templates", "Preservation Hold Library","Site Assets", "Pages", "Site Pages", "Images",
                            "Site Collection Documents", "Site Collection Images","Style Library")
 
#Get all non-hidden document libraries
$DocumentLibraries = Get-PnPList -Includes RootFolder | Where {$_.BaseType -eq "DocumentLibrary" -and $_.Title -notin $ExcludedLists -and $_.Hidden -eq $False}
        
#Enumerate each library
ForEach($Library in $DocumentLibraries)
{
    Download-PnPLibrary -List $Library -DownloadPath $DownloadPath
}

#Read more: https://www.sharepointdiary.com/2017/07/download-all-files-from-sharepoint-site.html#ixzz7tVQxTXdH