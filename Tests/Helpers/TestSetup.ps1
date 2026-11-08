# Shared setup for the offline tests. Dot-source it from the file's top-level BeforeAll:
#     BeforeAll { . "$PSScriptRoot/Helpers/TestSetup.ps1" }
#     AfterAll { Remove-CWMTestSetup }
# It imports the module fresh and loads the local HTTP test server (CWMTestServer.ps1).

Import-Module "$PSScriptRoot/../../ConnectWiseManageAPI/ConnectWiseManageAPI.psd1" -Force
. "$PSScriptRoot/CWMTestServer.ps1"

# Every URL the module builds from Set-CWMTestConnection starts with this
$CWMTestBaseUri = 'https://example.invalid/v4_6_release/apis/3.0'

function Set-CWMTestConnection {
    # A fake connection, so the module builds URLs without contacting a server
    param([string]$Server = 'example.invalid')
    InModuleScope ConnectWiseManageAPI -Parameters @{ Server = $Server } {
        param($Server)
        $script:CWMServerConnection = @{
            Server   = $Server
            Codebase = 'v4_6_release'
            BasePath = 'apis/3.0'
            Headers  = @{ ClientID = 'test' }
        }
    }
}

function Set-CWMTestResponse {
    # Mocks Invoke-WebRequest inside the module to return $Content. Each request is recorded in
    # $global:CWMTestRequests (Uri, Method, Body, ContentType) for tests that inspect the body directly.
    param(
        [string]$Content = '{}',
        [int]$StatusCode = 200
    )
    $global:CWMTestResponse = [pscustomobject]@{ StatusCode = $StatusCode; Content = $Content; Headers = @{} }
    $global:CWMTestRequests = New-Object System.Collections.Generic.List[object]
    Mock Invoke-WebRequest -ModuleName ConnectWiseManageAPI {
        $global:CWMTestRequests.Add([pscustomobject]@{ Uri = $Uri; Method = $Method; Body = $Body; ContentType = $ContentType })
        $global:CWMTestResponse
    }
}

function Remove-CWMTestSetup {
    Remove-Variable -Name CWMTestResponse, CWMTestRequests -Scope Global -ErrorAction SilentlyContinue
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}
