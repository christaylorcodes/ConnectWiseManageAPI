function New-CWMExpenseEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [hashtable]$company,
        [int]$chargeToId,
        [ValidateSet ('Company', 'ServiceTicket', 'ProjectTicket', 'ChargeCode', 'Activity')]
        [string]$chargeToType,
        [parameter(Mandatory = $true)]
        [hashtable]$type,
        [Parameter(Mandatory = $true)]
        [hashtable]$member,
        [hashtable]$paymentMethod,
        [hashtable]$classification,
        [parameter(Mandatory = $true)]
        [double]$amount,
        [ValidateSet ('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billableOption,
        [parameter(Mandatory = $true)]
        [string]$date,
        [int]$locationId,
        [int]$businessUnitId,
        [string]$notes,
        [hashtable]$agreement,
        [double]$agreementAmount,
        [double]$odometerStart,
        [double]$odometerEnd,
        [hashtable]$ticket,
        [hashtable]$project,
        [hashtable]$phase,
        [hashtable]$customFields
    )

    $Endpoint = '/expense/entries'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
