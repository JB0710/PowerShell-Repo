<# 
.NAME
    LazyAdmin
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(766,815)
$Form.text                       = "LazyAdmin 1.0"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#cfcfcf")

$buttonWinUpdate                 = New-Object system.Windows.Forms.Button
$buttonWinUpdate.text            = "Windows Update"
$buttonWinUpdate.width           = 151
$buttonWinUpdate.height          = 33
$buttonWinUpdate.Anchor          = 'top,bottom,left'
$buttonWinUpdate.location        = New-Object System.Drawing.Point(11,12)
$buttonWinUpdate.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$buttonWinUpdate.BackColor       = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")

$buttonWinUpgrade                = New-Object system.Windows.Forms.Button
$buttonWinUpgrade.text           = "Windows Upgrade"
$buttonWinUpgrade.width          = 149
$buttonWinUpgrade.height         = 30
$buttonWinUpgrade.location       = New-Object System.Drawing.Point(13,47)
$buttonWinUpgrade.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$buttonWinUpgrade.BackColor      = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")

$buttonCreateTempFldr            = New-Object system.Windows.Forms.Button
$buttonCreateTempFldr.text       = "Create Temp Download Folder"
$buttonCreateTempFldr.width      = 275
$buttonCreateTempFldr.height     = 30
$buttonCreateTempFldr.location   = New-Object System.Drawing.Point(227,12)
$buttonCreateTempFldr.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$buttonCreateTempFldr.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#f8e71c")

$buttonDownSyncro                = New-Object system.Windows.Forms.Button
$buttonDownSyncro.text           = "Download SyncroMSP"
$buttonDownSyncro.width          = 275
$buttonDownSyncro.height         = 30
$buttonDownSyncro.location       = New-Object System.Drawing.Point(227,47)
$buttonDownSyncro.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$buttonDownSyncro.BackColor      = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2")

$buttonDownloadDellSupportAssist   = New-Object system.Windows.Forms.Button
$buttonDownloadDellSupportAssist.text  = "Download Dell Support Assist"
$buttonDownloadDellSupportAssist.width  = 276
$buttonDownloadDellSupportAssist.height  = 30
$buttonDownloadDellSupportAssist.location  = New-Object System.Drawing.Point(226,81)
$buttonDownloadDellSupportAssist.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$buttonDownloadDellSupportAssist.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#50e3c2")

$buttonInstallO365               = New-Object system.Windows.Forms.Button
$buttonInstallO365.text          = "Install O365"
$buttonInstallO365.width         = 116
$buttonInstallO365.height        = 30
$buttonInstallO365.location      = New-Object System.Drawing.Point(12,95)
$buttonInstallO365.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$buttonInstallO365.BackColor     = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$buttonIntuneAutoPilot           = New-Object system.Windows.Forms.Button
$buttonIntuneAutoPilot.text      = "Intune AutoPilot HWID"
$buttonIntuneAutoPilot.width     = 215
$buttonIntuneAutoPilot.height    = 30
$buttonIntuneAutoPilot.location  = New-Object System.Drawing.Point(13,130)
$buttonIntuneAutoPilot.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$buttonIntuneAutoPilot.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$buttonBlackViper                = New-Object system.Windows.Forms.Button
$buttonBlackViper.text           = "BlackViper"
$buttonBlackViper.width          = 103
$buttonBlackViper.height         = 30
$buttonBlackViper.location       = New-Object System.Drawing.Point(649,17)
$buttonBlackViper.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$buttonBlackViper.ForeColor      = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$buttonBlackViper.BackColor      = [System.Drawing.ColorTranslator]::FromHtml("#f80707")

$ButtonExecute                   = New-Object system.Windows.Forms.Button
$ButtonExecute.text              = "Execute"
$ButtonExecute.width             = 81
$ButtonExecute.height            = 30
$ButtonExecute.location          = New-Object System.Drawing.Point(12,404)
$ButtonExecute.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$ButtonExecute.BackColor         = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")

