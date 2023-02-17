<# 
.NAME
    Tech Multi-Tool
.SYNOPSIS
    Little tool to do a few things!
.DESCRIPTION
    Created this tool for some common task I run everyday! 
Things it does
- Connect to user PC via Dameware
- Connect to user PC via RDP
- List and remove printers from user computer
- See all locked AD accounts
- Unlock AD account
- Open computer management of a remote computer
- Ping
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1073,982)
$Form.text                       = "Tech-MultiTool"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#8b8b8b")

$ButtonComputerMgm               = New-Object system.Windows.Forms.Button
$ButtonComputerMgm.text          = "Computer Management"
$ButtonComputerMgm.width         = 172
$ButtonComputerMgm.height        = 30
$ButtonComputerMgm.location      = New-Object System.Drawing.Point(15,133)
$ButtonComputerMgm.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonComputerMgm.BackColor     = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$LabelComputerName               = New-Object system.Windows.Forms.Label
$LabelComputerName.text          = "Computer Name"
$LabelComputerName.AutoSize      = $true
$LabelComputerName.width         = 25
$LabelComputerName.height        = 10
$LabelComputerName.location      = New-Object System.Drawing.Point(9,8)
$LabelComputerName.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$LabelComputerName.ForeColor     = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$TextBoxComputerName             = New-Object system.Windows.Forms.TextBox
$TextBoxComputerName.multiline   = $true
$TextBoxComputerName.text        = "$(hostname)"
$TextBoxComputerName.width       = 209
$TextBoxComputerName.height      = 30
$TextBoxComputerName.location    = New-Object System.Drawing.Point(8,29)
$TextBoxComputerName.Font        = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$TextBoxComputerName.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")
$TextBoxComputerName.BackColor   = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$OutputBox                       = New-Object system.Windows.Forms.TextBox
$OutputBox.multiline             = $true
$OutputBox.width                 = 808
$OutputBox.height                = 561
$OutputBox.location              = New-Object System.Drawing.Point(9,297)
$OutputBox.Font                  = New-Object System.Drawing.Font('Lucida Console',10)
$OutputBox.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")
$OutputBox.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$TextBoxLANIP                    = New-Object system.Windows.Forms.TextBox
$TextBoxLANIP.multiline          = $true
$TextBoxLANIP.text               = "$(Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $(Get-NetConnectionProfile | Select-Object -ExpandProperty InterfaceIndex) | Select-Object -ExpandProperty IPAddress)"
$TextBoxLANIP.width              = 116
$TextBoxLANIP.height             = 88
$TextBoxLANIP.location           = New-Object System.Drawing.Point(420,32)
$TextBoxLANIP.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$TextBoxLANIP.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")
$TextBoxLANIP.BackColor          = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$LabelLANIP                      = New-Object system.Windows.Forms.Label
$LabelLANIP.text                 = "LAN IP"
$LabelLANIP.AutoSize             = $true
$LabelLANIP.width                = 34
$LabelLANIP.height               = 10
$LabelLANIP.location             = New-Object System.Drawing.Point(420,9)
$LabelLANIP.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ButtonNetworkMgm                = New-Object system.Windows.Forms.Button
$ButtonNetworkMgm.text           = "Network Management"
$ButtonNetworkMgm.width          = 172
$ButtonNetworkMgm.height         = 30
$ButtonNetworkMgm.location       = New-Object System.Drawing.Point(15,168)
$ButtonNetworkMgm.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonNetworkMgm.BackColor      = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$ButtonDiskMgm                   = New-Object system.Windows.Forms.Button
$ButtonDiskMgm.text              = "Disk Management"
$ButtonDiskMgm.width             = 172
$ButtonDiskMgm.height            = 30
$ButtonDiskMgm.location          = New-Object System.Drawing.Point(15,202)
$ButtonDiskMgm.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonDiskMgm.BackColor         = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$ButtonComputerProperties        = New-Object system.Windows.Forms.Button
$ButtonComputerProperties.text   = "Computer Properties"
$ButtonComputerProperties.width  = 176
$ButtonComputerProperties.height  = 30
$ButtonComputerProperties.location  = New-Object System.Drawing.Point(192,133)
$ButtonComputerProperties.Font   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonComputerProperties.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$LabelWANIP                      = New-Object system.Windows.Forms.Label
$LabelWANIP.text                 = "WAN IP"
$LabelWANIP.AutoSize             = $true
$LabelWANIP.width                = 25
$LabelWANIP.height               = 10
$LabelWANIP.location             = New-Object System.Drawing.Point(569,9)
$LabelWANIP.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$TextBoxWANIP                    = New-Object system.Windows.Forms.TextBox
$TextBoxWANIP.multiline          = $true
$TextBoxWANIP.text               = "$(Invoke-WebRequest ifconfig.me/ip)"
$TextBoxWANIP.width              = 154
$TextBoxWANIP.height             = 30
$TextBoxWANIP.location           = New-Object System.Drawing.Point(569,32)
$TextBoxWANIP.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$TextBoxWANIP.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")
$TextBoxWANIP.BackColor          = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 185
$Panel1.width                    = 236
$Panel1.location                 = New-Object System.Drawing.Point(823,246)
$Panel1.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Windows Initial Config"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(823,217)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ButtonInstalPSModules           = New-Object system.Windows.Forms.Button
$ButtonInstalPSModules.text      = "Install PS Modules"
$ButtonInstalPSModules.width     = 225
$ButtonInstalPSModules.height    = 30
$ButtonInstalPSModules.location  = New-Object System.Drawing.Point(5,10)
$ButtonInstalPSModules.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 189
$Panel2.width                    = 236
$Panel2.location                 = New-Object System.Drawing.Point(820,498)
$Panel2.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#f8e71c")

$LabelInstallSoftware            = New-Object system.Windows.Forms.Label
$LabelInstallSoftware.text       = "Install Common Apps"
$LabelInstallSoftware.AutoSize   = $true
$LabelInstallSoftware.width      = 25
$LabelInstallSoftware.height     = 10
$LabelInstallSoftware.location   = New-Object System.Drawing.Point(823,474)
$LabelInstallSoftware.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 3
$Panel3.width                    = 1070
$Panel3.location                 = New-Object System.Drawing.Point(2,128)
$Panel3.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#d0021b")

$ButtonWiFiProfiles              = New-Object system.Windows.Forms.Button
$ButtonWiFiProfiles.text         = "Import WiFi Profiles"
$ButtonWiFiProfiles.width        = 186
$ButtonWiFiProfiles.height       = 30
$ButtonWiFiProfiles.location     = New-Object System.Drawing.Point(374,133)
$ButtonWiFiProfiles.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonWiFiProfiles.BackColor    = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")

$ButtonExportWiFiProfiles        = New-Object system.Windows.Forms.Button
$ButtonExportWiFiProfiles.text   = "Export WiFi Profiles"
$ButtonExportWiFiProfiles.width  = 186
$ButtonExportWiFiProfiles.height  = 30
$ButtonExportWiFiProfiles.location  = New-Object System.Drawing.Point(374,168)
$ButtonExportWiFiProfiles.Font   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonExportWiFiProfiles.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")

