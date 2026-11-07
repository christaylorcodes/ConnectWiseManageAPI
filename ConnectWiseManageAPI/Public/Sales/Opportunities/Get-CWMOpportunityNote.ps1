<#
.SYNOPSIS
    Retrieves the notes on a sales opportunity in ConnectWise Manage.

.DESCRIPTION
    Gets the notes attached to a sales opportunity.
    Supports direct note ID lookup, filtering, sorting, pagination, field selection and counts.

    This function calls the ConnectWise Manage API endpoint: GET /sales/opportunities/{parentId}/notes

.PARAMETER parentId
    The ID of the opportunity whose notes to retrieve (required).
    Alias: opportunityId

.PARAMETER id
    The ID of a specific note on the opportunity.
    When specified, returns only that note (GET /sales/opportunities/{parentId}/notes/{id}).
    Alias: noteId

.PARAMETER count
    Returns only the count of matching notes (GET /sales/opportunities/{parentId}/notes/count).

.PARAMETER condition
    Filter notes using ConnectWise Manage condition syntax.
    Format: "field operator value"
    Example: "text contains 'pricing'"

.PARAMETER orderBy
    Sort results by specified field and direction.
    Format: "fieldName asc" or "fieldName desc"
    Example: "id desc"

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
    Example: @('id', 'text')

.PARAMETER all
    Retrieve all matching notes by automatically handling pagination.

.EXAMPLE
    Get-CWMOpportunityNote -parentId 500 -all

    Retrieves every note on opportunity 500.

.EXAMPLE
    Get-CWMOpportunityNote -opportunityId 500 -condition "text contains 'pricing'"

    Retrieves notes on opportunity 500 that mention pricing.

.EXAMPLE
    Get-CWMOpportunityNote -parentId 500 -id 12

    Retrieves note 12 on opportunity 500.

.NOTES
    Endpoints:
    - GET /sales/opportunities/{parentId}/notes
    - GET /sales/opportunities/{parentId}/notes/{id}
    - GET /sales/opportunities/{parentId}/notes/count

    Originally proposed by jadamwilson in PR #77

.LINK
    Get-CWMOpportunity

.LINK
    https://developer.connectwise.com/manage/rest#/OpportunityNotes

.OUTPUTS
    PSCustomObject or PSCustomObject[]
    Returns opportunity note objects, or an integer if -count is specified.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Get-CWMOpportunityNote {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('opportunityId')]
        [int]$parentId,
        [Alias('noteId')]
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

    $Endpoint = "/sales/opportunities/$($parentId)/notes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
