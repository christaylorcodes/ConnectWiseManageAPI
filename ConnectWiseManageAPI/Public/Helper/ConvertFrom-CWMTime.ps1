<#
.SYNOPSIS
    Converts a ConnectWise Manage date string to a DateTime.

.DESCRIPTION
    Converts a date string as used by ConnectWise Manage, with or without the square brackets used in
    conditions, to a [datetime]. No API call is made.

.PARAMETER Date
    The date string to convert, in the format yyyy-MM-ddTHH:mm:ssZ, with or without square brackets.

.EXAMPLE
    ConvertFrom-CWMTime -Date (Get-CWMTicket -id 1234).dateEntered

    Converts the dateEntered value of ticket 1234 to a [datetime].

.LINK
    https://developer.connectwise.com/manage/rest
#>
function ConvertFrom-CWMTime {
    [CmdletBinding()]
    param(
        [string]$Date
    )
    Get-Date $Date.Trim('[]')
}