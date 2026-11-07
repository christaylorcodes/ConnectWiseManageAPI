<#
.SYNOPSIS
    Gets the charge codes.

.DESCRIPTION
    Returns the rows of the ChargeCode report. Calls Get-CWMReport, which calls GET
    /system/reports/ChargeCode.

.EXAMPLE
    Get-CWMChargeCode

    Returns every charge code as an object.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMChargeCode{
    [CmdletBinding()]
    param()

    $Report = 'ChargeCode'
    Get-CWMReport -Report $Report
}