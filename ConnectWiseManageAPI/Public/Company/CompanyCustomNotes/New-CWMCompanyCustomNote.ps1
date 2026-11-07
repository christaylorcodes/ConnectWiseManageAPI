<#
.SYNOPSIS
    Creates a custom status note for a company.

.DESCRIPTION
    Creates a custom status note for a company in ConnectWise Manage. Calls POST
    /company/companies/{parentId}/customStatusNotes; only the parameters you pass are sent in the request
    body.

.PARAMETER parentId
    The id of the company to add the custom status note to.
    Alias: companyId

.PARAMETER status
    Status reference, for example @{ id = 1 }. Required by the API.

.PARAMETER customNote
    Custom note. Max length 1500. Required by the API.

.EXAMPLE
    New-CWMCompanyCustomNote -parentId 250 -status @{ id = 1 } -customNote 'Account is on credit hold.'

    Creates a custom status note for company status 1 on company 250.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMCompanyCustomNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [alias ('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $false)]
        [hashtable]$status,
        [Parameter(Mandatory = $false)]
        [string]$customNote
    )

    $Endpoint = "/company/companies/$($parentId)/customStatusNotes"
    Invoke-CWMNewMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
}