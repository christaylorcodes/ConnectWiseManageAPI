<#
.SYNOPSIS
    Updates an existing company in ConnectWise Manage using patch operations.

.DESCRIPTION
    Modifies company properties using JSON Patch operations (add, replace, remove).
    This follows the RFC 6902 JSON Patch standard.

    This function calls the ConnectWise Manage API endpoint: PATCH /company/companies/{id}

.PARAMETER id
    The company ID to update (required).
    Alias: companyId

.PARAMETER Operation
    The patch operation: 'add', 'replace', or 'remove'.

.PARAMETER Path
    The field path to modify.
    Examples: 'name', 'phoneNumber', 'status', 'addressLine1'

.PARAMETER Value
    The new value for the field (required for 'add' and 'replace').

.EXAMPLE
    Update-CWMCompany -id 250 -Operation 'replace' -Path 'name' -Value 'Acme Corporation Inc'

    Updates the company name.

.EXAMPLE
    Update-CWMCompany -id 250 -Operation 'replace' -Path 'phoneNumber' -Value '206-555-9999'

    Updates the phone number.

.EXAMPLE
    Update-CWMCompany -id 250 -Operation 'replace' -Path 'status' -Value @{ id = 1 }

    Changes the company status.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Common Update Paths:
    - 'name', 'identifier'
    - 'phoneNumber', 'faxNumber', 'website'
    - 'addressLine1', 'city', 'state', 'zip'
    - 'status', 'territory', 'types'

.LINK
    https://developer.connectwise.com/manage/rest#/Companies

.LINK
    Get-CWMCompany

.LINK
    New-CWMCompany

.LINK
    Remove-CWMCompany

#>
function Update-CWMCompany {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    $Endpoint = "/company/companies/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}