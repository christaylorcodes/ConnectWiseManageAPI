<#
.SYNOPSIS
    Creates a company type association.

.DESCRIPTION
    Creates a company type association in ConnectWise Manage. Calls POST /company/companyTypeAssociations;
    only the parameters you pass are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER type
    Type reference, for example @{ id = 1 }. Required by the API.

.PARAMETER company
    Company reference, for example @{ id = 250 }. Required by the API.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMCompanyTypeAssociation -company @{ id = 250 } -type @{ id = 1 }

    Assigns company type 1 to company 250.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMCompanyTypeAssociation {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [Parameter(Mandatory = $true)]
        [hashtable]$type,
        [Parameter(Mandatory = $true)]
        [hashtable]$company,
        [hashtable]$_info
    )

    $Endpoint = '/company/companyTypeAssociations'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
