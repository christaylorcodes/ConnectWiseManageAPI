function ConvertTo-CWMTime {
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [datetime[]]$Date,
        [switch]$Raw
    )
    begin { $Collection = @() }
    process {
        foreach ($D in $Date) {
            $Converted = "[$(Get-Date $D.ToUniversalTime() -format yyyy-MM-ddTHH:mm:ssZ)]"
            if($Raw){ $Collection += $Converted.Trim('[]') }
            else { $Collection += $Converted }
        }
    }
    end { return $Collection }
}