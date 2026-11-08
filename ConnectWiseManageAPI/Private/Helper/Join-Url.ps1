<#
.SYNOPSIS
    Joins two URL segments.

.DESCRIPTION
    Joins two URL segments with exactly one slash between them: trailing slashes of -Path and leading
    slashes of -ChildPath are removed first. Internal helper; no API call is made.

.PARAMETER Path
    Root URL path to join to.

.PARAMETER ChildPath
    The segment to append to -Path.

.EXAMPLE
    Join-Url 'https://na.myconnectwise.net/' '/v4_6_release'

    Returns https://na.myconnectwise.net/v4_6_release.
#>
function Join-Url {
    param (
        [parameter(Mandatory = $True)]
        [string] $Path,
        [parameter(Mandatory = $True)]
        [string] $ChildPath
    )
    "$($Path.TrimEnd('/'))/$($ChildPath.TrimStart('/'))"
}