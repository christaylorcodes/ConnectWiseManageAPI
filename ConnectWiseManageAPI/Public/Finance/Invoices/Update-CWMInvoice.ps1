<#
.SYNOPSIS
    Updates an invoice in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing invoice.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /finance/invoices/{id}

.PARAMETER id
    The id of the invoice to update.
    Alias: invoiceId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'customerPO'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMInvoice -id 5 -Operation replace -Path 'customerPO' -Value 'PO-1001'

    Sets customerPO of invoice 5.

.EXAMPLE
    Update-CWMInvoice 5 replace customerPO 'PO-1001'

    The same change, using positional parameters.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated invoice.
#>
function Update-CWMInvoice {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('invoiceId')]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 3, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/finance/invoices/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