$ScriptList                      = New-Object system.Windows.Forms.ListBox
$ScriptList.text                 = "listBox"
$ScriptList.width                = 265
$ScriptList.height               = 177
$ScriptList.location             = New-Object System.Drawing.Point(13,221)
$ScriptList.BackColor            = [System.Drawing.ColorTranslator]::FromHtml("#dcdcdc")

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "PowerShell Scripts"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(19,195)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',13,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Label1.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$ButtonDownloadWindows           = New-Object system.Windows.Forms.Button
$ButtonDownloadWindows.text      = "MediaCreationTool"
$ButtonDownloadWindows.width     = 150
$ButtonDownloadWindows.height    = 30
$ButtonDownloadWindows.location  = New-Object System.Drawing.Point(307,220)
$ButtonDownloadWindows.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonDownloadWindows.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$ButtonWinKits                   = New-Object system.Windows.Forms.Button
$ButtonWinKits.text              = "Windows 10 Dev Kit"
$ButtonWinKits.width             = 150
$ButtonWinKits.height            = 30
$ButtonWinKits.location          = New-Object System.Drawing.Point(307,257)
$ButtonWinKits.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonWinKits.BackColor         = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$ButtonWinDevSamples             = New-Object system.Windows.Forms.Button
$ButtonWinDevSamples.text        = "Dev Samples"
$ButtonWinDevSamples.width       = 101
$ButtonWinDevSamples.height      = 30
$ButtonWinDevSamples.location    = New-Object System.Drawing.Point(307,294)
$ButtonWinDevSamples.Font        = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonWinDevSamples.BackColor   = [System.Drawing.ColorTranslator]::FromHtml("#f8e71c")

$ButtonDSIMRestorHealth          = New-Object system.Windows.Forms.Button
$ButtonDSIMRestorHealth.text     = "DSIM Restore Health"
$ButtonDSIMRestorHealth.width    = 144
$ButtonDSIMRestorHealth.height   = 30
$ButtonDSIMRestorHealth.location  = New-Object System.Drawing.Point(543,257)
$ButtonDSIMRestorHealth.Font     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonDSIMRestorHealth.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#b8e986")

$ButtonDSMCheckHealth            = New-Object system.Windows.Forms.Button
$ButtonDSMCheckHealth.text       = "DSIM Check Health"
$ButtonDSMCheckHealth.width      = 143
$ButtonDSMCheckHealth.height     = 30
$ButtonDSMCheckHealth.location   = New-Object System.Drawing.Point(543,220)
$ButtonDSMCheckHealth.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonDSMCheckHealth.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#b8e986")

$ButtonDSIMScanHealth            = New-Object system.Windows.Forms.Button
$ButtonDSIMScanHealth.text       = "DSIM Scan Health"
$ButtonDSIMScanHealth.width      = 146
$ButtonDSIMScanHealth.height     = 30
$ButtonDSIMScanHealth.location   = New-Object System.Drawing.Point(542,294)
$ButtonDSIMScanHealth.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonDSIMScanHealth.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#b8e986")

$ButtonDisableIPv6               = New-Object system.Windows.Forms.Button
$ButtonDisableIPv6.text          = "Disable IPv6"
$ButtonDisableIPv6.width         = 105
$ButtonDisableIPv6.height        = 30
$ButtonDisableIPv6.location      = New-Object System.Drawing.Point(542,364)
$ButtonDisableIPv6.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonDisableIPv6.BackColor     = [System.Drawing.ColorTranslator]::FromHtml("#f8e71c")

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Microsoft Azure Tools"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(17,466)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',15)

$ButtonADUserExport              = New-Object system.Windows.Forms.Button
$ButtonADUserExport.text         = "Save AD User - Profwiz"
$ButtonADUserExport.width        = 196
$ButtonADUserExport.height       = 30
$ButtonADUserExport.location     = New-Object System.Drawing.Point(14,493)
$ButtonADUserExport.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonADUserExport.BackColor    = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Debloat Windows"
$Button1.width                   = 177
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(498,494)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button1.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Button1.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#d0021b")

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Windows 10 Debloat "
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(490,467)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',15)

