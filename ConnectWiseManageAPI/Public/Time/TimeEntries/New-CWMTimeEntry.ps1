function New-CWMTimeEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [Parameter(Mandatory = $true, ParameterSetName = 'Company')]
        [hashtable]$company,
        [Parameter(Mandatory = $true, ParameterSetName = 'ChargeTo')]
        [int]$chargeToId,
        [Parameter(Mandatory = $true, ParameterSetName = 'ChargeTo')]
        [ValidateSet('ServiceTicket', 'ProjectTicket', 'ChargeCode', 'Activity')]
        [string]$chargeToType,
        [hashtable]$member,
        [int]$locationId,
        [int]$businessUnitId,
        [hashtable]$workType,
        [hashtable]$workRole,
        [hashtable]$agreement,
        [Parameter(Mandatory = $true)]
        [string]$timeStart,
        [string]$timeEnd,
        [double]$hoursDeduct,
        [double]$actualHours,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billableOption,
        [string]$notes,
        [string]$internalNotes,
        [boolean]$addToDetailDescriptionFlag,
        [boolean]$addToInternalAnalysisFlag,
        [boolean]$addToResolutionFlag,
        [boolean]$emailResourceFlag,
        [boolean]$emailContactFlag,
        [boolean]$emailCcFlag,
        [string]$emailCc,
        [double]$hoursBilled,
        [string]$enteredBy,
        [string]$dateEntered,
        [hashtable]$invoice,
        [guid]$mobileGuid,
        [double]$hourlyRate,
        [hashtable]$timeSheet,
        [hashtable[]]$customFields,
        [hashtable]$_info
    )

    $Endpoint = '/time/entries'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}