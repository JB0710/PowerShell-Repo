

param (

    [Parameter( Mandatory=$false)]
    [string]$CSVFileName="A:\Clients\Assets Risk Management\Import_Contact_Template.csv"

)

$logfile = "results.log"

Get-Date | Out-File $logfile

If (Test-Path $CSVFileName) {

    #Import the CSV file
    $csvfile = Import-CSV $CSVFileName

    #Loop through CSV file
    foreach ($line in $csvfile) {

        try {
            #Create the mail contact
            New-MailContact -Name $line.ContactName -FirstName $line.FirstName -Lastname $line.LastName -ExternalEmailAddress $line.Email -ErrorAction STOP
            "$($line.Name) was created successfully." | Out-File $logfile -Append
        }
        catch {

            $message = "A problem occured trying to create the $($line.Name) contact"
            $message | Out-File $logfile -Append
            Write-Warning $message
            Write-Warning $_.Exception.Message
            $_.Exception.Message | Out-File $logfile -Append
        }

    }
}
else {

    $message = "The CSV file $CSVFileName was not found."
    $message | Out-File $logfile -Append
    throw $message

}