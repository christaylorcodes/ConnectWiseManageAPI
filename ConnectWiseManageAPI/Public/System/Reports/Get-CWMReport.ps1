<#
.SYNOPSIS
    Gets the available reports, or the data of one report.

.DESCRIPTION
    Without -id, lists the reports available to the API (GET /system/reports). With -id, returns the data of
    that report (GET /system/reports/{reportName}) converted from columns and rows into objects.

.PARAMETER id
    The name of the report to run, for example 'ChargeCode'.
    Alias: reportName

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "name like 'Service*'".

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
    Only return these fields, for example @('id', 'name').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMReport -all

    Lists the names of all available reports.

.EXAMPLE
    Get-CWMReport -id 'ChargeCode'

    Returns the rows of the ChargeCode report as objects.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMReport {
    [CmdletBinding()]
    param(
        [Alias('reportName')]
        [string]$id,
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

    $Endpoint = '/system/reports'
    $Result = Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    if(!$Result){ return }
    if($id){ ConvertFrom-CWMColumnRow -Data $Result }
    else{ $Result }
}