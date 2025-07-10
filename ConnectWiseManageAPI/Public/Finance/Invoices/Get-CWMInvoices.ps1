function Get-CWMInvoices {
    [CmdletBinding()]
    param(
        [int]$id,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields
    )

    if ($id) {
        $Endpoint = '/finance/invoices/$($Id)'
        Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }
    else {
        $Endpoint = '/finance/invoices'
        Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }
}