$ButtonVSCode                    = New-Object system.Windows.Forms.Button
$ButtonVSCode.text               = "VS Code"
$ButtonVSCode.width              = 225
$ButtonVSCode.height             = 30
$ButtonVSCode.location           = New-Object System.Drawing.Point(5,46)
$ButtonVSCode.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonOffice365Icons            = New-Object system.Windows.Forms.Button
$ButtonOffice365Icons.text       = "Office365 Desktop Icons"
$ButtonOffice365Icons.width      = 225
$ButtonOffice365Icons.height     = 30
$ButtonOffice365Icons.location   = New-Object System.Drawing.Point(4,111)
$ButtonOffice365Icons.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Windows Version"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(746,9)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Windows Build"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(746,67)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $true
$TextBox1.text                   = "$(Get-ComputerInfo | Select-Object -ExpandProperty WindowsProductName)"
$TextBox1.width                  = 197
$TextBox1.height                 = 30
$TextBox1.location               = New-Object System.Drawing.Point(740,32)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$TextBox1.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")
$TextBox1.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $true
$TextBox2.text                   = "$(GetWinVer.output)"
$TextBox2.width                  = 195
$TextBox2.height                 = 30
$TextBox2.location               = New-Object System.Drawing.Point(740,91)
$TextBox2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$TextBox2.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")
$TextBox2.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$ButtonLocalUserManagement       = New-Object system.Windows.Forms.Button
$ButtonLocalUserManagement.text  = "User Management"
$ButtonLocalUserManagement.width  = 176
$ButtonLocalUserManagement.height  = 30
$ButtonLocalUserManagement.location  = New-Object System.Drawing.Point(192,168)
$ButtonLocalUserManagement.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonLocalUserManagement.BackColor  = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$LabelInstallAdminTools          = New-Object system.Windows.Forms.Label
$LabelInstallAdminTools.text     = "Install Admin Tools"
$LabelInstallAdminTools.AutoSize  = $true
$LabelInstallAdminTools.width    = 25
$LabelInstallAdminTools.height   = 10
$LabelInstallAdminTools.location  = New-Object System.Drawing.Point(823,716)
$LabelInstallAdminTools.Font     = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Panel4                          = New-Object system.Windows.Forms.Panel
$Panel4.height                   = 121
$Panel4.width                    = 236
$Panel4.location                 = New-Object System.Drawing.Point(820,740)
$Panel4.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#9013fe")

$ButtonInstallScriptLang         = New-Object system.Windows.Forms.Button
$ButtonInstallScriptLang.text    = "Install Script Languages"
$ButtonInstallScriptLang.width   = 225
$ButtonInstallScriptLang.height  = 30
$ButtonInstallScriptLang.location  = New-Object System.Drawing.Point(3,6)
$ButtonInstallScriptLang.Font    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonInstallScriptLang.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$ButtonInstallAdminTools         = New-Object system.Windows.Forms.Button
$ButtonInstallAdminTools.text    = "Install Admin Tools"
$ButtonInstallAdminTools.width   = 225
$ButtonInstallAdminTools.height  = 30
$ButtonInstallAdminTools.location  = New-Object System.Drawing.Point(3,42)
$ButtonInstallAdminTools.Font    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonInstallAdminTools.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$ButtonInstallPackageManagers    = New-Object system.Windows.Forms.Button
$ButtonInstallPackageManagers.text  = "Install Package Managers"
$ButtonInstallPackageManagers.width  = 225
$ButtonInstallPackageManagers.height  = 30
$ButtonInstallPackageManagers.location  = New-Object System.Drawing.Point(3,5)
$ButtonInstallPackageManagers.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonInstalChocolatey          = New-Object system.Windows.Forms.Button
$ButtonInstalChocolatey.text     = "Chocolatey"
$ButtonInstalChocolatey.width    = 225
$ButtonInstalChocolatey.height   = 30
$ButtonInstalChocolatey.location  = New-Object System.Drawing.Point(5,82)
$ButtonInstalChocolatey.Font     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonInstallPowerShell7        = New-Object system.Windows.Forms.Button
$ButtonInstallPowerShell7.text   = "PowerShell 7"
$ButtonInstallPowerShell7.width  = 225
$ButtonInstallPowerShell7.height  = 30
$ButtonInstallPowerShell7.location  = New-Object System.Drawing.Point(5,117)
$ButtonInstallPowerShell7.Font   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonInstallDellSupportTools   = New-Object system.Windows.Forms.Button
$ButtonInstallDellSupportTools.text  = "Install Dell Support Tools"
$ButtonInstallDellSupportTools.width  = 225
$ButtonInstallDellSupportTools.height  = 30
$ButtonInstallDellSupportTools.location  = New-Object System.Drawing.Point(3,40)
$ButtonInstallDellSupportTools.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonInstallO365               = New-Object system.Windows.Forms.Button
$ButtonInstallO365.text          = "Install Office 365 Business"
$ButtonInstallO365.width         = 225
$ButtonInstallO365.height        = 30
$ButtonInstallO365.location      = New-Object System.Drawing.Point(3,76)
$ButtonInstallO365.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ButtonMacriumReflect            = New-Object system.Windows.Forms.Button
$ButtonMacriumReflect.text       = "Install Macrium Reflect"
$ButtonMacriumReflect.width      = 225
$ButtonMacriumReflect.height     = 30
$ButtonMacriumReflect.location   = New-Object System.Drawing.Point(3,77)
$ButtonMacriumReflect.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonMacriumReflect.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$ButtonAddPCtoIntun              = New-Object system.Windows.Forms.Button
$ButtonAddPCtoIntun.text         = "Import PC To Intune"
$ButtonAddPCtoIntun.width        = 225
$ButtonAddPCtoIntun.height       = 30
$ButtonAddPCtoIntun.location     = New-Object System.Drawing.Point(4,146)
$ButtonAddPCtoIntun.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$NewNameTextBox                  = New-Object system.Windows.Forms.TextBox
$NewNameTextBox.multiline        = $true
$NewNameTextBox.width            = 209
$NewNameTextBox.height           = 30
$NewNameTextBox.location         = New-Object System.Drawing.Point(8,91)
$NewNameTextBox.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$NewNameTextBox.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#7ed321")
$NewNameTextBox.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$LabelNewPCName                  = New-Object system.Windows.Forms.Label
$LabelNewPCName.text             = "New Computer Name"
$LabelNewPCName.AutoSize         = $true
$LabelNewPCName.width            = 25
$LabelNewPCName.height           = 10
$LabelNewPCName.location         = New-Object System.Drawing.Point(15,70)
$LabelNewPCName.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$LabelNewPCName.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$Panel5                          = New-Object system.Windows.Forms.Panel
$Panel5.height                   = 59
$Panel5.width                    = 192
$Panel5.location                 = New-Object System.Drawing.Point(13,895)
$Panel5.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#b8e986")

$LabelExtras                     = New-Object system.Windows.Forms.Label
$LabelExtras.text                = "Extras"
$LabelExtras.AutoSize            = $true
$LabelExtras.width               = 25
$LabelExtras.height              = 10
$LabelExtras.location            = New-Object System.Drawing.Point(19,868)
$LabelExtras.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ButtonExtra1                    = New-Object system.Windows.Forms.Button
$ButtonExtra1.text               = "Microsoft Visio Stencils"
$ButtonExtra1.width              = 179
$ButtonExtra1.height             = 30
$ButtonExtra1.location           = New-Object System.Drawing.Point(6,6)
$ButtonExtra1.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ButtonExtra1.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Start Standard Config"
$Button1.width                   = 177
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(12,252)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Button1.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$Button1.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#00ff00")

