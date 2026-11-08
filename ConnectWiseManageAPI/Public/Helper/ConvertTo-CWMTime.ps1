<#
.SYNOPSIS
    Converts a DateTime to the date format ConnectWise Manage uses.

.DESCRIPTION
    Converts one or more [datetime] values to UTC and formats them as yyyy-MM-ddTHH:mm:ssZ in square
    brackets, the format used in condition strings. With -Raw the brackets are left out, the format used in
    request bodies. No API call is made.

.PARAMETER Date
    One or more dates to convert. Accepts pipeline input.

.PARAMETER Raw
    Return the date without the surrounding square brackets.

.EXAMPLE
    Get-CWMTicket -condition "dateEntered > $(ConvertTo-CWMTime (Get-Date).AddDays(-7))" -all

    Retrieves the tickets entered in the last seven days.

.EXAMPLE
    New-CWMTimeEntry -chargeToType 'ServiceTicket' -chargeToId 1234 -timeStart (ConvertTo-CWMTime (Get-Date).AddHours(-1) -Raw)

    Uses -Raw to send a date in a request body.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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
            $Converted = "[$($D.ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ', [cultureinfo]::InvariantCulture))]"
            if($Raw){ $Converted.Trim('[]') }
            else { $Converted }
        }
    }
    end {}
}
