# Example: list the service tickets attached to a ConnectWise Manage configuration (GitHub issue #38).
#
# ConnectWise Manage has no /company/configurations/{id}/tickets endpoint. The link between a
# ticket and a configuration is stored on the ticket (/service/tickets/{id}/configurations), so
# the query runs against tickets and filters on that child collection with -childConditions.
#
# NOTE: the 'configurations/id=N' child condition is not covered by the public API reference we
# could reach. Try it against your server first. If it is rejected or returns nothing, use the
# fallback at the end of this file, which uses only documented endpoints.

$CWMConnectionInfo = @{
    # This is the URL to your manage server.
    Server     = 'server.example.com'
    # This is the company entered at login
    Company    = 'My Company ID'
    # Public key created for this integration
    pubkey     = '1234'
    # Private key created for this integration
    privatekey = 'abcd'
    # Your ClientID found at https://developer.connectwise.com/ClientID
    clientId   = 'Go generate your own ClientID'
}
# ^This information is sensitive, take precautions to secure it.^

Import-Module 'ConnectWiseManageAPI'
Connect-CWM @CWMConnectionInfo

# The configuration to look up
$ConfigurationId = 1234

# Option 1: one query, filtering tickets on their configurations child collection.
# Without -id or -count, Get-CWMTicket uses POST /service/tickets/search and sends
# childConditions in the request body.
$Tickets = Get-CWMTicket -childConditions "configurations/id=$ConfigurationId" -orderBy 'id desc' -all
$Tickets | Select-Object id, summary, @{ n = 'status'; e = { $_.status.name } }, dateEntered

# Option 2 (fallback): read the configuration's company, then check the configurations attached to
# each of that company's tickets. This uses one extra request per ticket, so narrow the condition
# (for example by date or board) on companies with a lot of tickets.
$Configuration = Get-CWMCompanyConfiguration -id $ConfigurationId
$CompanyTickets = Get-CWMTicket -condition "company/id=$($Configuration.company.id)" -fields 'id', 'summary' -all
$Tickets = foreach ($Ticket in $CompanyTickets) {
    $Attached = Get-CWMTicketConfiguration -parentId $Ticket.id -all
    if ($Attached.id -contains $ConfigurationId) { $Ticket }
}
$Tickets | Select-Object id, summary