$Form.controls.AddRange(@($ButtonComputerMgm,$LabelComputerName,$TextBoxComputerName,$OutputBox,$TextBoxLANIP,$LabelLANIP,$ButtonNetworkMgm,$ButtonDiskMgm,$ButtonComputerProperties,$LabelWANIP,$TextBoxWANIP,$Panel1,$Label1,$Panel2,$LabelInstallSoftware,$Panel3,$ButtonWiFiProfiles,$ButtonExportWiFiProfiles,$Label2,$Label3,$TextBox1,$TextBox2,$ButtonLocalUserManagement,$LabelInstallAdminTools,$Panel4,$NewNameTextBox,$LabelNewPCName,$Panel5,$LabelExtras,$Button1))
$Panel2.controls.AddRange(@($ButtonInstalPSModules,$ButtonVSCode,$ButtonInstalChocolatey,$ButtonInstallPowerShell7))
$Panel1.controls.AddRange(@($ButtonOffice365Icons,$ButtonInstallPackageManagers,$ButtonInstallDellSupportTools,$ButtonInstallO365,$ButtonAddPCtoIntun))
$Panel4.controls.AddRange(@($ButtonInstallScriptLang,$ButtonInstallAdminTools,$ButtonMacriumReflect))
$Panel5.controls.AddRange(@($ButtonExtra1))

$Form.Add_Load({ OnLoad })
$OutputBox.Add_DoubleClick({ ClearLogDC })
$ButtonComputerMgm.Add_Click({ ComputerManagment })
$ButtonInstalPSModules.Add_Click({ InstallPSModules })
$ButtonNetworkMgm.Add_Click({ NetworkManagement })
$ButtonDiskMgm.Add_Click({ DiskManagement })
$ButtonComputerProperties.Add_Click({ ComputerProperties })
$ButtonVSCode.Add_Click({ InstallVSCode })
$ButtonLocalUserManagement.Add_Click({ LocalUserManagemen })
$ButtonInstalChocolatey.Add_Click({ InstallChocolatey })
$ButtonInstallPowerShell7.Add_Click({ InstallPowershell7 })
$ButtonInstallScriptLang.Add_Click({ InstallScriptLang })
$ButtonInstallAdminTools.Add_Click({ InstallAdminTools })
$ButtonInstallPackageManagers.Add_Click({ InstallPackageManagers })
$ButtonInstallDellSupportTools.Add_Click({ InstallDellSupportTools })
$ButtonInstallO365.Add_Click({ InstallO365 })
$ButtonMacriumReflect.Add_Click({ InstallMacriumReflect })
$ButtonAddPCtoIntun.Add_Click({ AddPCtoIntun })
$ButtonExtra1.Add_Click({ InstallMSStencils })

#region Logic 
function DefaultAppAssociation { }
function InstallMSStencils { }
function RenamePC { }
function SetWallPaper { }
function AddPCtoIntun { }
function InstallMacriumReflect { }
function InstallO365 { }
function InstallDellSupportTools { }
function InstallPackageManagers { }
function InstallAdminTools { }
function InstallScriptLang { }
function InstallVSCode { }
function InstallPowershell7 { }
function InstallPowershell7 { }
function InstallChocolatey { }
function LocalUserManagemen { }
function ExportStartMenuLayout { }
function ImportStartMenuLayout { }
function ExportStartMenuLayout { }
function CleanWindows { }
function InstallStandardApps { }
function ComputerProperties { }
function DiskManagement { }
function NetworkManagement { }
#Check to make sure powershell is ran as admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

# .Net methods for hiding/showing the console in the background
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
function DisableIPv6 {
    Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6
}

function ComputerManagment {
    $CN = $ComputerName.text
    compmgmt.msc /computer:$CN 
    
}

function RunInvokeCommand {
    $CN = $ComputerName.text | out-string
    $RunCommand = $Command.text | out-string
    $Log.AppendText("`r`nRunning Command...")
    $mycommand = Invoke-Command -ComputerName $CN -ScriptBlock{$RunCommand}
    $Log.AppendText("`r`n$mycommand")
    $Log.AppendText("`r`nFinished")
    
}

function Show-Console {
    $consolePtr = [Console.Window]::GetConsoleWindow()

    # Hide = 0,
    # ShowNormal = 1,
    # ShowMinimized = 2,
    # ShowMaximized = 3,
    # Maximize = 3,
    # ShowNormalNoActivate = 4,
    # Show = 5,
    # Minimize = 6,
    # ShowMinNoActivate = 7,
    # ShowNoActivate = 8,
    # Restore = 9,
    # ShowDefault = 10,
    # ForceMinimized = 11

    [Console.Window]::ShowWindow($consolePtr, 4)
}

function Hide-Console {
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}

function Ping { 
    $PingCommand = ""
    #$Log.AppendText("`r`nCommand Running...")
    $CN = $ComputerName.text
    $PingCommand = Test-Connection -ComputerName $CN -count 1
    if($PingCommand -ne $null){
		$stuff = Test-Connection -ComputerName $CN -count 1 | select Address,Ipv4Address | out-string
        $Log.AppendText($stuff)
    }
    else{
        $Log.AppendText("`r`n$CN is Offline or does not exist")
    }
    
}
#endregion

#region Main
function Initialize { 
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Confirm:$False
}

#endregion

