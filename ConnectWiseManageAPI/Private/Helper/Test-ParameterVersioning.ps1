function Test-ParameterVersioning {
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory = $true)]
        [switch]$VersionAutomatic,
        [Parameter(Mandatory = $true)]
        [string]$ParameterSetName,
        [Parameter(Mandatory = $true)]
        [string]$DefaultParameterSetName,
        [string]$Version
    )
    if ($VersionAutomatic -or $ParameterSetName -ne $DefaultParameterSetName) { $ParameterSetName }
    elseif ($Version) {
        if ($Version -ne $ParameterSetName) { Write-Warning "You might be using the wrong version, $($ParameterSetName) was detected and $Version was passed." }
        $Version
    }
}
