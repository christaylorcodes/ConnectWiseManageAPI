function Get-CWMCompanyContactNote {
    [CmdletBinding()]
    [Alias('Get-CWMContactNote')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('contactId')]
        [int]$parentId,
        [Alias('noteId')]
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

    $Endpoint = "/company/contacts/$($parentId)/notes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
