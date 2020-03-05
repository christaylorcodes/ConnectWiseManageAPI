$CWMConnectionInfo = @{
    # This is the URL to your manage server.
    Server      = 'server.example.com'
    # This is the company entered at login
    Company     = 'My Company ID'
    # Public key created for this integration
    pubkey      = '1234'
    # Private key created for this integration
    privatekey  = 'abcd'
    # Your ClientID found at https://developer.connectwise.com/ClientID
    clientid    = 'Go generate your own ClientID'
}
# ^This information is sensitive, take precautions to secure it.^

# Install/Update/Load the module
if(Get-InstalledModule 'ConnectWiseManageAPI' -ErrorAction SilentlyContinue) { Update-Module 'ConnectWiseManageAPI' -Verbose }
else { Install-Module 'ConnectWiseManageAPI' -Verbose }
Import-Module 'ConnectWiseManageAPI'

# Connect to your Manage server
Connect-CWM @CWMConnectionInfo -Force -Verbose

# We are going to create a new ticket

# Choose a company to make test a ticket for
# This can take a bit to pull all your companies
$Companies = Get-CWMCompany -all
$Company = $Companies | Select-Object ID, Name | Out-GridView -OutputMode Single -Title 'Select Company'

# We can look at the Get-Help and the Manage docs for the parameters
# https://developer.connectwise.com/Products/Manage/REST?a=Service&e=Tickets&o=GETBYID#/Tickets/postServiceTickets
$NewTicketParameters = @{
    summary = 'Testing out the API'
    # We want to pass Manage objects as hash tables
    company = @{id = $Company.ID}
    contactName = 'Chris Taylor'
    contactPhoneNumber = '123456789'
    contactEmailAddress = 'dont@bug.me'
}
$NewTicket = New-CWMTicket @NewTicketParameters

# Now lets post an update to the ticket
New-CWMTicketNote -ticketId $NewTicket.id -text 'PowerShell and Manage together at last!' -internalAnalysisFlag $true -Verbose  -ErrorAction Stop

# Never mind, lets delete that ticket
Remove-CWMTicket -TicketID $NewTicket.id

# To clear your connection information from memory you can terminate the session or issue the disconnect command.
Disconnect-CWM