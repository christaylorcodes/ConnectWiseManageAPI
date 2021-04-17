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
