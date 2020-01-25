function Get-CWMChargeCode{
    [CmdletBinding()]
    param()

    $Report = 'ChargeCode'
    $Result = Get-CWMReport -Report $Report
    return $Result
}