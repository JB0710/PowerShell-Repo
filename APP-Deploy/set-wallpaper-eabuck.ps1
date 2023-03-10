
#Create Folder
$FolderName = "C:\OEM\Wallpaper"
if (Test-Path $FolderName) {
    Write-Host "Folder Exists"
}
else
{
    New-Item $FolderName -ItemType Directory
    Write-Host "Folder Created Successfully"
}

#Download Image
$file = "E.A-Buck-Computer-Wallpaper-Logo.jpg"
$source = "https://www.kljwtech.net/images/$file"
$destination = "C:\OEM\Wallpaper\$file"
Invoke-WebRequest -Uri $source -OutFile $destination

# Get each folder under "Users"
$drive = (Get-Location).Drive.Root
$users = Get-ChildItem "$($drive)Users"

# For each user, load and edit their registry
foreach ( $user in $users ) {

    # If this isn't us, load their hive and set the directory
    # If this is us, use HKEY_CURRENT_USER
    if ( $user.Name -ne $env:username ) {
        reg.exe LOAD HKU\Temp "$($drive)Users\$($user.Name)\NTUSER.DAT"
        $dir = "Registry::HKEY_USERS\Temp\Control Panel\Desktop"
    } else {
        $dir = "Registry::HKEY_CURRENT_USER\Control Panel\Desktop"
    }

    # We don't care about users that don't have this directory
    if ( (Test-Path $dir) ) {

        # Set the image
        Set-ItemProperty -Path $dir -Name "Wallpaper" -value "$($drive)Users\Public\Pictures\Sample Pictures\Tulips.jpg"

        # Set the style to stretch
        Set-ItemProperty -Path $dir -Name "WallpaperStyle" -value 2

    }

    # Unload user's hive
    if ( $user.Name -ne $env:username ) {
        [gc]::Collect()
        reg.exe UNLOAD HKU\Temp
    }
}