#region Debloat
function DebloatWIn10 { 
    #no errors throughout
$ErrorActionPreference = 'silentlycontinue'

$DebloatFolder = "C:\Temp\Windows10Debloater"
If (Test-Path $DebloatFolder) {
    Write-Output "$DebloatFolder exists. Skipping."
}
Else {
    Write-Output "The folder '$DebloatFolder' doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "$DebloatFolder" -ItemType Directory
    Write-Output "The folder $DebloatFolder was successfully created."
}

Start-Transcript -OutputDirectory "$DebloatFolder"

Add-Type -AssemblyName PresentationCore, PresentationFramework

Function DebloatAll {
    #Removes AppxPackages
    #Credit to /u/GavinEke for a modified version of my whitelist code
    $WhitelistedApps = 'Microsoft.ScreenSketch|Microsoft.Paint3D|Microsoft.WindowsCalculator|Microsoft.WindowsStore|Microsoft.Windows.Photos|CanonicalGroupLimited.UbuntuonWindows|`
    Microsoft.XboxGameCallableUI|Microsoft.XboxGamingOverlay|Microsoft.Xbox.TCUI|Microsoft.XboxGamingOverlay|Microsoft.XboxIdentityProvider|Microsoft.MicrosoftStickyNotes|Microsoft.MSPaint|Microsoft.WindowsCamera|.NET|Framework|`
    Microsoft.HEIFImageExtension|Microsoft.ScreenSketch|Microsoft.StorePurchaseApp|Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.DesktopAppInstaller|WindSynthBerry|MIDIBerry|Slack'
    
    #NonRemovable Apps that where getting attempted and the system would reject the uninstall, speeds up debloat and prevents 'initalizing' overlay when removing apps
    $NonRemovable = '1527c705-839a-4832-9118-54d4Bd6a0c89|c5e2524a-ea46-4f67-841f-6a9465d9d515|E2A4F912-2574-4A75-9BB0-0D023378592B|F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE|InputApp|Microsoft.AAD.BrokerPlugin|Microsoft.AccountsControl|`
    Microsoft.BioEnrollment|Microsoft.CredDialogHost|Microsoft.ECApp|Microsoft.LockApp|Microsoft.MicrosoftEdgeDevToolsClient|Microsoft.MicrosoftEdge|Microsoft.PPIProjection|Microsoft.Win32WebViewHost|Microsoft.Windows.Apprep.ChxApp|`
    Microsoft.Windows.AssignedAccessLockApp|Microsoft.Windows.CapturePicker|Microsoft.Windows.CloudExperienceHost|Microsoft.Windows.ContentDeliveryManager|Microsoft.Windows.Cortana|Microsoft.Windows.NarratorQuickStart|`
    Microsoft.Windows.ParentalControls|Microsoft.Windows.PeopleExperienceHost|Microsoft.Windows.PinningConfirmationDialog|Microsoft.Windows.SecHealthUI|Microsoft.Windows.SecureAssessmentBrowser|Microsoft.Windows.ShellExperienceHost|`
    Microsoft.Windows.XGpuEjectDialog|Microsoft.XboxGameCallableUI|Windows.CBSPreview|windows.immersivecontrolpanel|Windows.PrintDialog|Microsoft.VCLibs.140.00|Microsoft.Services.Store.Engagement|Microsoft.UI.Xaml.2.0|*Nvidia*'
    
    Get-AppxPackage -AllUsers | Where-Object {$_.Name -NotMatch $WhitelistedApps -and $_.Name -NotMatch $NonRemovable} | Remove-AppxPackage
    Get-AppxPackage | Where-Object {$_.Name -NotMatch $WhitelistedApps -and $_.Name -NotMatch $NonRemovable} | Remove-AppxPackage
    Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -NotMatch $WhitelistedApps -and $_.PackageName -NotMatch $NonRemovable} | Remove-AppxProvisionedPackage -Online
}

Function DebloatBlacklist {

    $Bloatware = @(

        #Unnecessary Windows 10 AppX Apps
        "Microsoft.BingNews"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.Messaging"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.News"
        "Microsoft.Office.Lens"
        "Microsoft.Office.OneNote"
        "Microsoft.Office.Sway"
        "Microsoft.OneConnect"
        "Microsoft.People"
        "Microsoft.Print3D"
        "Microsoft.RemoteDesktop"
        "Microsoft.SkypeApp"
        "Microsoft.StorePurchaseApp"
        "Microsoft.Office.Todo.List"
        "Microsoft.Whiteboard"
        "Microsoft.WindowsAlarms"
        "Microsoft.WindowsCamera"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.Xbox.TCUI"
        "Microsoft.XboxApp"
        "Microsoft.XboxGameOverlay"
        "Microsoft.XboxIdentityProvider"
        "Microsoft.XboxSpeechToTextOverlay"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"

        #Sponsored Windows 10 AppX Apps
        #Add sponsored/featured apps to remove in the "*AppName*" format
        "*EclipseManager*"
        "*ActiproSoftwareLLC*"
        "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
        "*Duolingo-LearnLanguagesforFree*"
        "*PandoraMediaInc*"
        "*CandyCrush*"
        "*BubbleWitch3Saga*"
        "*Wunderlist*"
        "*Flipboard*"
        "*Twitter*"
        "*Facebook*"
        "*Spotify*"
        "*Minecraft*"
        "*Royal Revolt*"
        "*Sway*"
        "*Speed Test*"
        "*Dolby*"
             
        #Optional: Typically not removed but you can if you need to for some reason
        "*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
        "*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
        "*Microsoft.BingWeather*"
        #"*Microsoft.MSPaint*"
        #"*Microsoft.MicrosoftStickyNotes*"
        "*Microsoft.Windows.Photos*"
        #"*Microsoft.WindowsCalculator*"
        #"*Microsoft.WindowsStore*"
    )
    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat| Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
        Write-Output "Trying to remove $Bloat."
    }
}

Function Remove-Keys {
        
    #These are the registry keys that it will delete.
            
    $Keys = @(
            
        #Remove Background Tasks
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
        #Windows File
        "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            
        #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
        #Scheduled Tasks to delete
        "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            
        #Windows Protocol Keys
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
               
        #Windows Share Target
        "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    )
        
    #This writes the output of each key it is removing and also removes the keys listed above.
    ForEach ($Key in $Keys) {
        Write-Output "Removing $Key from registry"
        Remove-Item $Key -Recurse
    }
}
            
Function Protect-Privacy {
            
    #Disables Windows Feedback Experience
    Write-Output "Disabling Windows Feedback Experience program"
    $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising Enabled -Value 0 
    }
            
    #Stops Cortana from being used as part of your Windows Search Function
    Write-Output "Stopping Cortana from being used as part of your Windows Search Function"
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search AllowCortana -Value 0 
    }

    #Disables Web Search in Start Menu
    Write-Output "Disabling Bing Search in Start Menu"
    $WebSearch = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0 
    If (!(Test-Path $WebSearch)) {
        New-Item $WebSearch
    }
    Set-ItemProperty $WebSearch DisableWebSearch -Value 1 
            
    #Stops the Windows Feedback Experience from sending anonymous data
    Write-Output "Stopping the Windows Feedback Experience program"
    $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
    If (!(Test-Path $Period)) { 
        New-Item $Period
    }
    Set-ItemProperty $Period PeriodInNanoSeconds -Value 0 

    #Prevents bloatware applications from returning and removes Start Menu suggestions               
    Write-Output "Adding Registry key to prevent bloatware apps from returning"
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    $registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    If (!(Test-Path $registryPath)) { 
        New-Item $registryPath
    }
    Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 

    If (!(Test-Path $registryOEM)) {
        New-Item $registryOEM
    }
    Set-ItemProperty $registryOEM  ContentDeliveryAllowed -Value 0 
    Set-ItemProperty $registryOEM  OemPreInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM  PreInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM  PreInstalledAppsEverEnabled -Value 0 
    Set-ItemProperty $registryOEM  SilentInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM  SystemPaneSuggestionsEnabled -Value 0          
    
    #Preping mixed Reality Portal for removal    
    Write-Output "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
    $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
    If (Test-Path $Holo) {
        Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 
    }

    #Disables Wi-fi Sense
    Write-Output "Disabling Wi-Fi Sense"
    $WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
    $WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
    $WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
    If (!(Test-Path $WifiSense1)) {
        New-Item $WifiSense1
    }
    Set-ItemProperty $WifiSense1  Value -Value 0 
    If (!(Test-Path $WifiSense2)) {
        New-Item $WifiSense2
    }
    Set-ItemProperty $WifiSense2  Value -Value 0 
    Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 
        
    #Disables live tiles
    Write-Output "Disabling live tiles"
    $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"    
    If (!(Test-Path $Live)) {      
        New-Item $Live
    }
    Set-ItemProperty $Live  NoTileApplicationNotification -Value 1 
        
    #Turns off Data Collection via the AllowTelemtry key by changing it to 0
    Write-Output "Turning off Data Collection"
    $DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    $DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    $DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
    If (Test-Path $DataCollection1) {
        Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection2) {
        Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection3) {
        Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
    }
    
    #Disabling Location Tracking
    Write-Output "Disabling Location Tracking"
    $SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    $LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
    If (!(Test-Path $SensorState)) {
        New-Item $SensorState
    }
    Set-ItemProperty $SensorState SensorPermissionState -Value 0 
    If (!(Test-Path $LocationConfig)) {
        New-Item $LocationConfig
    }
    Set-ItemProperty $LocationConfig Status -Value 0 
        
    #Disables People icon on Taskbar
    Write-Output "Disabling People icon on Taskbar"
    $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
    If (Test-Path $People) {
        Set-ItemProperty $People -Name PeopleBand -Value 0
    }
        
    #Disables scheduled tasks that are considered unnecessary 
    Write-Output "Disabling scheduled tasks"
    Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask
    Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
    Get-ScheduledTask  DmClient | Disable-ScheduledTask
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask

    Write-Output "Stopping and disabling Diagnostics Tracking Service"
    #Disabling the Diagnostics Tracking Service
    Stop-Service "DiagTrack"
    Set-Service "DiagTrack" -StartupType Disabled

    
    Write-Output "Removing CloudStore from registry if it exists"
    $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
    If (Test-Path $CloudStore) {
        Stop-Process Explorer.exe -Force
        Remove-Item $CloudStore -Recurse -Force
        Start-Process Explorer.exe -Wait
    }
}

Function DisableCortana {
    Write-Host "Disabling Cortana"
    $Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
    $Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
    $Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
    If (!(Test-Path $Cortana1)) {
        New-Item $Cortana1
    }
    Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 0 
    If (!(Test-Path $Cortana2)) {
        New-Item $Cortana2
    }
    Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 1 
    Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 1 
    If (!(Test-Path $Cortana3)) {
        New-Item $Cortana3
    }
    Set-ItemProperty $Cortana3 HarvestContacts -Value 0
    
}

Function EnableCortana {
    Write-Host "Re-enabling Cortana"
    $Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
    $Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
    $Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
    If (!(Test-Path $Cortana1)) {
        New-Item $Cortana1
    }
    Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 1 
    If (!(Test-Path $Cortana2)) {
        New-Item $Cortana2
    }
    Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 0 
    Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 0 
    If (!(Test-Path $Cortana3)) {
        New-Item $Cortana3
    }
    Set-ItemProperty $Cortana3 HarvestContacts -Value 1 
}
        
Function Stop-EdgePDF {
    
    #Stops edge from taking over as the default .PDF viewer    
    Write-Output "Stopping Edge from taking over as the default .PDF viewer"
    $NoPDF = "HKCR:\.pdf"
    $NoProgids = "HKCR:\.pdf\OpenWithProgids"
    $NoWithList = "HKCR:\.pdf\OpenWithList" 
    If (!(Get-ItemProperty $NoPDF  NoOpenWith)) {
        New-ItemProperty $NoPDF NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoPDF  NoStaticDefaultVerb)) {
        New-ItemProperty $NoPDF  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoProgids  NoOpenWith)) {
        New-ItemProperty $NoProgids  NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoProgids  NoStaticDefaultVerb)) {
        New-ItemProperty $NoProgids  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoWithList  NoOpenWith)) {
        New-ItemProperty $NoWithList  NoOpenWith
    }        
    If (!(Get-ItemProperty $NoWithList  NoStaticDefaultVerb)) {
        New-ItemProperty $NoWithList  NoStaticDefaultVerb 
    }
            
    #Appends an underscore '_' to the Registry key for Edge
    $Edge = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
    If (Test-Path $Edge) {
        Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ 
    }
}

Function Revert-Changes {   
        
    #This function will revert the changes you made when running the Start-Debloat function.
        
    #This line reinstalls all of the bloatware that was removed
    Get-AppxPackage -AllUsers | ForEach {Add-AppxPackage -Verbose -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 
    
    #Tells Windows to enable your advertising information.    
    Write-Output "Re-enabling key to show advertisement information"
    $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising  Enabled -Value 1
    }
            
    #Enables Cortana to be used as part of your Windows Search Function
    Write-Output "Re-enabling Cortana to be used in your Windows Search"
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search  AllowCortana -Value 1 
    }
            
    #Re-enables the Windows Feedback Experience for sending anonymous data
    Write-Output "Re-enabling Windows Feedback Experience"
    $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
    If (!(Test-Path $Period)) { 
        New-Item $Period
    }
    Set-ItemProperty $Period PeriodInNanoSeconds -Value 1 
    
    #Enables bloatware applications               
    Write-Output "Adding Registry key to allow bloatware apps to return"
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    If (!(Test-Path $registryPath)) {
        New-Item $registryPath 
    }
    Set-ItemProperty $registryPath  DisableWindowsConsumerFeatures -Value 0 
        
    #Changes Mixed Reality Portal Key 'FirstRunSucceeded' to 1
    Write-Output "Setting Mixed Reality Portal value to 1"
    $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"
    If (Test-Path $Holo) {
        Set-ItemProperty $Holo  FirstRunSucceeded -Value 1 
    }
        
    #Re-enables live tiles
    Write-Output "Enabling live tiles"
    $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"
    If (!(Test-Path $Live)) {
        New-Item $Live 
    }
    Set-ItemProperty $Live  NoTileApplicationNotification -Value 0 
       
    #Re-enables data collection
    Write-Output "Re-enabling data collection"
    $DataCollection = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    If (!(Test-Path $DataCollection)) {
        New-Item $DataCollection
    }
    Set-ItemProperty $DataCollection  AllowTelemetry -Value 1
        
    #Re-enables People Icon on Taskbar
    Write-Output "Enabling People icon on Taskbar"
    $People = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"
    If (!(Test-Path $People)) {
        New-Item $People 
    }
    Set-ItemProperty $People  PeopleBand -Value 1 
    
    #Re-enables suggestions on start menu
    Write-Output "Enabling suggestions on the Start Menu"
    $Suggestions = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    If (!(Test-Path $Suggestions)) {
        New-Item $Suggestions
    }
    Set-ItemProperty $Suggestions  SystemPaneSuggestionsEnabled -Value 1 
        
    #Re-enables scheduled tasks that were disabled when running the Debloat switch
    Write-Output "Enabling scheduled tasks that were disabled"
    Get-ScheduledTask XblGameSaveTaskLogon | Enable-ScheduledTask 
    Get-ScheduledTask  XblGameSaveTask | Enable-ScheduledTask 
    Get-ScheduledTask  Consolidator | Enable-ScheduledTask 
    Get-ScheduledTask  UsbCeip | Enable-ScheduledTask 
    Get-ScheduledTask  DmClient | Enable-ScheduledTask 
    Get-ScheduledTask  DmClientOnScenarioDownload | Enable-ScheduledTask 

    Write-Output "Re-enabling and starting WAP Push Service"
    #Enable and start WAP Push Service
    Set-Service "dmwappushservice" -StartupType Automatic
    Start-Service "dmwappushservice"
    
    Write-Output "Re-enabling and starting the Diagnostics Tracking Service"
    #Enabling the Diagnostics Tracking Service
    Set-Service "DiagTrack" -StartupType Automatic
    Start-Service "DiagTrack"
    
    Write-Output "Restoring 3D Objects in the 'My Computer' submenu in explorer"
    #Restoring 3D Objects in the 'My Computer' submenu in explorer
    Restore3dObjects
}

Function CheckDMWService {

    Param([switch]$Debloat)
  
    If (Get-Service -Name dmwappushservice | Where-Object {$_.StartType -eq "Disabled"}) {
        Set-Service -Name dmwappushservice -StartupType Automatic
    }

    If (Get-Service -Name dmwappushservice | Where-Object {$_.Status -eq "Stopped"}) {
        Start-Service -Name dmwappushservice
    } 
}
    
Function Enable-EdgePDF {
    Write-Output "Setting Edge back to default"
    $NoPDF = "HKCR:\.pdf"
    $NoProgids = "HKCR:\.pdf\OpenWithProgids"
    $NoWithList = "HKCR:\.pdf\OpenWithList"
    #Sets edge back to default
    If (Get-ItemProperty $NoPDF  NoOpenWith) {
        Remove-ItemProperty $NoPDF  NoOpenWith
    } 
    If (Get-ItemProperty $NoPDF  NoStaticDefaultVerb) {
        Remove-ItemProperty $NoPDF  NoStaticDefaultVerb 
    }       
    If (Get-ItemProperty $NoProgids  NoOpenWith) {
        Remove-ItemProperty $NoProgids  NoOpenWith 
    }        
    If (Get-ItemProperty $NoProgids  NoStaticDefaultVerb) {
        Remove-ItemProperty $NoProgids  NoStaticDefaultVerb 
    }        
    If (Get-ItemProperty $NoWithList  NoOpenWith) {
        Remove-ItemProperty $NoWithList  NoOpenWith
    }    
    If (Get-ItemProperty $NoWithList  NoStaticDefaultVerb) {
        Remove-ItemProperty $NoWithList  NoStaticDefaultVerb
    }
        
    #Removes an underscore '_' from the Registry key for Edge
    $Edge2 = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
    If (Test-Path $Edge2) {
        Set-Item $Edge2 AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723
    }
}

Function FixWhitelistedApps {
    
    If (!(Get-AppxPackage -AllUsers | Select Microsoft.Paint3D, Microsoft.WindowsCalculator, Microsoft.WindowsStore, Microsoft.Windows.Photos)) {
    
        #Credit to abulgatz for these 4 lines of code
        Get-AppxPackage -allusers Microsoft.Paint3D | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
        Get-AppxPackage -allusers Microsoft.WindowsCalculator | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
        Get-AppxPackage -allusers Microsoft.WindowsStore | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
        Get-AppxPackage -allusers Microsoft.Windows.Photos | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 
    } 
}

Function UninstallOneDrive {

    Write-Host "Checking for pre-existing files and folders located in the OneDrive folders..."
    Start-Sleep 1
    If (Test-Path "$env:USERPROFILE\OneDrive\*") {
        Write-Host "Files found within the OneDrive folder! Checking to see if a folder named OneDriveBackupFiles exists."
        Start-Sleep 1
              
        If (Test-Path "$env:USERPROFILE\Desktop\OneDriveBackupFiles") {
            Write-Host "A folder named OneDriveBackupFiles already exists on your desktop. All files from your OneDrive location will be moved to that folder." 
        }
        else {
            If (!(Test-Path "$env:USERPROFILE\Desktop\OneDriveBackupFiles")) {
                Write-Host "A folder named OneDriveBackupFiles will be created and will be located on your desktop. All files from your OneDrive location will be located in that folder."
                New-item -Path "$env:USERPROFILE\Desktop" -Name "OneDriveBackupFiles"-ItemType Directory -Force
                Write-Host "Successfully created the folder 'OneDriveBackupFiles' on your desktop."
            }
        }
        Start-Sleep 1
        Move-Item -Path "$env:USERPROFILE\OneDrive\*" -Destination "$env:USERPROFILE\Desktop\OneDriveBackupFiles" -Force
        Write-Host "Successfully moved all files/folders from your OneDrive folder to the folder 'OneDriveBackupFiles' on your desktop."
        Start-Sleep 1
        Write-Host "Proceeding with the removal of OneDrive."
        Start-Sleep 1
    }
    Else {
        Write-Host "Either the OneDrive folder does not exist or there are no files to be found in the folder. Proceeding with removal of OneDrive."
        Start-Sleep 1
        Write-Host "Enabling the Group Policy 'Prevent the usage of OneDrive for File Storage'."
        $OneDriveKey = 'HKLM:Software\Policies\Microsoft\Windows\OneDrive'
        If (!(Test-Path $OneDriveKey)) {
            Mkdir $OneDriveKey
            Set-ItemProperty $OneDriveKey -Name OneDrive -Value DisableFileSyncNGSC
        }
        Set-ItemProperty $OneDriveKey -Name OneDrive -Value DisableFileSyncNGSC
    }

    Write-Host "Uninstalling OneDrive. Please wait..."
    

    New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    $ExplorerReg1 = "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    $ExplorerReg2 = "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    Stop-Process -Name "OneDrive*"
    Start-Sleep 2
    If (!(Test-Path $onedrive)) {
        $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"

        New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
        $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
        $ExplorerReg1 = "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
        $ExplorerReg2 = "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
        Stop-Process -Name "OneDrive*"
        Start-Sleep 2
        If (!(Test-Path $onedrive)) {
            $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
        }
        Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
        Start-Sleep 2
        Write-Output "Stopping explorer"
        Start-Sleep 1
        taskkill.exe /F /IM explorer.exe
        Start-Sleep 3
        Write-Output "Removing leftover files"
        Remove-Item "$env:USERPROFILE\OneDrive" -Force -Recurse
        Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
        Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
        If (Test-Path "$env:SYSTEMDRIVE\OneDriveTemp") {
            Remove-Item "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse
        }
        Write-Output "Removing OneDrive from windows explorer"
        If (!(Test-Path $ExplorerReg1)) {
            New-Item $ExplorerReg1
        }
        Set-ItemProperty $ExplorerReg1 System.IsPinnedToNameSpaceTree -Value 0 
        If (!(Test-Path $ExplorerReg2)) {
            New-Item $ExplorerReg2
        }
        Set-ItemProperty $ExplorerReg2 System.IsPinnedToNameSpaceTree -Value 0
        Write-Output "Restarting Explorer that was shut down before."
        Start-Process explorer.exe -NoNewWindow
    
        Write-Host "Enabling the Group Policy 'Prevent the usage of OneDrive for File Storage'."
        $OneDriveKey = 'HKLM:Software\Policies\Microsoft\Windows\OneDrive'
        If (!(Test-Path $OneDriveKey)) {
            Mkdir $OneDriveKey 
        }
        Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
        Start-Sleep 2
        Write-Host "Stopping explorer"
        Start-Sleep 1
        taskkill.exe /F /IM explorer.exe
        Start-Sleep 3
        Write-Host "Removing leftover files"
        If (Test-Path "$env:USERPROFILE\OneDrive") {
            Remove-Item "$env:USERPROFILE\OneDrive" -Force -Recurse
        }
        If (Test-Path "$env:LOCALAPPDATA\Microsoft\OneDrive") {
            Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
        }
        If (Test-Path "$env:PROGRAMDATA\Microsoft OneDrive") {
            Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
        }
        If (Test-Path "$env:SYSTEMDRIVE\OneDriveTemp") {
            Remove-Item "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse
        }
        Write-Host "Removing OneDrive from windows explorer"
        If (!(Test-Path $ExplorerReg1)) {
            New-Item $ExplorerReg1
        }
        Set-ItemProperty $ExplorerReg1 System.IsPinnedToNameSpaceTree -Value 0 
        If (!(Test-Path $ExplorerReg2)) {
            New-Item $ExplorerReg2
        }
        Set-ItemProperty $ExplorerReg2 System.IsPinnedToNameSpaceTree -Value 0
        Write-Host "Restarting Explorer that was shut down before."
        Start-Process explorer.exe -NoNewWindow
        Write-Host "OneDrive has been successfully uninstalled!"
        
        Remove-item env:OneDrive
    }
}

Function UnpinStart {
    # https://superuser.com/a/1442733
    #Requires -RunAsAdministrator

$START_MENU_LAYOUT = @"
<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
    <LayoutOptions StartTileGroupCellWidth="6" />
    <DefaultLayoutOverride>
        <StartLayoutCollection>
            <defaultlayout:StartLayout GroupCellWidth="6" />
        </StartLayoutCollection>
    </DefaultLayoutOverride>
</LayoutModificationTemplate>
"@

    $layoutFile="C:\Windows\StartMenuLayout.xml"

    #Delete layout file if it already exists
    If(Test-Path $layoutFile)
    {
        Remove-Item $layoutFile
    }

    #Creates the blank layout file
    $START_MENU_LAYOUT | Out-File $layoutFile -Encoding ASCII

    $regAliases = @("HKLM", "HKCU")

    #Assign the start layout and force it to apply with "LockedStartLayout" at both the machine and user level
    foreach ($regAlias in $regAliases){
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer" 
        IF(!(Test-Path -Path $keyPath)) { 
            New-Item -Path $basePath -Name "Explorer"
        }
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
        Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile
    }

    #Restart Explorer, open the start menu (necessary to load the new layout), and give it a few seconds to process
    Stop-Process -name explorer
    Start-Sleep -s 5
    $wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('^{ESCAPE}')
    Start-Sleep -s 5

    #Enable the ability to pin items again by disabling "LockedStartLayout"
    foreach ($regAlias in $regAliases){
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer" 
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0
    }

    #Restart Explorer and delete the layout file
    Stop-Process -name explorer

    # Uncomment the next line to make clean start menu default for all new users
    #Import-StartLayout -LayoutPath $layoutFile -MountPath $env:SystemDrive\

    Remove-Item $layoutFile
}

Function Remove3dObjects {
    #Removes 3D Objects from the 'My Computer' submenu in explorer
    Write-Host "Removing 3D Objects from explorer 'My Computer' submenu"
    $Objects32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    $Objects64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    If (Test-Path $Objects32) {
        Remove-Item $Objects32 -Recurse 
    }
    If (Test-Path $Objects64) {
        Remove-Item $Objects64 -Recurse 
    }
}

Function Restore3dObjects {
    #Restores 3D Objects from the 'My Computer' submenu in explorer
    Write-Host "Restoring 3D Objects from explorer 'My Computer' submenu"
    $Objects32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    $Objects64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    If (!(Test-Path $Objects32)) {
        New-Item $Objects32
    }
    If (!(Test-Path $Objects64)) {
        New-Item $Objects64
    }
}

Function DisableLastUsedFilesAndFolders {
	Write-Host = "Disable Explorer to show last used files and folders."
	Invoke-Item (start powershell ((Split-Path $MyInvocation.InvocationName) + "\Individual Scripts\Disable Last Used Files and Folders View.ps1"))
}

#Interactive prompt Debloat/Revert options
$Button = [Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [Windows.MessageBoxImage]::Error
$Warn = [Windows.MessageBoxImage]::Warning
$Ask = 'The following will allow you to either Debloat Windows 10 or to revert changes made after Debloating Windows 10.

        Select "Yes" to Debloat Windows 10

        Select "No" to Revert changes made by this script
        
        Select "Cancel" to stop the script.'

$EverythingorSpecific = "Would you like to remove everything that was preinstalled on your Windows Machine? Select Yes to remove everything, or select No to remove apps via a blacklist."
$EdgePdf = "Do you want to stop edge from taking over as the default PDF viewer?"
$EdgePdf2 = "Do you want to revert changes that disabled Edge as the default PDF viewer?"
$Reboot = "For some of the changes to properly take effect it is recommended to reboot your machine. Would you like to restart?"
$OneDriveDelete = "Do you want to uninstall One Drive?"
$Unpin = "Do you want to unpin all items from the Start menu?"
$InstallNET = "Do you want to install .NET 3.5?"
$LastUsedFilesFolders = "Do you want to hide last used files and folders in Explorer?"
$LastUsedFilesFolders2 = "Do you want to show last used files and folders in Explorer?"
$ClearLastUsedFilesFolders = "Do you want to clear last used files and folders?"
$AeroShake = "Do you want to disable AeroShake?"
$AeroShake2 = "Do you want to re-enable AeroShake?"
$Prompt1 = [Windows.MessageBox]::Show($Ask, "Debloat or Revert", $Button, $ErrorIco) 
Switch ($Prompt1) {
    #This will debloat Windows 10
    Yes {
        #Everything is specific prompt
        $Prompt2 = [Windows.MessageBox]::Show($EverythingorSpecific, "Everything or Specific", $Button, $Warn)
        switch ($Prompt2) {
            Yes { 
                #Creates a "drive" to access the HKCR (HKEY_CLASSES_ROOT)
                Write-Host "Creating PSDrive 'HKCR' (HKEY_CLASSES_ROOT). This will be used for the duration of the script as it is necessary for the removal and modification of specific registry keys."
                New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
                Start-Sleep 1
                Write-Host "Uninstalling bloatware, please wait."
                DebloatAll
                Write-Host "Bloatware removed."
                Start-Sleep 1
                Write-Host "Removing specific registry keys."
                Remove-Keys
                Write-Host "Leftover bloatware registry keys removed."
                Start-Sleep 1
                Write-Host "Checking to see if any Whitelisted Apps were removed, and if so re-adding them."
                Start-Sleep 1
                FixWhitelistedApps
                Start-Sleep 1
                Write-Host "Disabling Cortana from search, disabling feedback to Microsoft, and disabling scheduled tasks that are considered to be telemetry or unnecessary."
                Protect-Privacy
                Start-Sleep 1
                DisableCortana
                Write-Host "Cortana disabled and removed from search, feedback to Microsoft has been disabled, and scheduled tasks are disabled."
                Start-Sleep 1
                Write-Host "Stopping and disabling Diagnostics Tracking Service"
                DisableDiagTrack
                Write-Host "Diagnostics Tracking Service disabled"
                Start-Sleep 1
                Write-Host "Disabling WAP push service"
                DisableWAPPush
                Start-Sleep 1
                Write-Host "Re-enabling DMWAppushservice if it was disabled"
                CheckDMWService
                Start-Sleep 1
                Write-Host "Removing 3D Objects from the 'My Computer' submenu in explorer"
                Remove3dObjects
                Start-Sleep 1
                Stop-EdgePDF
                Write-Host "Edge will no longer take over as the default PDF viewer."
                Start-Sleep 1
                UninstallOneDrive
                Write-Host "OneDrive is now removed from the computer."
                Start-Sleep 1
                UnpinStart
                Write-Host "Start Apps unpined."
                Start-Sleep 1
                Write-Host "Initializing the installation of .NET 4.8..."
                DISM /Online /Enable-Feature /FeatureName:NetFx4 /All
                Write-Host ".NET 4.8 has been successfully installed!"
                Start-Sleep 1
                DisableLastUsedFilesAndFolders
                Write-Host "Last Used Files and Folders will no longer been shown!"
                Start-Sleep 1

            }
            No {
                #Creates a "drive" to access the HKCR (HKEY_CLASSES_ROOT)
                Write-Host "Creating PSDrive 'HKCR' (HKEY_CLASSES_ROOT). This will be used for the duration of the script as it is necessary for the removal and modification of specific registry keys."
                New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
                Start-Sleep 1
                Write-Host "Uninstalling bloatware, please wait."
                DebloatBlacklist
                Write-Host "Bloatware removed."
                Start-Sleep 1
                Write-Host "Removing specific registry keys."
                Remove-Keys
                Write-Host "Leftover bloatware registry keys removed."
                Start-Sleep 1
                Write-Host "Checking to see if any Whitelisted Apps were removed, and if so re-adding them."
                Start-Sleep 1
                FixWhitelistedApps
                Start-Sleep 1
                Write-Host "Disabling Cortana from search, disabling feedback to Microsoft, and disabling scheduled tasks that are considered to be telemetry or unnecessary."
                Protect-Privacy
                Start-Sleep 1
                DisableCortana
                Write-Host "Cortana disabled and removed from search, feedback to Microsoft has been disabled, and scheduled tasks are disabled."
                Start-Sleep 1
                Write-Host "Stopping and disabling Diagnostics Tracking Service"
                DisableDiagTrack
                Write-Host "Diagnostics Tracking Service disabled"
                Start-Sleep 1
                Write-Host "Disabling WAP push service"
                Start-Sleep 1
                DisableWAPPush
                Write-Host "Re-enabling DMWAppushservice if it was disabled"
                CheckDMWService
                Start-Sleep 1
            }
        }
        #Disabling EdgePDF prompt
        $Prompt3 = [Windows.MessageBox]::Show($EdgePdf, "Edge PDF", $Button, $Warn)
        Switch ($Prompt3) {
            Yes {
                Stop-EdgePDF
                Write-Host "Edge will no longer take over as the default PDF viewer."
            }
            No {
                Write-Host "You chose not to stop Edge from taking over as the default PDF viewer."
            }
        }
        #Prompt asking to delete OneDrive
        $Prompt4 = [Windows.MessageBox]::Show($OneDriveDelete, "Delete OneDrive", $Button, $ErrorIco) 
        Switch ($Prompt4) {
            Yes {
                UninstallOneDrive
                Write-Host "OneDrive is now removed from the computer."
            }
            No {
                Write-Host "You have chosen to skip removing OneDrive from your machine."
            }
        }
        #Prompt asking if you'd like to unpin all start items
        $Prompt5 = [Windows.MessageBox]::Show($Unpin, "Unpin", $Button, $ErrorIco) 
        Switch ($Prompt5) {
            Yes {
                UnpinStart
                Write-Host "Start Apps unpined."
            }
            No {
                Write-Host "Apps will remain pinned to the start menu."

            }
        }
        #Prompt asking if you want to install .NET
        $Prompt6 = [Windows.MessageBox]::Show($InstallNET, "Install .Net", $Button, $Warn)
        Switch ($Prompt6) {
            Yes {
                Write-Host "Initializing the installation of .NET 3.5..."
                DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
                Write-Host ".NET 3.5 has been successfully installed!"
            }
            No {
                Write-Host "Skipping .NET install."
            }
        }
		#Prompt asking if you want to deactivate Last Used Files and Folders
        $Prompt7 = [Windows.MessageBox]::Show($LastUsedFilesFolders, "Deactivate Last Used Files and Folders", $Button, $Warn)
       Switch ($Prompt7) {
            Yes {
                DisableLastUsedFilesAndFolders
               Write-Host "Last Used Files and Folders will no longer been shown!"
            }
            No {
                Write-Host "Skipping Hiding Last used Files and Folders."
            }
        }
		
        #Prompt asking if you'd like to reboot your machine
        $Prompt0 = [Windows.MessageBox]::Show($Reboot, "Reboot", $Button, $Warn)
        Switch ($Prompt0) {
            Yes {
                Write-Host "Unloading the HKCR drive..."
                Remove-PSDrive HKCR 
                Start-Sleep 1
                Write-Host "Initiating reboot."
                Stop-Transcript
                Start-Sleep 2
                Restart-Computer
            }
            No {
                Write-Host "Unloading the HKCR drive..."
                Remove-PSDrive HKCR 
                Start-Sleep 1
                Write-Host "Script has finished. Exiting."
                Stop-Transcript
                Start-Sleep 2
                Exit
            }
        }
    }
    No {
        Write-Host "Reverting changes..."
        Write-Host "Creating PSDrive 'HKCR' (HKEY_CLASSES_ROOT). This will be used for the duration of the script as it is necessary for the modification of specific registry keys."
        New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
        Revert-Changes
        #Prompt asking to revert edge changes as well
        $Prompt6 = [Windows.MessageBox]::Show($EdgePdf2, "Revert Edge", $Button, $ErrorIco)
        Switch ($Prompt6) {
            Yes {
                Enable-EdgePDF
                Write-Host "Edge will no longer be disabled from being used as the default Edge PDF viewer."
            }
            No {
                Write-Host "You have chosen to keep the setting that disallows Edge to be the default PDF viewer."
            }
        }
        #Prompt asking if you'd like to reboot your machine
        $Prompt0 = [Windows.MessageBox]::Show($Reboot, "Reboot", $Button, $Warn)
        Switch ($Prompt0) {
            Yes {
                Write-Host "Unloading the HKCR drive..."
                Remove-PSDrive HKCR 
                Start-Sleep 1
                Write-Host "Initiating reboot."
                Stop-Transcript
                Start-Sleep 2
                Restart-Computer
            }
            No {
                Write-Host "Unloading the HKCR drive..."
                Remove-PSDrive HKCR 
                Start-Sleep 1
                Write-Host "Script has finished. Exiting."
                Stop-Transcript
                Start-Sleep 2
                Exit
            }
        }
    }
}
    
}
#endregion

#region InstallModules
function InstallPSModules { 
    #Add Trusted Repositories
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    Install-Package NuGet.Repositories
    #AdminExtra Modules
    Install-Module -Name PackageManagement -Confirm:$false
    Install-Module -Name NuGet -Confirm:$false
    Install-Script -Name AutoModuleInstallAndUpdate -Confirm:$false
    Install-Script -Name Install-RequiredModule -Confirm:$false
    Install-Module -Name PowerShellGet -AllowPrerelease -Force -Confirm:$false
    Install-Module -Name Microsoft.PowerShell.GraphicalTools -Confirm:$false
    Install-Module -Name xWindowsUpdate -AllowPrerelease -Confirm:$false
    Install-Module -Name PSWindowsUpdate -Confirm:$false
    Install-Module -Name ComputerManagementDsc -AllowPrerelease -Confirm:$false
    Install-Module -Name Carbon -Confirm:$false
    Install-Module -Name ChocolateyGet -Confirm:$false
    Install-Module -Name Get-WindowsVersion -Confirm:$false
    Install-Module -Name ADEssentials -Confirm:$false
    Install-Module -Name Chocolatier -Confirm:$false
    Install-Module -Name GPOZaurr -Confirm:$false
    Install-Module -Name WaykNow -Confirm:$false
    Install-Module -Name PSWinGlue -Confirm:$false
    #AdminToolBox
    Install-Module -Name AdminToolbox -Confirm:$false
    Install-Module -Name AdminToolbox.EndpointManagement -Confirm:$false
    Install-Module -Name AdminToolbox.Exchange -Confirm:$false
    Install-Module -Name AdminToolbox.Networking -Confirm:$false
    Install-Module -Name AdminToolbox.ActiveDirectory -Confirm:$false
    Install-Module -Name AdminToolbox.Office365 -Confirm:$false
    Install-Module -Name AdminToolbox.Fun -Confirm:$false
    Install-Module -Name AdminToolbox.Remoting -Confirm:$false
    #Microsoft Modules
    Install-Module -Name AzureAD -Confirm:$false
    Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Confirm:$false
    Install-Module -Name ExchangeOnlineManagement -Confirm:$false
    Install-Module -Name ExchangeOnlineShell -Confirm:$false
    Install-Module -Name MSOnline -Confirm:$false
    Install-Module -Name MicrosoftTeams -AllowPrerelease -Confirm:$false
    Install-Module -Name Microsoft.Graph.Authentication -Confirm:$false
    Install-Module -Name Microsoft.Graph.Intune -Confirm:$false
    Install-Module -Name Az.Accounts -Confirm:$false
    Install-Module -Name Az.Automation -Confirm:$false
    Install-Module -Name WindowsAutoPilotIntune -Confirm:$false
    Install-Script -Name Upload-WindowsAutopilotDeviceInfo -Confirm:$false
    Install-Module -Name Intune.USB.Creator -Confirm:$false
     Install-Module PSTeams -Confirm:$false
    #Google Modules
    Install-Module -Name GoogleCloud -Confirm:$false
    Install-Module -Name GoogleSheetsCmdlets -Confirm:$false
    Install-Module -Name PSGSuite -Confirm:$false
    Install-Module -Name GoogleSearchCmdlets -Confirm:$false
    Install-Module -Name GoogleDriveCmdlets -Confirm:$false
    Install-Module GoogleSheetsCmdlets -Confirm:$false
}
#endregion

#region UpdateModules
 
#endregion

#region Tools
 function InstallSyncroMSP { }
 #
 function LaunchWPIInstaller { }

#endregion
