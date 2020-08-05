function Get-CWMBoardSubtype {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$ServiceBoardID,
        [string]$Condition,
        [ValidatePattern('\S* (desc|asc)')]
        $orderBy,
        [string]$childconditions,
        [string]$customfieldconditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )
    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/boards/$ServiceBoardID/subtypes"
    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
}