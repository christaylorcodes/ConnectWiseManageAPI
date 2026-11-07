# Example: list the service tickets attached to a ConnectWise Manage configuration (GitHub issue #38).
#
# The ConnectWise Manage API (OpenAPI spec 2026.11) has no endpoint that lists the tickets of a
# configuration: /company/configurations/{id} has no tickets child path, and the Ticket model has no
# configurations property to filter on. The only link between the two is stored per ticket, at
# GET /service/tickets/{id}/configurations (Get-CWMTicketConfiguration).
#
# So this example reads the configuration's company, lists that company's tickets, and checks the
# configurations attached to each ticket. That is one extra request per ticket: narrow the condition
# (for example by board, status or date) on companies with a lot of tickets.
#
# Project tickets have the same per-ticket link (/project/tickets/{id}/configurations); this example
# only covers service tickets.

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

$Configuration = Get-CWMCompanyConfiguration -id $ConfigurationId
$CompanyTickets = Get-CWMTicket -condition "company/id=$($Configuration.company.id)" -fields 'id', 'summary' -all
$Tickets = foreach ($Ticket in $CompanyTickets) {
    $Attached = Get-CWMTicketConfiguration -parentId $Ticket.id -all
    if ($Attached.id -contains $ConfigurationId) { $Ticket }
}
$Tickets | Select-Object id, summary
