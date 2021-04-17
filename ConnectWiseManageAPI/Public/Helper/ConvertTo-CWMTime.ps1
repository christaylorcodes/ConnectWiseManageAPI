function ConvertTo-CWMTime {
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [datetime[]]$Date,
        [switch]$Raw
    )
    begin {}
    process {
        foreach ($D in $Date) {
            $Converted = "[$(Get-Date $D.ToUniversalTime() -format yyyy-MM-ddTHH:mm:ssZ)]"
            if($Raw){ $Converted.Trim('[]') }
            else { $Converted }
        }
    }
    end {}
}
