<#
.SYNOPSIS
    Brief one-line description of what the function does.

.DESCRIPTION
    Detailed description of the function including:
    - What the function does and its purpose
    - When to use this function vs alternatives
    - How it interacts with the ConnectWise Manage API
    - Any important limitations, requirements, or prerequisites
    - Common use cases or scenarios

    This function calls the ConnectWise Manage API endpoint: [endpoint path here]

.PARAMETER ParameterName
    Description of the parameter including:
    - What it does and how it's used
    - Valid values, format, or acceptable range
    - Whether it's required or optional
    - Default behavior if not specified
    - Examples of valid input

.PARAMETER id
    The unique identifier for the [resource type].
    Must be a positive integer.
    Use this to retrieve, update, or delete a specific [resource].

.PARAMETER condition
    Filter results using ConnectWise Manage condition syntax.
    Format: "field operator value"
    Operators: =, !=, <, >, <=, >=, contains, like, in
    Multiple conditions can be combined with 'and' or 'or'
    Example: "status/name='Open' and priority/id>=3"

.PARAMETER orderBy
    Sort results by specified field.
    Format: "fieldName asc" or "fieldName desc"
    Example: "id desc" or "dateEntered asc"

.PARAMETER childConditions
    Filter results based on child record criteria.
    Uses same condition syntax as -condition parameter.
    Example: "contact/id=123"

.PARAMETER customFieldConditions
    Filter results based on custom field values.
    Format: "caption='FieldName' and value='FieldValue'"
    Example: "caption='Department' and value='IT'"

.PARAMETER page
    The page number to retrieve (used with -pageSize for pagination).
    Default: 1
    Use with -pageSize to control pagination manually.

.PARAMETER pageSize
    Number of records to return per page.
    Default: [API default, typically 25 or 50]
    Maximum: [API maximum, typically 1000]
    Use with -page to control pagination manually.

.PARAMETER all
    Retrieve all records by automatically handling pagination.
    When specified, the function will make multiple API calls if necessary
    to retrieve all matching records, bypassing page and pageSize parameters.
    Use with caution on large datasets.

.PARAMETER count
    Return only the count of matching records instead of the records themselves.
    Returns an integer representing the total number of records that match the query.
    Useful for checking result set size before retrieving full data.

.PARAMETER fields
    Specify which fields to return in the response.
    Accepts an array of field names.
    Reduces response size and improves performance by only returning needed fields.
    Example: @('id', 'name', 'status')

.PARAMETER Operation
    (Update-CWM* functions) The patch operation for a single change: 'add', 'replace', or 'remove'.
    Used with -Path and -Value. Example: -Operation replace -Path summary -Value 'New summary'

.PARAMETER Path
    (Update-CWM* functions) The field path to modify, for example 'summary' or 'status'.
    Use slash notation for nested fields: 'customFields/0/value'

.PARAMETER Value
    (Update-CWM* functions) The new value. Required (it may be $null) for 'add' and 'replace';
    not needed for 'remove'.

.PARAMETER PatchOperations
    (Update-CWM* functions) Several patch operations applied in one request, instead of
    -Operation/-Path/-Value. Each is a hashtable with op, path and (except for 'remove') value.

    Example:
    -PatchOperations @(
        @{ op = 'replace'; path = 'status'; value = @{ id = 123 } }
        @{ op = 'replace'; path = 'summary'; value = 'Updated summary' }
    )

.EXAMPLE
    Command-Example

    Description of what this example does, expected output, and any important notes.
    Include context about when this pattern would be useful.

.EXAMPLE
    Another-Example -WithParameters

    Description of this more complex example.
    Explain the parameters used and why.
    Show expected results.

.EXAMPLE
    # Complex example with multiple parameters
    Command-Example -Param1 'Value1' `
                    -Param2 'Value2' `
                    -Param3 @{ key = 'value' }

    Multi-line example showing advanced usage.
    Explain each parameter's role in this scenario.

.EXAMPLE
    # Pipeline example
    Get-Something | Command-Example

    Example showing pipeline usage.
    Explain how pipeline input is processed.

.EXAMPLE
    # Filtering and pagination
    Command-Example -condition "status/name='Open'" -orderBy "id desc" -all

    Example showing filtering and automatic pagination.
    Explain the condition syntax and sorting behavior.

.NOTES
    Author: Chris Taylor

    Additional notes:
    - Performance considerations
    - Related functions or alternatives
    - Common pitfalls or gotchas
    - API version requirements
    - Special permissions required

.LINK
    https://developer.connectwise.com/manage/rest

.LINK
    https://github.com/christaylorcodes/ConnectWiseManageAPI

.LINK
    Get-RelatedFunction

.LINK
    New-RelatedFunction

.OUTPUTS
    [TypeName]
    Description of what the function returns.
    Include object structure or properties if complex.

.INPUTS
    [TypeName]
    Description of what can be piped to this function.
    Include expected properties if accepting pipeline input.

#>
function Verb-CWMNoun {
    # Get-CWM* stub. New-/Update-/Remove-CWM* functions add SupportsShouldProcess and
    # call Invoke-CWMNewMaster / Invoke-CWMUpdateMaster / Invoke-CWMRemoveMaster instead.
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [int]$id,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$condition,

        [Parameter()]
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,

        [Parameter()]
        [string]$childConditions,

        [Parameter()]
        [string]$customFieldConditions,

        [Parameter()]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$page,

        [Parameter()]
        [ValidateRange(1, 1000)]
        [int]$pageSize,

        [Parameter()]
        [string[]]$fields,

        [Parameter()]
        [switch]$all,

        [Parameter()]
        [switch]$count
    )

    begin {
        # Initialize and validate
        # Check connection state
        # Set up any needed variables
    }

    process {
        # Main function logic
        # API endpoint construction
        # Parameter handling

        $Endpoint = '/api/endpoint/path'

        # Call appropriate master function
        Invoke-CWMGetMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
    }

    end {
        # Cleanup if needed
    }
}
