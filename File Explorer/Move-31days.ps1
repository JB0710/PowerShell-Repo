Start-Transcript -Path "C:\OEM\Logs\AutoArchiving.log" -Append -NoClobber

$source1 ="A:\Apps"
$destination1 ="H:\Apps"
Get-ChildItem -Path "$source1" |
    Where-Object {$_.LastWriteTime -lt (get-date).AddDays(-31)} | 
    move-item -destination "$destination1"
    
$source2 ="B:\Zipped"
$destination2 ="H:\Zipped"
Get-ChildItem -Path "$source2" |
    Where-Object {$_.LastWriteTime -lt (get-date).AddDays(-31)} | 
    move-item -destination "$destination2"
    