<#
.SYNOPSIS
    Adds an allowed value to a question on a configuration TYPE.

.DESCRIPTION
    Creates a new predefined value (for example a dropdown option) on a question of a
    configuration type. This changes the configuration type's definition, so the new option is
    offered on every configuration of that type.

    This function does NOT answer a question on a specific configuration. To set a
    configuration's answer, use Update-CWMCompanyConfiguration and replace its 'questions'
    (see the examples).

    The IDs map onto the URL like this:
    /company/configurations/types/{grandparentId}/questions/{parentId}/values

    This function calls the ConnectWise Manage API endpoint:
    POST /company/configurations/types/{typeId}/questions/{questionId}/values

.PARAMETER grandparentId
    The ID of the configuration TYPE that owns the question (alias: typeId).
    This is not a configuration ID.

.PARAMETER parentId
    The ID of the question on that configuration type (alias: questionId).

.PARAMETER id
    The ID of the value record. Normally left out; the server assigns it.

.PARAMETER configurationType
    Reference to the configuration type. Format: @{ id = 12 }

.PARAMETER defaultFlag
    Whether this value is the question's default.

.PARAMETER inactiveFlag
    Whether this value is inactive.

.PARAMETER question
    Reference to the question. Format: @{ id = 431 }

.PARAMETER value
    The text of the allowed value (1-1000 characters).

.PARAMETER _info
    Metadata hashtable passed through to the API as-is.

.EXAMPLE
    New-CWMCompanyConfigurationTypeQuestionValue -typeId 12 -questionId 431 -value 'Windows Server 2025'

    Adds 'Windows Server 2025' as a new option for question 431 on configuration type 12.

.EXAMPLE
    Update-CWMCompanyConfiguration -id 5501 -Operation replace -Path questions -Value @(@{ questionId = 431; answer = 'Windows Server 2025' })

    The correct way to set the answer to question 431 on configuration 5501. Use this, not
    New-CWMCompanyConfigurationTypeQuestionValue, to fill in a configuration's answers.

.LINK
    Update-CWMCompanyConfigurationTypeQuestionValue

.LINK
    Update-CWMCompanyConfiguration

.LINK
    https://developer.connectwise.com/Products/ConnectWise_PSA/REST
#>
function New-CWMCompanyConfigurationTypeQuestionValue {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('typeId')]
        [int]$grandparentId,
        [Parameter(Mandatory=$true)]
        [Alias('questionId')]
        [int]$parentId,
        [int]$id,
        [hashtable]$configurationType,
        [boolean]$defaultFlag,
        [boolean]$inactiveFlag,
        [hashtable]$question,
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,1000)]
        [string]$value,
        [hashtable]$_info
    )

    $Endpoint = "/company/configurations/types/$($grandparentId)/questions/$($parentId)/values"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
