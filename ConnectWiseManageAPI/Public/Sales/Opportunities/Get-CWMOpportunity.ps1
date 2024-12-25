function Get-CWMOpportunity {
    param (
        [int]$CompanyID,
        [string]$Condition,
        [string]$ChildConditions,
        [string]$CustomFieldConditions,
        [string]$OrderBy,
        [string]$Fields,
        [Int32]$Page,
        [Int32]$PageSize,
        [Int32]$PageID,
        [switch]$all
    )

    $endpoint = "/sales/opportunities"

    Invoke-CWMGetMaster -Arguments $PSBoundParameters -Endpoint $endpoint
}