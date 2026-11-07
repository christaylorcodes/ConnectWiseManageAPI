<#
.SYNOPSIS
    Deletes a user defined field.

.DESCRIPTION
    Deletes a user defined field from ConnectWise Manage. Calls DELETE /system/userDefinedFields/{id}.

.PARAMETER id
    The id of the user defined field to delete.
    Alias: userDefinedFieldId

.EXAMPLE
    Remove-CWMUserDefinedField -id 5

    Deletes user defined field 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMUserDefinedField {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('userDefinedFieldId')]
        [int]$id
    )

    $Endpoint = "/system/userDefinedFields/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
