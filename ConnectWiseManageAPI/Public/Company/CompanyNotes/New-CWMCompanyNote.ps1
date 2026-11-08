<#
.SYNOPSIS
    Creates a note for a company.

.DESCRIPTION
    Creates a note for a company in ConnectWise Manage. Calls POST /company/companies/{parentId}/notes; only
    the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the company to add the note to.
    Aliases: companyId, id (the name used before 0.5.0)

.PARAMETER flagged
    Flagged. $true or $false.

.PARAMETER text
    Text. Required by the API.

.EXAMPLE
    New-CWMCompanyNote -parentId 250 -text 'Discussed the contract renewal with the owner.' -flagged $true

    Adds a flagged note to company 250.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMCompanyNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId', 'id')]
        [int]$parentId,
        [Parameter(Mandatory = $false)]
        [bool]$flagged,
        [Parameter(Mandatory = $false)]
        [string]$text
    )

    $Endpoint = "/company/companies/$($parentId)/notes"
    Invoke-CWMNewMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
}