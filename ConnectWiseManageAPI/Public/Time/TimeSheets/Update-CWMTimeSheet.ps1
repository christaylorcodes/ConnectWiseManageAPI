function Update-CWMTimeSheet {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('sheetId')]
        [int]$id,
        [Parameter(ParameterSetName = "Reject")]
        [switch]$Reject,
        [Parameter(ParameterSetName = "Reverse")]
        [switch]$Reverse,
        [Parameter(ParameterSetName = "Submit")]
        [switch]$Submit,
        [Parameter(ParameterSetName = "Approve")]
        [switch]$Approve,
        [Parameter(ParameterSetName = "Approve")]
        [validateset('DataEntry', 'Tier1Update', 'Tier2Update', 'Billing', 'Service', 'Project', 'MonthlySummary', 'SalesActivity', 'Schedule')]
        [string]$ApprovalType
    )

    $Endpoint = "/time/sheets/$($id)"

    if ($PsBoundParameters.ContainsKey('Approve')) {
        $PsBoundParameters.Remove('Approve')
        $Endpoint = $Endpoint + "/approve"
    } elseif ($PsBoundParameters.ContainsKey('reject')) {
        $Endpoint = $Endpoint + "/reject"
    } elseif ($PsBoundParameters.ContainsKey('reverse')) {
        $Endpoint = $Endpoint + "/reverse"
    } else {
        $Endpoint = $Endpoint + "/submit"
    }

    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}