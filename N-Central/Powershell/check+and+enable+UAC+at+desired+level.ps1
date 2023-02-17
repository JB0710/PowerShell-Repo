$uac_level_1 = (0, 3 ,1, 0, 1, 0, 1)
$uac_level_2 = (5, 3, 1, 0, 1, 0, 1)
$uac_level_3 = (5, 3, 1, 0, 1, 1, 1)
$uac_level_4 = (2, 3, 1, 0, 1, 1, 1)

$uac_changed = 0

$current_uac = ("ConsentPromptBehaviorAdmin","ConsentPromptBehaviorUser","EnableInstallerDetection","ValidateAdminCodeSignatures",
                "EnableLUA","PromptOnSecureDesktop","EnableVirtualization")

foreach ($property in $current_uac) {
    $value = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).$property
    $position = $current_uac.IndexOf($property)
    if (-not($value -eq $uac_level_3[$position])) { 
        Set-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name $property -Value $uac_level_3[$position] 
        if ($uac_changed -eq 0) {
            $uac_changed = 1
        }
    }
}

if ($uac_changed -eq 1) {
    write-host "The UAC level was incorrect and will be changed"
    exit 1
}
else {
    write-host "The UAC is enabled at level 3"
}
