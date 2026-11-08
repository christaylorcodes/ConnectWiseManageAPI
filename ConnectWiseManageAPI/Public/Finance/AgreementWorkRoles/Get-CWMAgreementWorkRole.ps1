<#
.SYNOPSIS
    Gets agreement work role rates.

.DESCRIPTION
    Retrieves agreement work role rates from ConnectWise Manage, or a single agreement work role rate by id. Calls GET
    /finance/agreements/{parentId}/workroles; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the agreement.
    Alias: agreementId

.PARAMETER id
    The id of a single agreement work role rate to retrieve.

.PARAMETER count
    Return only the number of matching agreement work role rates instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "rateType='Custom'".

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
    Only return these fields, for example @('id', 'rate').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMAgreementWorkRole -parentId 12 -all

    Retrieves every agreement work role rate of agreement 12.

.EXAMPLE
    Get-CWMAgreementWorkRole -parentId 12 -id 5

    Retrieves agreement work role rate 5 of agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMAgreementWorkRole {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId,
        [Alias('agreementWorkRoleId')]
        [int]$id,
        [switch]$count,
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

    $Endpoint = "/finance/agreements/$($parentId)/workroles"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
