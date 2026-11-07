<#
.SYNOPSIS
    Disconnects from the ConnectWise Manage API and clears connection information.

.DESCRIPTION
    Clears the cached connection information stored by Connect-CWM.
    This removes the script-scoped $CWMServerConnection variable which contains
    authentication credentials and server details.

    Use this function to:
    - Explicitly end an API session
    - Clear credentials from memory for security
    - Switch between different ConnectWise Manage accounts or servers
    - Clean up before ending a script or session

    After calling Disconnect-CWM, you must call Connect-CWM again before making
    any API calls.

.EXAMPLE
    Disconnect-CWM

    Clears the current ConnectWise Manage connection and removes cached credentials.

.EXAMPLE
    # Disconnect and reconnect to different server
    Disconnect-CWM
    Connect-CWM -Server 'different.server.com' -Company 'OtherCompany' -PubKey $pubkey -PrivateKey $privatekey -ClientID $clientId

    Disconnects from current server and connects to a different one.

.EXAMPLE
    # Clean disconnect with verbose output
    Disconnect-CWM -Verbose

    Disconnects with verbose output showing the variable removal.

.EXAMPLE
    # Script cleanup pattern
    try {
        Connect-CWM @ConnectionParams
        # ... perform API operations ...
    }
    finally {
        Disconnect-CWM
        Write-Host "Cleanup complete"
    }

    Ensures connection is cleaned up even if script encounters errors.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Best Practices:
    - Call Disconnect-CWM at the end of scripts to clean up credentials
    - Use in try/finally blocks to ensure cleanup happens
    - Not strictly necessary if PowerShell session is ending
    - Good practice for long-running sessions or credential rotation

    Security Considerations:
    - Removes credentials from memory
    - Prevents accidental credential reuse
    - Required when switching between accounts

.LINK
    https://developer.connectwise.com/manage/rest

.LINK
    Connect-CWM

.OUTPUTS
    None. Removes the script-scoped variable $CWMServerConnection.

.INPUTS
    None. This function does not accept parameters or pipeline input.

#>
function Disconnect-CWM {
    [CmdletBinding()]
    param()
    try {
        $null = Remove-Variable -Name CWMServerConnection -Scope script -Force -Confirm:$false -ErrorAction Stop
        if ($CWMServerConnection -or $script:CWMServerConnection) {
            Write-Error 'There was an error clearing connection information.'
        }
        else {
            Write-Verbose '$CWMServerConnection, variable removed.'
        }
    }
    catch {
        Write-Error "There was an error clearing connection information.`n$($_)"
    }
}