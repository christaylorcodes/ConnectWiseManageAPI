function ConvertTo-CWMPatchValue {
    # Prepares a JSON Patch 'value' for ConvertTo-Json (used by Invoke-CWMUpdateMaster).
    # Windows PowerShell 5.1 serializes a PSObject-wrapped array (e.g. one returned from a function) as
    # {"value":[..],"Count":n}, so such a value is unwrapped to its base object.
    # A PSCustomObject (e.g. $Ticket.board from a Get-CWM* result) is NOT unwrapped: its base object is an
    # empty PSCustomObject placeholder, so unwrapping would send {} and lose every property.
    # Arrays of PSCustomObjects keep their elements as they are.
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [AllowNull()]
        $Value
    )

    if ($null -eq $Value) { return $null }
    # Dates are sent as ISO 8601 UTC strings, the same on both editions (see ConvertTo-CWMBodyDate)
    if (Test-CWMBodyDate $Value) { $Value = ConvertTo-CWMBodyDate $Value }
    $BaseObject = $Value.psobject.BaseObject
    if ($BaseObject -is [System.Management.Automation.PSCustomObject]) { return $Value }
    # The unary comma keeps an array (also with one element) from being unrolled
    , $BaseObject
}
