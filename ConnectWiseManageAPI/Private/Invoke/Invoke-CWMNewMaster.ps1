function Invoke-CWMNewMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $Arguments,
        [string]$Endpoint,
        [string[]]$Skip
    )
    # Skip common parameters
    $Skip += 'Debug','ErrorAction','ErrorVariable','InformationAction','InformationVariable','OutVariable','OutBuffer','PipelineVariable','Verbose','WarningAction','WarningVariable','WhatIf','Confirm','Version','VersionAutomatic','grandparentId','parentId'

    if ($Arguments.Body) {
        $Body = $Arguments.Body
    } else {
        $Body = @{}
        foreach($i in $Arguments.GetEnumerator()){
            if($Skip -notcontains $i.Key){
                $Body.Add($i.Key, $i.value)
            }
        }
        $Body = ConvertTo-Json $Body -Depth 100
    }
    Write-Verbose $Body

    $ContentType = 'application/json'
    if ($Arguments.ContentType) {
        $ContentType = $Arguments.ContentType
    }

    $URI = New-CWMUrl -Endpoint $Endpoint
    $WebRequestArguments = @{
        Uri = $URI
        Method = 'Post'
        ContentType = $ContentType
        Body = $Body
        Version = $Arguments.Version
    }
    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMNewMaster, with body:`r`n$Body`r`n")) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if($Result.content){
            $Result = $Result.content | ConvertFrom-Json
        }
    }

    $Result
}
