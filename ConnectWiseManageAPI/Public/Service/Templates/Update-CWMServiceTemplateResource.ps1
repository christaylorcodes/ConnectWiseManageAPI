<#
.SYNOPSIS
    Updates a service template resource in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing service template resource.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.
    To replace the whole resource, use Set-CWMServiceTemplateResource.

    This function calls the ConnectWise Manage API endpoint: PATCH /service/templates/{parentId}/resources/{id}

.PARAMETER parentId
    The ID of the service template (required).
    Alias: templateId

.PARAMETER id
    The ID of the resource to update (required).
    Alias: resourceId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The resource property to change, for example 'hours' or 'member'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMServiceTemplateResource -parentId 15 -id 3 -Operation replace -Path 'hours' -Value 2

    Replaces the hours of resource 3 of service template 15.

.EXAMPLE
    Update-CWMServiceTemplateResource 15 3 replace hours 2

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMServiceTemplateResource -parentId 15 -id 3 -PatchOperations @(
        @{ op = 'replace'; path = 'member'; value = @{ identifier = 'jdoe' } }
        @{ op = 'replace'; path = 'isTicketOwner'; value = $true }
    )

    Changes the member and ticket owner flag in one request.

.NOTES
    Endpoint: PATCH /service/templates/{parentId}/resources/{id}

    Based on PR #82 by mdewart-Centre. #82 accepted only -PatchOperations; -Operation/-Path/-Value were
    added to match the other Update-CWM* functions.

.LINK
    Get-CWMServiceTemplateResource

.LINK
    Set-CWMServiceTemplateResource

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated service template resource.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMServiceTemplateResource {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('templateId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('resourceId')]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 4, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/service/templates/$($parentId)/resources/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
