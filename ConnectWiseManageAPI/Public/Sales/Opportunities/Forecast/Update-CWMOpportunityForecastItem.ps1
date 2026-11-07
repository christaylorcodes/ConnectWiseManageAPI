<#
.SYNOPSIS
    Updates a forecast item of an opportunity in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing opportunity forecast item.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /sales/opportunities/{parentId}/forecast/{id}

.PARAMETER parentId
    The ID of the opportunity.
    Alias: opportunityID

.PARAMETER id
    The ID of the forecast item to update.

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'revenue'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMOpportunityForecastItem -parentId 900 -id 2 -Operation replace -Path 'revenue' -Value 1500

    Sets the revenue of forecast item 2 of opportunity 900.

.EXAMPLE
    Update-CWMOpportunityForecastItem 900 2 replace revenue 1500

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMOpportunityForecastItem -parentId 900 -id 2 -PatchOperations @(
        @{ op = 'replace'; path = 'revenue'; value = 1500 }
        @{ op = 'replace'; path = 'cost'; value = 900 }
    )

    Changes the revenue and cost of forecast item 2 in one request.

.NOTES
    Endpoint: PATCH /sales/opportunities/{parentId}/forecast/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated opportunity forecast item.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMOpportunityForecastItem {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('opportunityID')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
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

    $Endpoint = "/sales/opportunities/$parentId/forecast/$id"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