$ButtonO365Admin                 = New-Object system.Windows.Forms.Button
$ButtonO365Admin.text            = "O365 Admin Portal"
$ButtonO365Admin.width           = 195
$ButtonO365Admin.height          = 30
$ButtonO365Admin.location        = New-Object System.Drawing.Point(16,529)
$ButtonO365Admin.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonAzurePortal               = New-Object system.Windows.Forms.Button
$ButtonAzurePortal.text          = "Azure Poral"
$ButtonAzurePortal.width         = 197
$ButtonAzurePortal.height        = 30
$ButtonAzurePortal.location      = New-Object System.Drawing.Point(15,563)
$ButtonAzurePortal.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonEndpointPortal            = New-Object system.Windows.Forms.Button
$ButtonEndpointPortal.text       = "Intune Endpoint Portal"
$ButtonEndpointPortal.width      = 198
$ButtonEndpointPortal.height     = 30
$ButtonEndpointPortal.location   = New-Object System.Drawing.Point(15,597)
$ButtonEndpointPortal.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonExhangePortal             = New-Object system.Windows.Forms.Button
$ButtonExhangePortal.text        = "Exchange Portal"
$ButtonExhangePortal.width       = 200
$ButtonExhangePortal.height      = 30
$ButtonExhangePortal.location    = New-Object System.Drawing.Point(16,631)
$ButtonExhangePortal.Font        = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonContinuousWindowsUpdate   = New-Object system.Windows.Forms.Button
$ButtonContinuousWindowsUpdate.text  = "Continuous WIndows Update"
$ButtonContinuousWindowsUpdate.width  = 192
$ButtonContinuousWindowsUpdate.height  = 30
$ButtonContinuousWindowsUpdate.location  = New-Object System.Drawing.Point(248,494)
$ButtonContinuousWindowsUpdate.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonMalwarebyte               = New-Object system.Windows.Forms.Button
$ButtonMalwarebyte.text          = "Malwarebytes OneView"
$ButtonMalwarebyte.width         = 172
$ButtonMalwarebyte.height        = 30
$ButtonMalwarebyte.location      = New-Object System.Drawing.Point(248,534)
$ButtonMalwarebyte.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonStopOneDrive              = New-Object system.Windows.Forms.Button
$ButtonStopOneDrive.text         = "Shutdown OneDrive"
$ButtonStopOneDrive.width        = 148
$ButtonStopOneDrive.height       = 30
$ButtonStopOneDrive.location     = New-Object System.Drawing.Point(16,711)
$ButtonStopOneDrive.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonStopOneDrive.ForeColor    = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$ButtonStopOneDrive.BackColor    = [System.Drawing.ColorTranslator]::FromHtml("#d0021b")

$ButtonStartOneDrive             = New-Object system.Windows.Forms.Button
$ButtonStartOneDrive.text        = "Start OneDrive"
$ButtonStartOneDrive.width       = 148
$ButtonStartOneDrive.height      = 30
$ButtonStartOneDrive.location    = New-Object System.Drawing.Point(16,751)
$ButtonStartOneDrive.Font        = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonStartOneDrive.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$ButtonStartOneDrive.BackColor   = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")

$Form.controls.AddRange(@($buttonWinUpdate,$buttonWinUpgrade,$buttonCreateTempFldr,$buttonDownSyncro,$buttonDownloadDellSupportAssist,$buttonInstallO365,$buttonIntuneAutoPilot,$buttonBlackViper,$ButtonExecute,$ScriptList,$Label1,$ButtonDownloadWindows,$ButtonWinKits,$ButtonWinDevSamples,$ButtonDSIMRestorHealth,$ButtonDSMCheckHealth,$ButtonDSIMScanHealth,$ButtonDisableIPv6,$Label2,$ButtonADUserExport,$Button1,$Label3,$ButtonO365Admin,$ButtonAzurePortal,$ButtonEndpointPortal,$ButtonExhangePortal,$ButtonContinuousWindowsUpdate,$ButtonMalwarebyte,$ButtonStopOneDrive,$ButtonStartOneDrive))

