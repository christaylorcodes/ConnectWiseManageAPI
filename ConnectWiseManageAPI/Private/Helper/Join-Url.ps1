function Join-Url {
    param (
        [parameter(Mandatory=$True)]
        [string] $Path,
        [parameter(Mandatory=$True)]
        [string] $ChildPath
    )
    return "$($Path.TrimEnd('/'))/$($ChildPath.TrimStart('/'))"
}