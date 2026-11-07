<#
.SYNOPSIS
    Retrieves invoices from ConnectWise Manage.

.DESCRIPTION
    Gets finance invoices from ConnectWise Manage.
    Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

    This function calls the ConnectWise Manage API endpoint: GET /finance/invoices

.PARAMETER id
    The unique identifier of a specific invoice.
    When specified, returns only that invoice (GET /finance/invoices/{id}).
    Alias: invoiceId

.PARAMETER count
    Returns only the count of matching invoices (GET /finance/invoices/count).

.PARAMETER condition
    Filter invoices using ConnectWise Manage condition syntax.
    Format: "field operator value"
    Operators: =, !=, <, >, <=, >=, contains, like, in
    Multiple conditions can be combined with 'and' or 'or'
    Example: "company/id=250"

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
    Example: @('id', 'invoiceNumber', 'company', 'total')

.PARAMETER all
    Retrieve all matching invoices by automatically handling pagination.
    Makes multiple API calls if necessary. Use with caution on large datasets.

.EXAMPLE
    Get-CWMInvoice -id 1001

    Retrieves invoice 1001.

.EXAMPLE
    Get-CWMInvoice -condition "company/id=250" -orderBy "id desc" -all

    Retrieves every invoice for company 250, newest first.

.EXAMPLE
    Get-CWMInvoice -condition "company/id=250" -count

    Returns the number of invoices for company 250.

.NOTES
    Endpoints:
    - GET /finance/invoices
    - GET /finance/invoices/{id}
    - GET /finance/invoices/count

    Originally proposed by jadamwilson in PR #77

.LINK
    https://developer.connectwise.com/manage/rest#/Invoices

.OUTPUTS
    PSCustomObject or PSCustomObject[]
    Returns invoice objects, or an integer if -count is specified.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Get-CWMInvoice {
    [CmdletBinding()]
    param(
        [Alias('invoiceId')]
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

    $Endpoint = '/finance/invoices'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
