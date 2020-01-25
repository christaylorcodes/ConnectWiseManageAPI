function ConvertTo-CWMTime {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [datetime]$Date,
        [switch]$Raw
    )
    $Converted = "[$(Get-Date $Date.ToUniversalTime() -format yyyy-MM-ddTHH:mm:ssZ)]"
    if($Raw){
        $Converted = $Converted.Trim('[]')
    }
    return $Converted
}
