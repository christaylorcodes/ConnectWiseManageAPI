<#
.SYNOPSIS
    Submits, approves, rejects or reverses a time sheet.

.DESCRIPTION
    Runs a time sheet action. Calls POST /time/sheets/{id}/submit (the default), /approve, /reject or
    /reverse. Approve and reject send a TimeSheetTierUpdate body with the id and, if given, the approval
    type.

.PARAMETER id
    The id of the time sheet.
    Alias: sheetId

.PARAMETER Reject
    Reject the time sheet (POST /time/sheets/{id}/reject).

.PARAMETER Reverse
    Reverse the time sheet (POST /time/sheets/{id}/reverse).

.PARAMETER Submit
    Submit the time sheet (POST /time/sheets/{id}/submit). This is the default action.

.PARAMETER Approve
    Approve the time sheet (POST /time/sheets/{id}/approve).

.PARAMETER approvalType
    With -Approve or -Reject, the approval tier sent as approvalType in the request body. One of: DataEntry,
    Tier1Update, Tier2Update, Billing, Service, Project, MonthlySummary, SalesActivity, Schedule.

.EXAMPLE
    Update-CWMTimeSheet -id 88 -Approve -approvalType Tier1Update

    Approves time sheet 88 at tier 1.

.EXAMPLE
    Update-CWMTimeSheet -id 88 -Reverse

    Reverses time sheet 88.

.LINK
    Submit-CWMTimeSheet

.LINK
    Get-CWMTimeSheet

.LINK
    https://developer.connectwise.com/manage/rest
#>
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
