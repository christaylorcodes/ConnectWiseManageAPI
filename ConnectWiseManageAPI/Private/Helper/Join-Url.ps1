function Join-Url {
    param (
        [parameter(Mandatory = $True)]
        [string] $Path,
        [parameter(Mandatory = $True)]
        [string] $ChildPath
    )
    "$($Path.TrimEnd('/'))/$($ChildPath.TrimStart('/'))"
}