function New-CWMCompanyConfigurationTypeQuestionValue {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [int] $configurationTypeId,
        [Parameter(Mandatory=$true)]
        [int]$questionId,
        [hashtable]$configurationType,
        [boolean]$defaultFlag,
        [int]$id,
        [boolean]$inactiveFlag,
        [hashtable]$question,
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,1000)]
        [string]$value,
        [hashtable]$_info
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/company/configurations/types/$configurationTypeId/questions/$questionId/values"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
