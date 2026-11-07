<#
.SYNOPSIS
    Retrieves the resources assigned to a service template in ConnectWise Manage.

.DESCRIPTION
    Gets the resources (members) assigned to a service template.
    Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

    This function calls the ConnectWise Manage API endpoint: GET /service/templates/{parentId}/resources

.PARAMETER parentId
    The ID of the service template (required).
    Alias: templateId

.PARAMETER id
    The ID of a specific resource.
    When specified, returns only that resource.
    Alias: resourceId

.PARAMETER count
    Returns only the count of matching resources.

.PARAMETER condition
    Filter resources using ConnectWise Manage condition syntax.
    Example: "member/identifier='jdoe'"

.PARAMETER orderBy
    Sort results by specified field and direction.
    Format: "fieldName asc" or "fieldName desc"

.PARAMETER childConditions
    Filter results based on child record criteria.

.PARAMETER customFieldConditions
    Filter results based on custom field values.

.PARAMETER page
    The page number to retrieve (used with -pageSize for pagination).

.PARAMETER pageSize
    Number of records to return per page.

.PARAMETER fields
    Specify which fields to return in the response.

.PARAMETER pageId
    Starts forward-only pagination at the page identified by this value.

.PARAMETER all
    Retrieve all matching resources by automatically handling pagination.

.EXAMPLE
    Get-CWMServiceTemplateResource -parentId 15 -all

    Retrieves every resource of service template 15.

.EXAMPLE
    Get-CWMServiceTemplateResource -templateId 15 -resourceId 3

    Retrieves resource 3 of service template 15.

.NOTES
    Endpoints:
    - GET /service/templates/{parentId}/resources
    - GET /service/templates/{parentId}/resources/{id}
    - GET /service/templates/{parentId}/resources/count

    Based on PR #82 by mdewart-Centre.

.LINK
    Get-CWMServiceTemplate

.LINK
    New-CWMServiceTemplateResource

.LINK
    Set-CWMServiceTemplateResource

.LINK
    Update-CWMServiceTemplateResource

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject or PSCustomObject[]
    Returns service template resource objects, or an integer if -count is specified.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Get-CWMServiceTemplateResource {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$parentId,
        [Alias('resourceId')]
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [int]$pageId,
        [switch]$all
    )

    $Endpoint = "/service/templates/$($parentId)/resources"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