$buttonWinUpdate.Add_Click({ WinUpdate })
$buttonWinUpgrade.Add_Click({ WinUpgrade })
$buttonCreateTempFldr.Add_Click({ CreateTempFolder })
$buttonDownSyncro.Add_Click({ SyncroMSP })
$buttonDownloadDellSupportAssist.Add_Click({ DellSupportAssist })
$buttonInstallO365.Add_Click({ InstallO365 })
$buttonIntuneAutoPilot.Add_Click({ AutoPilotHWID })
$buttonBlackViper.Add_Click({ BlackViper $this $_ })
$Form.Add_Load({ Initialize })
$ButtonExecute.Add_Click({ LaunchScript })
$ScriptList.Add_SelectedIndexChanged({ get-selectedScript })
$Form.Add_Activated({ Hide-Powershell })
$ButtonDSIMRestorHealth.Add_Click({ dsimRestoreHealth })
$ButtonDSMCheckHealth.Add_Click({ dsimCheckHealth })
$ButtonDSIMScanHealth.Add_Click({ dsimScanHealth })
$ButtonDisableIPv6.Add_Click({ DisableIPv6 })
$ButtonADUserExport.Add_Click({ SaveADUser })
$Button1.Add_Click({ debloatWin10 })
$ButtonContinuousWindowsUpdate.Add_Click({ ContinuousUpdate })
$ButtonO365Admin.Add_Click({ O365AdminPortal })
$ButtonAzurePortal.Add_Click({ AzureAdminPortal })
$ButtonEndpointPortal.Add_Click({ IntuneAdminPortal })
$ButtonExhangePortal.Add_Click({ ExchangeAdminPortal })
$ButtonMalwarebyte.Add_Click({ MalwarebytesOneView })
$ButtonStopOneDrive.Add_Click({ shutdownOneDrive })
$ButtonStartOneDrive.Add_Click({ startOneDrive })

#region Logic 
function startOneDrive { 
    Groove.exe
}
function shutdownOneDrive { 
    Groove.exe /shutdown
}
function MalwarebytesOneView { 
    
    Start-Process "https://oneview.malwarebytes.com/sites"
    
}
function ExchangeAdminPortal {
    
    Start-Process "https://admin.exchange.microsoft.com/#/homepage"
}
function IntuneAdminPortal {
    
    Start-Process "https://endpoint.microsoft.com/?ref=AdminCenter#home"
    
}
function AzureAdminPortal {
    
    Start-Process "https://portal.azure.com/#home"
    
}
function O365AdminPortal { 
    
    Start-Process "https://www.office.com/?auth=2"
}

function debloatWin10 {

    iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/JJ8R4'))

    }

function DisableIPv6 {
    Get-NetAdapter | foreach { Disable-NetAdapterBinding -InterfaceAlias $_.Name -ComponentID ms_tcpip6 }
    
}
function dsimScanHealth {
    DISM /Online /Cleanup-Image /ScanHealth
    
}
function dsimCheckHealth {
    DISM /Online /Cleanup-Image /CheckHealth
    
}
function dsimRestoreHealth {
    DISM.exe /Online /Cleanup-image /Restorehealth
}

