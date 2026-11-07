<#
.SYNOPSIS
    Disconnects from the ConnectWise Manage API and clears connection information.

.DESCRIPTION
    Clears the cached connection information stored by Connect-CWM.
    This removes every connection-related script-scoped variable:
    - $CWMServerConnection - server details, authentication headers and credentials
    - $CWMSession          - the web session (and its cookies, including the member hash)
                             created by cookie authentication (Connect-CWM -Credentials)

    Module feature flags detected at import time (for example $CWMSupportsInsecureRedirect)
    are not connection data and are left in place.

    Use this function to:
    - Explicitly end an API session
    - Clear credentials and session cookies from memory for security
    - Switch between different ConnectWise Manage accounts or servers
    - Clean up before ending a script or session

    Calling Disconnect-CWM when nothing is connected is a quiet no-op: it writes a
    verbose message and no error, so it is safe to call more than once (for example
    in a finally block).

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

    Disconnects with verbose output naming each variable removed, or noting that
    there was no connection to clear.

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

    Ensures connection is cleaned up even if script encounters errors. Because
    Disconnect-CWM does not error when nothing is connected, this is safe even if
    Connect-CWM itself failed.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Best Practices:
    - Call Disconnect-CWM at the end of scripts to clean up credentials
    - Use in try/finally blocks to ensure cleanup happens
    - Not strictly necessary if PowerShell session is ending
    - Good practice for long-running sessions or credential rotation

    Security Considerations:
    - Removes credentials and cookie-session data (member hash) from memory
    - Prevents accidental credential reuse
    - Required when switching between accounts

.LINK
    https://developer.connectwise.com/manage/rest

.LINK
    Connect-CWM

.OUTPUTS
    None. Removes the script-scoped variables $CWMServerConnection and $CWMSession.

.INPUTS
    None. This function does not accept parameters or pipeline input.

#>
function Disconnect-CWM {
    [CmdletBinding()]
    param()

    # Every script-scoped variable Connect-CWM sets that holds connection or credential data
    $ConnectionVariables = 'CWMServerConnection', 'CWMSession'

    # Listing the scope (rather than Get-Variable -Name) records no "not found" errors in -ErrorVariable
    $Existing = @(Get-Variable -Scope Script | Where-Object { $ConnectionVariables -contains $_.Name })

    foreach ($Variable in $Existing) {
        try {
            Remove-Variable -Name $Variable.Name -Scope Script -Force -ErrorAction Stop
            Write-Verbose "`$$($Variable.Name), variable removed."
        }
        catch {
            Write-Error "There was an error clearing connection information ($($Variable.Name)).`n$($_)"
        }
    }

    if ($Existing.Count -eq 0) {
        Write-Verbose 'No ConnectWise Manage connection to clear.'
    }
}
