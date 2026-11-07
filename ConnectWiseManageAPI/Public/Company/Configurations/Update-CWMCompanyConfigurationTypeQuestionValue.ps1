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
    The new value for the property named in -Path.

.EXAMPLE
    Update-CWMCompanyConfigurationTypeQuestionValue -typeId 12 -questionId 431 -valueId 3 -Operation replace -Path value -Value 'Windows Server 2022'

    Renames dropdown option 3 of question 431 on configuration type 12. Every configuration
    of type 12 will offer the new text.

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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('typeId')]
        [int]$grandparentId,
        [Parameter(Mandatory = $true)]
        [Alias('questionId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('valueId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    $Endpoint = "/company/configurations/types/$($grandparentId)/questions/$($parentId)/values/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
