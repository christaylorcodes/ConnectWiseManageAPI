<#
.SYNOPSIS
    Updates an allowed value of a question on a configuration TYPE.

.DESCRIPTION
    Edits one of the predefined values (for example a dropdown option) that a question on a
    configuration type offers. This changes the configuration type's definition, so it affects
    every configuration of that type.

    This function does NOT set the answer to a question on a specific configuration. Passing a
    configuration ID or an answer ID as -id results in a 404, because those IDs do not exist
    under this endpoint. To set a configuration's answer, use Update-CWMCompanyConfiguration
    and replace its 'questions' (see the examples).

    The IDs map onto the URL like this:
    /company/configurations/types/{grandparentId}/questions/{parentId}/values/{id}

    This function calls the ConnectWise Manage API endpoint:
    PATCH /company/configurations/types/{typeId}/questions/{questionId}/values/{valueId}

.PARAMETER grandparentId
    The ID of the configuration TYPE that owns the question (alias: typeId).
    This is not a configuration ID.

.PARAMETER parentId
    The ID of the question on that configuration type (alias: questionId).

.PARAMETER id
    The ID of the allowed value to update (alias: valueId). This is the id of an entry
    returned by GET /company/configurations/types/{typeId}/questions/{questionId}/values.
    It is not a configuration ID or an answer ID.

.PARAMETER Operation
    The patch operation: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property of the value to change, for example 'value', 'defaultFlag' or 'inactiveFlag'.

.PARAMETER Value
    The new value for the property named in -Path. Required for 'add' and 'replace'; not needed
    for 'remove'. Use -Value $null to set the property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMCompanyConfigurationTypeQuestionValue -typeId 12 -questionId 431 -valueId 3 -Operation replace -Path value -Value 'Windows Server 2022'

    Renames dropdown option 3 of question 431 on configuration type 12. Every configuration
    of type 12 will offer the new text.

.EXAMPLE
    Update-CWMCompanyConfigurationTypeQuestionValue -typeId 12 -questionId 431 -valueId 3 -PatchOperations @(
        @{ op = 'replace'; path = 'value'; value = 'Windows Server 2022' }
        @{ op = 'replace'; path = 'defaultFlag'; value = $true }
    )

    Renames dropdown option 3 and makes it the default option, in one request.

.EXAMPLE
    Update-CWMCompanyConfiguration -id 5501 -Operation replace -Path questions -Value @(@{ questionId = 431; answer = 'contoso.onmicrosoft.com' })

    The correct way to set the answer to question 431 on configuration 5501. Use this, not
    Update-CWMCompanyConfigurationTypeQuestionValue, to fill in a configuration's answers.

.LINK
    New-CWMCompanyConfigurationTypeQuestionValue

.LINK
    Update-CWMCompanyConfiguration

.LINK
    https://developer.connectwise.com/Products/ConnectWise_PSA/REST
#>
function Update-CWMCompanyConfigurationTypeQuestionValue {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('typeId')]
        [int]$grandparentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('questionId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 2)]
        [Alias('valueId')]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 4, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 5, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/company/configurations/types/$($grandparentId)/questions/$($parentId)/values/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
