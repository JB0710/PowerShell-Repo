$csvPath = "A:\Clients\Federal Benefits Retirement Group\Clients.csv"
$csv = Import-CSV $csvPath

$csv | ForEach-Object {
    $user = $_.LastName + ", " + $_.FirstName
    $parentpath = "A:\Clients\Federal Benefits Retirement Group\Clients\"
    $folderpath = Join-Path -Path $parentpath -ChildPath $user
    New-Item $folderpath -ItemType Directory
}