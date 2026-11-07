<#
.SYNOPSIS
    Retrieves the service templates of a company in ConnectWise Manage.

.DESCRIPTION
    Gets the service (ticket) templates attached to a company.
    Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

    For the system-wide service templates, use Get-CWMServiceTemplate (GET /service/templates).

    This function calls the ConnectWise Manage API endpoint: GET /company/companies/{parentId}/serviceTemplates

.PARAMETER parentId
    The ID of the company (required).
    Alias: companyId

.PARAMETER id
    The ID of a specific company service template.
    When specified, returns only that template.
    Alias: templateId

.PARAMETER count
    Returns only the count of matching templates.

.PARAMETER condition
    Filter templates using ConnectWise Manage condition syntax.
    Example: "name contains 'Maintenance'"

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
    Example: @('id', 'name')

.PARAMETER pageId
    Starts forward-only pagination at the page identified by this value.

.PARAMETER all
    Retrieve all matching templates by automatically handling pagination.

.EXAMPLE
    Get-CWMCompanyServiceTemplate -parentId 250 -all

    Retrieves every service template of company 250.

.EXAMPLE
    Get-CWMCompanyServiceTemplate -companyId 250 -templateId 15

    Retrieves service template 15 of company 250.

.NOTES
    Endpoints:
    - GET /company/companies/{parentId}/serviceTemplates
    - GET /company/companies/{parentId}/serviceTemplates/{id}
    - GET /company/companies/{parentId}/serviceTemplates/count

    Based on PR #82 by mdewart-Centre.

.LINK
    New-CWMCompanyServiceTemplate

.LINK
    Set-CWMCompanyServiceTemplate

.LINK
    Update-CWMCompanyServiceTemplate

.LINK
    Remove-CWMCompanyServiceTemplate

.LINK
    Get-CWMServiceTemplate

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject or PSCustomObject[]
    Returns company service template objects, or an integer if -count is specified.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Get-CWMCompanyServiceTemplate {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Alias('templateId')]
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

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
