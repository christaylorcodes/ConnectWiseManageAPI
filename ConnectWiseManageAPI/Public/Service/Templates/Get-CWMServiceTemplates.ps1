function Get-CWMServiceTemplates {
    [CmdletBinding()]
    param(
        [string]$clientId ,
        [int]$pageId,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields
    )

    $Endpoint = '/service/templates'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}