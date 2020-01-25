function ConvertFrom-CWMTime {
    [CmdletBinding()]
    param(
    [string]$Date
    )
    return Get-Date $Date.Trim('[',']')
}