<#
.SYNOPSIS
    Deletes an expense entry.

.DESCRIPTION
    Deletes an expense entry from ConnectWise Manage. Calls DELETE /expense/entries/{id}.

.PARAMETER id
    The id of the expense entry to delete.
    Alias: expenseEntryId

.EXAMPLE
    Remove-CWMExpenseEntry -id 5

    Deletes expense entry 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMExpenseEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('expenseEntryId')]
        [int]$id
    )

    $Endpoint = "/expense/entries/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
