function Get-CWMChargeCode{
    [CmdletBinding()]
    param()

    $Report = 'ChargeCode'
    Get-CWMReport -Report $Report
}