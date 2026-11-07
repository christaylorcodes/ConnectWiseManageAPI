<#
.SYNOPSIS
    Updates the forecast of an opportunity in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing opportunity forecast.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /sales/opportunities/{parentId}/forecast

.PARAMETER parentId
    The ID of the opportunity.
    Alias: opportunityID

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'forecastItems'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMOpportunityForecast -parentId 900 -Operation replace -Path 'forecastItems' -Value $Items

    Replaces the forecast items of opportunity 900 with $Items.

.EXAMPLE
    Update-CWMOpportunityForecast 900 replace forecastItems $Items

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMOpportunityForecast -parentId 900 -PatchOperations @(
        @{ op = 'replace'; path = 'forecastItems'; value = $Items }
    )

    Sends the same change with -PatchOperations. Add more operations to the array to change several properties in one request.

.NOTES
    Endpoint: PATCH /sales/opportunities/{parentId}/forecast

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated opportunity forecast.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMOpportunityForecast {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('opportunityID')]
        [int]$parentId,
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

    $Endpoint = "/sales/opportunities/$parentId/forecast"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
