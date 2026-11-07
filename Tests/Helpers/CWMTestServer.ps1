# Local HTTP server for offline tests. Uses System.Net.HttpListener on http://localhost:<free port>/,
# so Invoke-WebRequest raises the real edition-specific exceptions (WebException on 5.1,
# HttpResponseException on 7). No ConnectWise server or network access is needed.

function Start-CWMTestServer {
    $TcpListener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, 0)
    $TcpListener.Start()
    $Port = $TcpListener.LocalEndpoint.Port
    $TcpListener.Stop()

    $Listener = [System.Net.HttpListener]::new()
    $Listener.Prefixes.Add("http://localhost:$Port/")
    $Listener.Start()

    # Per-path request counts and the last request body/content type, shared with the server runspace
    $State = [hashtable]::Synchronized(@{ Counts = [hashtable]::Synchronized(@{}); Port = $Port })

    $PowerShell = [powershell]::Create()
    $null = $PowerShell.AddScript({
            param($Listener, $State)
            $Utf8 = New-Object System.Text.UTF8Encoding($false)
            while ($Listener.IsListening) {
                try { $Context = $Listener.GetContext() } catch { break }
                $Request = $Context.Request
                $Response = $Context.Response
                $Path = $Request.Url.AbsolutePath
                $State.Counts[$Path] = 1 + [int]$State.Counts[$Path]
                $Count = $State.Counts[$Path]

                $Reader = New-Object System.IO.BinaryReader($Request.InputStream)
                $BodyBytes = $Reader.ReadBytes(1MB)
                $State.LastBodyHex = ($BodyBytes | ForEach-Object { $_.ToString('X2') }) -join ' '
                $State.LastContentType = $Request.ContentType

                $Status = 200
                $Body = '{}'
                switch ($Path) {
                    '/error400' { $Status = 400; $Body = '{"code":"InvalidObject","message":"Ticket object is invalid","errors":[{"code":"NullOrEmpty","message":"summary is required","resource":"ticket","field":"summary"}]}' }
                    '/unauthorized' { $Status = 401; $Body = '{"code":"Unauthorized","message":"Invalid credentials"}' }
                    '/html500' { $Status = 500; $Body = '<html>proxy error</html>' }
                    '/always503' { $Status = 503; $Body = '{"code":"ServiceUnavailable","message":"down"}' }
                    '/always500' { $Status = 500; $Body = '{"code":"InternalError","message":"boom"}' }
                    { $_ -eq '/flaky' -or $_ -eq '/flakysearch' } {
                        if ($Count -eq 1) { $Status = 503; $Body = '{"code":"ServiceUnavailable","message":"try again"}' }
                        else { $Body = '[{"id":1}]' }
                    }
                    '/throttled' {
                        if ($Count -eq 1) { $Status = 429; $Response.AddHeader('Retry-After', '1'); $Body = '{"code":"TooManyRequests","message":"slow down"}' }
                        else { $Body = '{"id":7}' }
                    }
                    '/array' { $Body = '[{"id":1},{"id":2}]' }
                    '/single' { $Body = '[{"id":1}]' }
                    '/object' { $Body = '{"id":1,"name":"x"}' }
                    '/empty' { $Body = '[]' }
                    '/page1' {
                        $Response.AddHeader('Link', "<http://localhost:$($State.Port)/page2>; rel=`"next`"")
                        $Body = '[{"id":1},{"id":2}]'
                    }
                    '/page2' { $Response.AddHeader('Link', ''); $Body = '[{"id":3}]' }
                    '/redirect' { $Status = 302; $Response.AddHeader('Location', 'http://elsewhere.invalid/created/9'); $Body = '{}' }
                    '/version' { $Response.AddHeader('api-current-version', '2025.1'); $Body = '{}' }
                    default { $Status = 404; $Body = '{"code":"NotFound","message":"no route"}' }
                }

                $Bytes = $Utf8.GetBytes($Body)
                $Response.StatusCode = $Status
                $Response.ContentType = 'application/json; charset=utf-8'
                $Response.ContentLength64 = $Bytes.Length
                $Response.OutputStream.Write($Bytes, 0, $Bytes.Length)
                $Response.Close()
            }
        }).AddArgument($Listener).AddArgument($State)
    $Handle = $PowerShell.BeginInvoke()

    [pscustomobject]@{
        Url        = "http://localhost:$Port"
        Listener   = $Listener
        State      = $State
        PowerShell = $PowerShell
        Handle     = $Handle
    }
}

function Stop-CWMTestServer {
    param($Server)
    if (!$Server) { return }
    try { $Server.Listener.Stop(); $Server.Listener.Close() } catch { $null = $_ }
    try { $Server.PowerShell.Stop(); $Server.PowerShell.Dispose() } catch { $null = $_ }
}
