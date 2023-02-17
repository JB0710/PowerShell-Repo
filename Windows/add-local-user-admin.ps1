
$userFullName = $(Write-Host "Enter New Local Admin Full Name" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)
$Username = $(Write-Host "Enter A Username" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)
$Password = $(Write-Host "Enter A Password" -ForegroundColor Red -NoNewLine) + $(Write-Host " : " -ForegroundColor Red -NoNewLine; Read-Host -AsSecureString)
$Description = "Local Admin User"

function CreateNewLocalAdmin {

    try {
        $op = Get-LocalUser | Where-Object {$_.Name -eq "$Username"}
        if ( -not $op) {
			New-LocalUser "$Username" -Password $Password -FullName "$userFullName" -Description $Description
			Set-LocalUser -Name "$Username" -UserMayChangePassword $false -PasswordNeverExpires $true
			Write-Host "$Username local user created"
			Add-LocalGroupMember -Group "Administrators" -Member "$Username"
			Write-Host "$Username added to the local administrator group"
		}
        else {
            Write-Host "$Username already exists"
        }
    } catch {
        Write-Host "Fatal Exception:[$_.Exception.Message]"
    }
}

CreateNewLocalAdmin
Start-Sleep 3
Exit