<#
.SYNOPSIS
    Gets the audit trail of a record.

.DESCRIPTION
    Retrieves the audit trail entries of one record, identified by its type and id. Calls GET
    /system/audittrail?type={type}&id={id} (GET /system/audittrail/count with -count).

.PARAMETER type
    The type of the record, for example Ticket, Company or Agreement.

.PARAMETER id
    The id of the record whose audit trail is returned.

.PARAMETER count
    Return only the number of matching audit trails instead of the records.

.PARAMETER deviceIdentifier
    Device identifier, sent as the deviceIdentifier query parameter.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "text contains 'callback'".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'text').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMAuditTrail -type Ticket -id 1234 -all

    Retrieves the full audit trail of service ticket 1234.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMAuditTrail {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('None', 'Ticket', 'Contact', 'Company', 'Opportunity', 'Time', 'Activity', 'ProductCatalog', 'ProjectTicket', 'Purchasing', 'Configuration', 'Schedule', 'Agreement', 'AgreementAddition', 'Project', 'Invoice', 'PurchaseOrder', 'Expense')]
        $type,
        [Parameter(Mandatory = $true)]
        [string]$id,
        [switch]$count,
        [string]$deviceIdentifier,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    # type, id and deviceIdentifier are query parameters here, not path segments, so they are taken out of
    # a copy of $PSBoundParameters. /count is added before the query string (Invoke-CWMGetMaster would add it after).
    $Arguments = @{}
    foreach ($Key in $PSBoundParameters.Keys) { $Arguments[$Key] = $PSBoundParameters[$Key] }
    foreach ($Key in 'type', 'id', 'deviceIdentifier', 'count') { $null = $Arguments.Remove($Key) }

    $Endpoint = '/system/audittrail'
    if ($count) {
        $Endpoint += '/count'
        $null = $Arguments.Remove('all')
    }
    $Endpoint += "?type=$([uri]::EscapeDataString([string]$type))&id=$([uri]::EscapeDataString($id))"
    if ($deviceIdentifier) { $Endpoint += "&deviceIdentifier=$([uri]::EscapeDataString($deviceIdentifier))" }

    $Result = Invoke-CWMGetMaster -Arguments $Arguments -Endpoint $Endpoint
    if ($count -and $null -ne $Result -and $Result.PSObject.Properties['count']) { $Result = $Result.count }
    $Result
}
