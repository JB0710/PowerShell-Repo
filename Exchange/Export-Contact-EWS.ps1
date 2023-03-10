function Export-ExchangeContacts {
[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline,
        Mandatory=$true,
        HelpMessage="Enter mailboxes")]
    [Object] $Mailbox,
    [Parameter(HelpMessage="Enter FQDN of the Exchange Server to connect to")]
    [String] $Server = "defaultExchangeServer",
    [Parameter(HelpMessage="Enter UNC path of location to save PSTs")]
    [String] $ExportPath = (Convert-Path .),
    [Parameter(HelpMessage="Enter number of exports to run simultaneously")]
    [Int] $SimultaneousJobs = 20,
    [Parameter(HelpMessage="Enter number of seconds to wait before checking for completed requests")]
    [Int] $WaitTime = 15,
    [Parameter(HelpMessage="Display total script run time after completion")]
    [Switch] $ShowRuntime
)
BEGIN {
    ### Validate parameters ###
    if (!(Test-Path $ExportPath -PathType Container -ErrorAction SilentlyContinue)){
        Throw "$ExportPath is not a valid folder"
    } else {
        Write-Verbose "PSTs will be exported to $ExportPath..."
    }

    ### Set the inputs and outputs for exported data ###
    $StopWatch = [system.diagnostics.stopwatch]::StartNew()
    if ($ExportPath[-1] -ne "\"){$ExportPath += "\"}
    $timestamp = (Get-Date).tostring('yyyyMMddHHmmss')
    $batch = "Contacts_Export_$timestamp"
    Write-Verbose "$SimultaneousJobs Exports will be run concurrently..."

    ### Connect to Exchange ###
    Try {
        Test-PowerShellConnectivity -ClientAccessServer $Server -ErrorAction SilentlyContinue | Out-Null
        Write-Verbose "Verified connection to $Server"
        $ScriptConnection = $false
    } Catch {
        Write-Verbose "Connecting to $Server..."
        $Session = New-PSSession -ConfigurationName microsoft.exchange -ConnectionUri http://$Server/powershell -Authentication Kerberos
        Import-PSSession -Session $Session -AllowClobber
        $ScriptConnection = $true
    }
}
PROCESS {
    Try {
        ### Loop through each mailbox to begin export ###
        foreach ($m in $Mailbox){
            $PSTfile = $ExportPath + $m.Alias + ".pst"
            $exportName = $m.Alias + "_" + $batch

            $retries = 3
            $success = $false
            do {
                Try {
                    New-MailboxExportRequest -Mailbox $m.Alias -IncludeFolders "#Contacts#" -BatchName $batch -Name $exportName -FilePath $PSTfile -ExcludeDumpster -ErrorAction Stop | Out-Null
                    Write-Verbose "$exportName starting..."
                    $exportStatus = Get-MailboxExportRequest -Name $exportName | Select-Object -ExpandProperty "Status"
                    if ($exportStatus -ne $null) {
                        Write-Verbose "$exportName Status: $exportStatus"
                        $success = $true
                    }
                } Catch { #[System.Management.Automation.RuntimeException] { #PSRemotingTransportException
                    Write-Error $_
                    $exportStatus = Get-MailboxExportRequest -Name $exportName | Select-Object -ExpandProperty "Status"
                    if ($exportStatus -ne $null) {
                        Write-Verbose "$exportName Status: $exportStatus"
                        $success = $true
                    } else {
                        Write-Verbose "$exportName export may have failed..."
                    }
                    if ($success -eq $false) {
                        $retries--
                        if ($retries -gt 0) {
                            Write-Verbose "Retrying in 60 seconds..."
                            Start-Sleep 60
                        } else {
                            Write-Verbose "Too many failed retries. Skipping $exportName."
                        }
                    }
                }
            } while (($retries -gt 0) -and ($success -eq $false))

            ### Check number of Requests running and sleep if there are 20 or more ###
            do {
                $runCount = @(Get-MailboxExportRequest | where {$_.BatchName -eq $batch -and $_.status -ne "Completed" -and $_.status -ne "Failed"}).count
                Write-Verbose "$runCount Exports are InProgress..."
                if ($runCount -ge $simultaneousJobs) {
                    Write-Verbose "Waiting $WaitTime seconds..."
                    Start-Sleep -Seconds $WaitTime
                }
            } while ($runCount -ge $simultaneousJobs)
        }
    } Catch {
        Write-Error $_
    }
}
END {
    ### Wait for all Requests to be Completed/Failed ###
    do {
        $runCount = @(Get-MailboxExportRequest | where {$_.BatchName -eq $batch -and $_.status -ne "Completed" -and $_.status -ne "Failed"}).count
        Write-Verbose "$runCount Exports are InProgress..."
        if ($runCount -gt 0) {
            Write-Verbose "Waiting 60 seconds for all Exports to Complete..."
            Start-Sleep -Seconds 60
        }
    } while ($runCount -gt 0)

    ### Export and remove completed results ###
    $LogPath = $ExportPath + "Logs\"
    if (!(Test-Path $LogPath -PathType Container -ErrorAction SilentlyContinue)){
        Write-Verbose "$LogPath does not exist"
        Write-Verbose "Creating $LogPath folder"
        New-Item -Path $LogPath -ItemType Directory | Out-Null
    }
    $resultCsv = $LogPath + "$batch.csv"
    $currentExportBatch = Get-MailboxExportRequest | where {$_.BatchName -eq $batch -and ($_.status -eq "Completed" -or $_.status -eq "Failed")}
    Write-Verbose "Saving export results to $resultCsv..."
    $currentExportBatch | Export-Csv -Path $resultCsv -NoClobber -NoTypeInformation
    Write-Verbose "Removing Completed/Failed Exports from the export batch $batch..."
    $currentExportBatch | Remove-MailboxExportRequest -Confirm:$false
    Write-Verbose "Contacts Export COMPLETE"

    ### Disconnect from Exchange ###
    if ($ScriptConnection -eq $true) {
        Remove-PSSession -Session $Session
        Write-Verbose "Disconnected PSSession from $Server..."
    }

    ### Display run time/duration ###
    $StopWatch.Stop()
    if ($showRuntime) {Write-Output "Total script run time: $($StopWatch.Elapsed.TotalHours) Hours"}
}
}