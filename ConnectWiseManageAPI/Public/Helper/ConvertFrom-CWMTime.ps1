function ConvertFrom-CWMTime {
    [CmdletBinding()]
    param(
        [string]$Date
    )
    Get-Date $Date.Trim('[]')
}