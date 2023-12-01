<#
.SYNOPSIS
Creates a child ticket relationship by either bundling or merging tickets in ConnectWise Manage.

.DESCRIPTION
The `New-CWMTicketChild` function allows users to either bundle or merge tickets in ConnectWise Manage.
Bundling creates a relationship between tickets without changing their properties, while merging combines tickets 
and may require specifying additional parameters like status details.

.PARAMETER ParentTicketID
The ID of the parent ticket.

.PARAMETER ChildTicketIDs
An array of IDs for the child tickets that will be either bundled or merged with the parent ticket.

.PARAMETER StatusID
(Only for Merge operation) The status ID for the merged ticket.

.PARAMETER Sort
(Only for Merge operation) The sort order for the merged ticket.

.PARAMETER _info
(Only for Merge operation) Additional information for the merged ticket.

.PARAMETER OperationType
Specifies the type of operation to perform: "Bundle" or "Merge".

.EXAMPLE
New-CWMTicketChild -ParentTicketID 1234 -ChildTicketIDs 5678 -OperationType Bundle
This example demonstrates how to bundle a single child ticket (ID: 5678) to a parent ticket (ID: 1234).

.EXAMPLE
New-CWMTicketChild -ParentTicketID 1234 -ChildTicketIDs 5678, 91011 -OperationType Bundle
This example demonstrates how to bundle multiple child tickets (IDs: 5678, 91011) to a parent ticket (ID: 1234).

.EXAMPLE
New-CWMTicketChild -ParentTicketID 1234 -ChildTicketIDs 5678 -OperationType Merge -StatusID 17 -Sort 0 -_info @{ additionalProp1 = "value1"; additionalProp2 = "value2" }
This example demonstrates how to merge a single child ticket (ID: 5678) into a parent ticket (ID: 1234) with specified status details.

.EXAMPLE
New-CWMTicketChild -ParentTicketID 1234 -ChildTicketIDs 5678, 91011 -OperationType Merge -StatusID 17 -Sort 0 -_info @{ additionalProp1 = "value1"; additionalProp2 = "value2" }
This example demonstrates how to merge multiple child tickets (IDs: 5678, 91011) into a parent ticket (ID: 1234) with specified status details.

#>
function New-CWMTicketChild {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium', DefaultParameterSetName = "Bundle")]
    param(
        [int]$ParentTicketID,
        [int[]]$ChildTicketIDs,
        
        [Parameter(Mandatory=$true, ParameterSetName = "Merge")]
        [Mandatory]
        [int]$StatusID,

        [Parameter(ParameterSetName = "Merge")]
        [int]$Sort,

        [Parameter(ParameterSetName = "Merge")]
        [hashtable]$_info,
        
        [Parameter(Mandatory=$true)]
        [ValidateSet("Bundle", "Merge")]
        [string]$OperationType
    )

    if ($OperationType -eq "Bundle") {
        $Endpoint = "/service/tickets/$($ParentTicketID)/attachChildren"
        $Body = @{
            childTicketIds = $ChildTicketIDs
        } | ConvertTo-Json
    } else {
        $Endpoint = "/service/tickets/$($ParentTicketID)/merge"
        $Body = @{
            mergeTicketIds = $ChildTicketIDs
            status = @{
                id = $StatusID
                name = $StatusName
                sort = $Sort
                _info = $_info
            }
        } | ConvertTo-Json
    }

    if ($PSCmdlet.ShouldProcess("ChildTickets with IDs $($ChildTicketIDs -join ', ')", "Operation: $OperationType on ParentTicket with ID $ParentTicketID")) {
        $PsBoundParameters.Add('Body', $Body)
        Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }
}

