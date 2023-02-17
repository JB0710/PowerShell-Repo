<# 
.NAME
    M365 Journaling Rule Creator
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(679,192)
$Form.text                       = "Form"
$Form.TopMost                    = $false

$TextBoxJournalingRuleName       = New-Object system.Windows.Forms.TextBox
$TextBoxJournalingRuleName.multiline  = $false
$TextBoxJournalingRuleName.width  = 322
$TextBoxJournalingRuleName.height  = 20
$TextBoxJournalingRuleName.location  = New-Object System.Drawing.Point(22,40)
$TextBoxJournalingRuleName.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LabelRuleName                   = New-Object system.Windows.Forms.Label
$LabelRuleName.text              = "Journaling Rule Name"
$LabelRuleName.AutoSize          = $true
$LabelRuleName.width             = 25
$LabelRuleName.height            = 10
$LabelRuleName.location          = New-Object System.Drawing.Point(22,25)
$LabelRuleName.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBoxJournalingAddress        = New-Object system.Windows.Forms.TextBox
$TextBoxJournalingAddress.multiline  = $false
$TextBoxJournalingAddress.width  = 494
$TextBoxJournalingAddress.height  = 20
$TextBoxJournalingAddress.location  = New-Object System.Drawing.Point(25,98)
$TextBoxJournalingAddress.Font   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LabelJournalingAddress          = New-Object system.Windows.Forms.Label
$LabelJournalingAddress.text     = "Journaling Address"
$LabelJournalingAddress.AutoSize  = $true
$LabelJournalingAddress.width    = 25
$LabelJournalingAddress.height   = 10
$LabelJournalingAddress.location  = New-Object System.Drawing.Point(25,76)
$LabelJournalingAddress.Font     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Create Rule"
$Button1.width                   = 77
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(25,137)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($TextBoxJournalingRuleName,$LabelRuleName,$TextBoxJournalingAddress,$LabelJournalingAddress,$Button1))

$Button1.Add_Click({ CreateRule })

#region Logic 
function CreateRule { }

#endregion

#region CreateRule
 function CreateRule {
     
     $JournalingRuleName = TextBoxJournalingRuleName.Text
     $JournalingAddress = TextBoxJournalingAddress.Text
     
     $UserCredential = Get-Credential
     New-JournalRule -Name "$JournalingRuleName" -JournalEmailAddress "$JournalingAddress" -Scope Global -Enabled $true
     
 }
#endregion

[void]$Form.ShowDialog()