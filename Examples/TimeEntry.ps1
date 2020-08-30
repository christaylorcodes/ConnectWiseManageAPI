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

# We are going add time to an existing ticket

# We can look at the Get-Help and the Manage docs for the parameters
# https://developer.connectwise.com/manage/rest?a=Time&e=TimeEntries&o=CREATE

$TimeEntryDetail = @{
    chargeToId = <TicketNumber>
    chargeToType = 'ServiceTicket'
    member = @{id=<IDNumber>}
    notes = 'TimeEntry Test'
    timeStart = '2020-08-30T18:03:10Z'
    timeEnd = '2020-08-30T19:03:34Z'
    hoursDeduct = 0.00
}

New-CWMTimeEntry @TimeEntryDetail

# To clear your connection information from memory you can terminate the session or issue the disconnect command.
Disconnect-CWM