function Hide-Powershell {
    
    Add-Type -Name Window -Namespace Console -MemberDefinition '
    [DllImport("Kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
    '
    $consolePtr = [Console.Window]::GetConsoleWindow()
    [Console.Window]::ShowWindow($consolePtr, 0)
}

function Initialize { 
    
    #Path of current folder, filtering all ps1 scripts
    $path = $PSScriptRoot + "\*.ps1"
    
    #Get list of names of all ps1 scripts into a variable
    $scripts = Get-ChildItem $path  | select -exp Name
    
    #Assign the list of scripts as the data source of listbox
    $ScriptList.DataSource = $scripts 
    
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Confirm:$False
    
}

function get-selectedScript {
    #Get The name of selected script
    $scriptName = $ScriptList.SelectedItem.ToString()
    
    #path of selected script
    $path = $PSScriptRoot + "\" + $scriptName
    
    return $path
}

function LaunchScript {
    $path = get-selectedScript
  
    #Execute selected script
    Invoke-Expression -Command $path
    
}

function BlackViper ($sender,$event) { 
$PSScriptRoot 
& "$PSScriptRoot\BlackViper.bat"

}

function AutoPilotHWID {
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    md c:\HWID -erroraction 'silentlycontinue'
    Set-Location c:\HWID
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Confirm:$False
    Install-Script -Name Get-WindowsAutoPilotInfo -Confirm:$False
    Get-WindowsAutoPilotInfo.ps1 -OutputFile AutoPilotHWID.csv
    $ComputerName = [System.Net.Dns]::GetHostName()
    Send-MailMessage -To 'jonathan.wood@kljwtech.dev' -From 'it.support@hccpkansas.com' -Subject “AutoPilot Hash $ComputerName” -Body “This e-mail contains the AutoPilot Hash data for $FromEmail” -Attachments "c:\HWID\AutoPilotHWID.csv" -Priority High -DeliveryNotificationOption OnSuccess
    
}
function InstallO365 { }

function DellSupportAssist { }

function SyncroMSP { 
    $directoryPath = 'C:\temp\SyncroMSP'
    if(!(Test-Path -path $directoryPath))  
    {  
    New-Item -ItemType directory -Path $directoryPath  
    }
    else 
    { 
    Write-Host "The given folder path already exists"; 
    }
    $Url = 'https://rmm.syncromsp.com/dl/rs/MTk3NDM5OTEtMTYwNjA5MzMyOS01MzE1My02ODQwMg=='
    $DownloadDir = 'C:\temp\SyncroMSP'
    $SyncroBinary = "$($DownloadDir)\SyncroSetup-remote_support-68402.exe"
    $SyncroArguments = '--console --allow-force-reboot'
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($Url, $SyncroBinary)
    Start-Process -FilePath $SyncroBinary -ArgumentList $SyncroArguments
    #
    
}

function CreateTempFolder { 
    $directoryPath = 'C:\temp\downloads'
        if(!(Test-Path -path $directoryPath))  
    {  
        New-Item -ItemType directory -Path $directoryPath  
    }
        else 
    { 
    Write-Host "The given folder path already exists"; 
    }
}
function WinUpgrade {
    $directoryPath = 'C:\temp\WindowsUpdate'
    if(!(Test-Path -path $directoryPath))  
    {  
    New-Item -ItemType directory -Path $directoryPath  
    }
    else 
    { 
    Write-Host "The given folder path already exists"; 
    }
    $Url = 'https://go.microsoft.com/fwlink/?LinkID=799445'
    $DownloadDir = 'C:\temp\WindowsUpdate'
    $UpdaterBinary = "$($DownloadDir)\Win10Upgrade.exe"
    $UpdaterArguments = '/quietinstall /skipeula /auto upgrade'
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($Url, $UpdaterBinary)
    Start-Process -FilePath $UpdaterBinary -ArgumentList $UpdaterArguments
    #
}


function WinUpdate { 
    $parameters = @{
      Name = "PSGallery"
      SourceLocation = "https://www.powershellgallery.com/api/v2"
      InstallationPolicy = 'Trusted'
    }
    Register-PSRepository @parameters
    Register-PSRepository -Default 
    Get-PSRepository
    #
    Install-Module -Name PSWindowsUpdate
    #
    Import-Module -Name PSWindowsUpdate
    #
    Get-Command -Module PSWindowsUpdate 
    #
    Install-WindowsUpdate -AcceptAll -Install -Confirm:$False
    #
}



#Write your logic code here

#endregion

[void]$Form.ShowDialog()