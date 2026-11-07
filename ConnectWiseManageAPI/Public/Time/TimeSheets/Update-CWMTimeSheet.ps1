function Update-CWMTimeSheet {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Submit')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('sheetId')]
        [int]$id,
        [Parameter(ParameterSetName = 'Reject')]
        [switch]$Reject,
        [Parameter(ParameterSetName = 'Reverse')]
        [switch]$Reverse,
        [Parameter(ParameterSetName = 'Submit')]
        [switch]$Submit,
        [Parameter(ParameterSetName = 'Approve')]
        [switch]$Approve,
        [Parameter(ParameterSetName = 'Approve')]
        [Parameter(ParameterSetName = 'Reject')]
        [validateset('DataEntry', 'Tier1Update', 'Tier2Update', 'Billing', 'Service', 'Project', 'MonthlySummary', 'SalesActivity', 'Schedule')]
        [string]$approvalType
    )

    # The switches only pick the action endpoint; they are never sent in the request body.
    # approve and reject take a TimeSheetTierUpdate body (id, approvalType); reverse and submit take no body.
    $Body = @{ id = $id }
    if ($PSBoundParameters.ContainsKey('approvalType')) { $Body.approvalType = $approvalType }

    switch ($PSCmdlet.ParameterSetName) {
        'Approve' { Invoke-CWMNewMaster -Arguments $Body -Endpoint "/time/sheets/$($id)/approve" }
        'Reject' { Invoke-CWMNewMaster -Arguments $Body -Endpoint "/time/sheets/$($id)/reject" }
        'Reverse' { Invoke-CWMActionMaster -Endpoint "/time/sheets/$($id)/reverse" }
        default { Invoke-CWMActionMaster -Endpoint "/time/sheets/$($id)/submit" }
    }
}
