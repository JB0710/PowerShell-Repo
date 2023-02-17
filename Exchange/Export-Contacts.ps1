#Preferences
$ErrorActionPreference = 'SilentlyContinue'

#M365 Login
$user = $(Write-Host "Enter M365 Admin UserName" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)
$targetUser = $(Write-Host "Enter Target's UserName" -ForegroundColor Yellow -NoNewLine) + $(Write-Host " : " -ForegroundColor yellow -NoNewLine; Read-Host)
Connect-ExchangeOnline -UserPrincipalName $user

#Impersonation Rights
Enable-OrganizationCustomization -ErrorAction SilentlyContinue
New-ManagementRoleAssignment -Role "ApplicationImpersonation" -User $user

function Export-Contacts
{
    Write-Verbose ("Getting contacts for $targetUser as "+$targetUser)

    # EWS service url for Exchange Online
    $webServiceUrl="https://outlook.office365.com/EWS/Exchange.asmx"

    # SOAP message for getting contact ItemIds
    $getItemIds="<?xml version=""1.0"" encoding=""utf-8""?>"+
    "<soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" "+
    "               xmlns:m=""http://schemas.microsoft.com/exchange/services/2006/messages"" "+
    "               xmlns:t=""http://schemas.microsoft.com/exchange/services/2006/types"" "+
    "               xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">"+
    "  <soap:Header>"+
    "    <t:ExchangeImpersonation>"+
    "      <t:ConnectingSID>"+
    "        <t:PrimarySmtpAddress>$User</t:PrimarySmtpAddress>"+
    "      </t:ConnectingSID>"+
    "    </t:ExchangeImpersonation>"+
    "  </soap:Header>"+
    "  <soap:Body>"+
    "    <m:FindItem Traversal=""Shallow"">"+
    "      <m:ItemShape>"+
    "        <t:BaseShape>IdOnly</t:BaseShape>"+
    "      </m:ItemShape>"+
    "      <m:IndexedPageItemView MaxEntriesReturned=""$MaxResults"" Offset=""$Skip"" BasePoint=""Beginning"" />"+
    "      <m:ParentFolderIds>"+
    "        <t:DistinguishedFolderId Id=""contacts"" />"+
    "      </m:ParentFolderIds>"+
    "    </m:FindItem>"+
    "  </soap:Body>"+
    "</soap:Envelope>"

    Write-Verbose "Id Request: $getItemIds"

    # Invoke request and convert to XML document
    $IdResponse=Invoke-WebRequest -Uri $webServiceUrl -Credential $Credentials -Body $getItemIds -Method Post
    [xml]$xmlIdResponse=$IdResponse.Content

    Write-Verbose ("Id Response: "+$IdResponse.Content)

    # Get the number of found contacts
    $numOfContacts=$xmlIdResponse.Envelope.Body.FindItemResponse.ResponseMessages.FindItemResponseMessage.RootFolder.TotalItemsInView

    if($numOfContacts -gt 0)
    {
        # Get the contacts from the response
        $contactIds=$xmlIdResponse.Envelope.Body.FindItemResponse.ResponseMessages.FindItemResponseMessage.RootFolder.Items.Contact

        # Print out the number of results
        Write-Host "$numOfContacts contact(s) found for $targetUser" -ForegroundColor Red

        # Loop through the results and build ItemIds block for GetItem SOAP request
        $ItemIds=""
        foreach($contactId in $contactIds)
        {
            $ItemIds+="<t:ItemId Id="""+$contactId.ItemId.Id+""" />"
        }

        # SOAP message for getting contacts
        $getItems="<soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" "+
        "               xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" "+
        "               xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"" "+
        "               xmlns:t=""http://schemas.microsoft.com/exchange/services/2006/types"">"+
        "  <soap:Header>"+
        "    <t:ExchangeImpersonation>"+
        "      <t:ConnectingSID>"+
        "        <t:PrimarySmtpAddress>$User</t:PrimarySmtpAddress>"+
        "      </t:ConnectingSID>"+
        "    </t:ExchangeImpersonation>"+
        "  </soap:Header>"+
        "  <soap:Body>"+
        "    <GetItem xmlns=""http://schemas.microsoft.com/exchange/services/2006/messages"">"+
        "      <ItemShape>"+
        "        <t:BaseShape>AllProperties</t:BaseShape>"+
        "      </ItemShape>"+
        "      <ItemIds>"+
        $ItemIds+
        "      </ItemIds>"+
        "    </GetItem>"+
        "  </soap:Body>"+
        "</soap:Envelope>"

        Write-Verbose "Item Request: $getItems"

        # Invoke request and convert to XML document
        $ItemResponse=Invoke-WebRequest -Uri $webServiceUrl -Credential $Credentials -Body $getItems -Method Post
        [xml]$xmlItemResponse=$ItemResponse.Content

        Write-Verbose ("Item Response: "+$ItemResponse.Content)

        # Retrieve contacts
        $contacts=$xmlItemResponse.Envelope.Body.GetItemResponse.ResponseMessages.GetItemResponseMessage.Items.Contact

        # Loop through the contacts
        foreach($contact in $contacts)
        {
            # Retrieve email addresses
            $emailAddresses = @()
            foreach($emailAddress in $contact.EmailAddresses.Entry)
            {
                $emailAddresses+=$emailAddress.'#text'
            }

            # Create a custom return object
            $contactDetails= @{}
            $contactDetails.Subject = $contact.Subject
            $contactDetails.Created = $contact.DateTimeCreated
            $contactDetails.DisplayName = $contact.DisplayName
            $contactDetails.GivenName = $contact.GivenName
            $contactDetails.Surname = $contact.Surname
            $contactDetails.EmailAddresses = $emailAddresses

            # Return contacts
            New-Object -TypeName PSObject -Property $contactDetails
        }
    }
    else
    {
        Write-Host "No contacts found for $targetUser" -ForegroundColor Red
    }
}

Export-Contacts -User $targetUser | Export-Csv D:\$targetUser.csv -NoTypeInformation
