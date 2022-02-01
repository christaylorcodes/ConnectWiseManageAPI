function Update-CWMProjectPhase {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('projectId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('phaseId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    $Endpoint = "/project/projects/$($parentId)/phases/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
