# ----- Legal: ----
# Sample scripts are not supported under any N-able support program or service.
# The sample scripts are provided AS IS without warranty of any kind.
# N-able expressly disclaims all implied warranties including, warranties
# of merchantability or of fitness for a particular purpose.
# In no event shall N-able or any other party be liable for damages arising
# out of the use of or inability to use the sample scripts.
# -----------------------------------------------------------

# Original version written by Steve Knight, used with permission
# For more information and additional scripts, see http://scripts.dragon-it.uk/

# Script written Mar 2021, Steve Knight.
# Uses Robocopy so that it can identify files with long path names over approx 260 chars
# V1.0 - Allow filtering by path length, size and age.  Default is all paths over 240 characters
# V1.1 - -NoRecurse : Choose whether to recurse subdirectories or just the chosen folder
# V1.2 - -SizeScale : Allow reporting / checking sizes in Mb, Gb, Kb, or Bytes
#        -SortBy : Sort by this field, Len, FullName, Size, Date
# V1.3 - -CSV : Allow export to CSV file of the files found in addition to screen
# V1.4 - bug fixes + exclude "System Volume Information" folder

param ([string]$StartPath='',[int]$MinPathLength=240,[int]$MinSize=0,[int]$MinAge=0,[int]$MaxAge=0,[string]$SortBy="Size",[string]$SizeScale="MB",[switch]$NoRecurse=$False,
[switch]$IgnoreErrors=$False,[switch]$HideCriteria=$False,[string]$CSV='')

if ($StartPath -eq '') {
    Write-Output "Must specify path to search!"
    exit 1
    }

$Recurse= -not $NoRecurse

# Uses robocopy options to filter on age and size
#             /MIN:n :: MINimum file size - exclude files smaller than n bytes.
#          /MAXAGE:n :: MAXimum file AGE - exclude files older than n days/date.
#          /MINAGE:n :: MINimum file AGE - exclude files newer than n days/date.

# Get factor to use for size checks and how many decimal places to show
switch ($SizeScale.ToUpper()) {
    "MB" {$ScaleSize="Mb";$Scale=1024*1024;$Decimal=2; break}
    "GB" {$ScaleSize="Gb";$Scale=1024*1024*1024;$Decimal=2; break}
    "B" {$ScaleSize="Bytes";$Scale=1;$Decimal=0; break}
    "KB" {$ScaleSize="Kb";$Scale=1024;$Decimal=0; break}
    Default {$ScaleSize="Mb";$Scale=1024*1024;$Decimal=2; break}
}

$RoboCopyCommand=@($StartPath,$env:TEMP,"/L","/NJH","/NJS","/BYTES","/FP","/NC","/NDL","/TS","/XJ","/R:0","/W:0","/XX","/IS","/IT","/XD","""System Volume information""")

if ($MinSize -ne 0) {$RoboCopyCommand+="/Min:$($MinSize*$Scale)"}
if ($MinAge -ne 0) {$RoboCopyCommand+="/MinAge:$MinAge"}
if ($MaxAge -ne 0) {$RoboCopyCommand+="/MaxAge:$MaxAge"}
if ($Recurse -eq $True) {$RoboCopyCommand+="/S"}

$FileList=@()
$TotalSize=0

$Output=(Robocopy $RoboCopyCommand)

if ($LastExitCode -gt 15) {
    Write-Host "ERROR $LastExitCode from ROBOCOPY:`r`n"
    Write-output $Output
    exit 1
}

$Output | ForEach {
    If ($_ -match "(?<Size>\d+)\s(?<Date>\S+\s\S+)\s+(?<FullName>.*)") {
        if ($MinPathLength -eq 0 -or $matches.FullName.length -gt $MinPathLength) {
            $File=New-Object PSObject -Property @{
                Len=$Matches.FullName.Length
                FullName = $matches.FullName
                Size = [math]::Round($matches.Size/$scale,$Decimal)
                Date = [datetime]$matches.Date
            }
            $FileList+=$File
            $TotalSize+=$File.Size
        }
    }
}

$Criteria=''
if ($HideCriteria -eq $False) {
    $Criteria="Selection criteria:`r`n"
    if ($MinPathLength -gt 0) {$Criteria+="* Path length over $MinPathLength characters`r`n"}
    if ($MinSize -gt 0) {$Criteria+="* File size over $MinSize $SizeScale`r`n"}
    if ($MinAge -gt 0) {$Criteria+="* File age is over $MinAge days`r`n"}
    if ($MaxAge -gt 0) {$Criteria+="* File age is under $MaxAge days`r`n"}
    $Criteria+="* All sizes are in $SizeScale`r`n"
    $Criteria+="* Command used: ROBOCOPY $RoboCopyCommand`r`n"
}

if ($FileList.count -eq 0) {
    write-host "OK: NO MATCHING FILES FOUND`r`n"
    write-host $Criteria
    exit 0
}

write-host "FAIL: $($FileList.count) MATCHING FILES FOUND. TOTAL SIZE $TotalSize $SizeScale`r`n"
write-host "$Criteria"
$FileList | Sort-Object -Property $($SortBy) -Descending | format-table -Property Len,Date,@{L="Size $SizeScale";E={"{0,12:N$Decimal}" -f $_.size}},FullName -AutoSize | Out-String -Width 400

if ($CSV -ne '') {$FileList | Sort-Object -Property $($SortBy) -Descending | export-csv -Path "$CSV"}

if ($IgnoreErrors -eq $False) {
    exit 1
} ELSE {
    exit 0
}

