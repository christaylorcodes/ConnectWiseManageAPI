<#
.SYNOPSIS
    Retrieves service templates from ConnectWise Manage.

.DESCRIPTION
    Gets service ticket templates from ConnectWise Manage.
    Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

    This function calls the ConnectWise Manage API endpoint: GET /service/templates

.PARAMETER id
    The unique identifier of a specific service template.
    When specified, returns only that template (GET /service/templates/{id}).
    Alias: templateId

.PARAMETER count
    Returns only the count of matching templates (GET /service/templates/count).

.PARAMETER condition
    Filter templates using ConnectWise Manage condition syntax.
    Format: "field operator value"
    Example: "name contains 'Onboarding'"

.PARAMETER orderBy
    Sort results by specified field and direction.
    Format: "fieldName asc" or "fieldName desc"
    Example: "name asc"

.PARAMETER childConditions
    Filter results based on child record criteria.
    Uses same condition syntax as -condition parameter.

.PARAMETER customFieldConditions
    Filter results based on custom field values.
    Format: "caption='FieldName' and value='FieldValue'"

.PARAMETER page
    The page number to retrieve (used with -pageSize for pagination).

.PARAMETER pageSize
    Number of records to return per page.

.PARAMETER fields
    Specify which fields to return in the response.
    Example: @('id', 'name')

.PARAMETER all
    Retrieve all matching templates by automatically handling pagination.

.EXAMPLE
    Get-CWMServiceTemplate -all

    Retrieves every service template.

.EXAMPLE
    Get-CWMServiceTemplate -id 15

    Retrieves service template 15.

.EXAMPLE
    Get-CWMServiceTemplate -condition "name contains 'Onboarding'" -fields @('id', 'name')

    Retrieves the ID and name of templates whose name contains 'Onboarding'.

.NOTES
    Endpoints:
    - GET /service/templates
    - GET /service/templates/{id}
    - GET /service/templates/count

    Originally proposed by jadamwilson in PR #77

.LINK
    https://developer.connectwise.com/manage/rest#/ServiceTemplates

.OUTPUTS
    PSCustomObject or PSCustomObject[]
    Returns service template objects, or an integer if -count is specified.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Get-CWMServiceTemplate {
    [CmdletBinding()]
    param(
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
        [switch]$all
    )

    $Endpoint = '/service/templates'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
