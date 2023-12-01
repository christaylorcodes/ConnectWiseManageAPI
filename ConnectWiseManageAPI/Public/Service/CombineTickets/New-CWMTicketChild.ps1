function New-CWMTicketChild {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Bundle')]
    param(
        [int]$ParentTicketID,
        [int[]]$ChildTicketIDs,
        [Parameter(Mandatory = $true, ParameterSetName = 'Merge')]
        [int]$StatusID,
        [Parameter(ParameterSetName = 'Merge')]
        [int]$Sort,
        [Parameter(ParameterSetName = 'Merge')]
        [hashtable]$_info,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Bundle', 'Merge')]
        [string]$OperationType
    )

    if ($OperationType -eq 'Bundle') {
        $Endpoint = "/service/tickets/$($ParentTicketID)/attachChildren"
        $Body = @{
            childTicketIds = $ChildTicketIDs
        } | ConvertTo-Json
    }
    else {
        $Endpoint = "/service/tickets/$($ParentTicketID)/merge"
        $Body = @{
            mergeTicketIds = $ChildTicketIDs
            status         = @{
                id    = $StatusID
                name  = $StatusName
                sort  = $Sort
                _info = $_info
            }
        } | ConvertTo-Json
    }

    if ($PSCmdlet.ShouldProcess("ChildTickets with IDs $($ChildTicketIDs -join ', ')", "Operation: $OperationType on ParentTicket with ID $ParentTicketID")) {
        $PsBoundParameters.Add('Body', $Body)
        Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }
}

