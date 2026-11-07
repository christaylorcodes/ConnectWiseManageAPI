#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline unit tests for Get-CWMReportColumn (#65), New-CWMProjectTicket (#43) and the byte-exact
# New-CWMDocument upload. No ConnectWise server or network needed.

BeforeAll {
    Import-Module "$PSScriptRoot\..\ConnectWiseManageAPI\ConnectWiseManageAPI.psd1" -Force
}

AfterAll {
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Get-CWMReportColumn' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Codebase = 'v4_6_release/'; BasePath = 'apis/3.0'; Headers = @{ ClientID = 'test' } }
        }
    }

    It 'returns an ordered dictionary of column name to definition' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest {
                [pscustomobject]@{ StatusCode = 200; Headers = @{}; Content = '[{"id":{"type":"Numeric"}},{"name":{"type":"Text"}}]' }
            }
            $Result = Get-CWMReportColumn -Report 'Service'
            $Result | Should -BeOfType [System.Collections.IDictionary]
            @($Result.Keys) | Should -Be @('id', 'name')
            $Result['id'].type | Should -Be 'Numeric'
            $Result['name'].type | Should -Be 'Text'
            Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter { $Arguments.Uri -like '*/system/reports/Service/columns*' }
        }
    }

    It 'also handles a single object with several column properties' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest {
                [pscustomobject]@{ StatusCode = 200; Headers = @{}; Content = '{"id":{"type":"Numeric"},"name":{"type":"Text"}}' }
            }
            $Result = Get-CWMReportColumn -Report 'Service'
            $Result | Should -BeOfType [System.Collections.IDictionary]
            $Result.Count | Should -Be 2
        }
    }

    It 'returns nothing, without error, for an empty result' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest {
                [pscustomobject]@{ StatusCode = 200; Headers = @{}; Content = '[]' }
            }
            $Err = $null
            $Result = Get-CWMReportColumn -Report 'Service' -ErrorVariable Err
            $Result | Should -BeNullOrEmpty
            $Err | Should -BeNullOrEmpty
        }
    }
}

Describe 'New-CWMProjectTicket' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Codebase = 'v4_6_release/'; BasePath = 'apis/3.0'; Headers = @{ ClientID = 'test' } }
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ StatusCode = 201; Headers = @{}; Content = '{"id":1}' } }
        }
    }

    It 'POSTs to /project/tickets with project.id in the JSON body' {
        InModuleScope ConnectWiseManageAPI {
            $Result = New-CWMProjectTicket -summary 'Migrate file shares' -project @{ id = 386 } -phase @{ id = 12 } -Confirm:$false
            $Result.id | Should -Be 1
            Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter {
                $Json = $Arguments.Body | ConvertFrom-Json
                $Arguments.Method -eq 'Post' -and
                $Arguments.Uri -match '/project/tickets$' -and
                $Json.project.id -eq 386 -and
                $Json.phase.id -eq 12 -and
                $Json.summary -eq 'Migrate file shares'
            }
        }
    }

    It 'requires -project' {
        InModuleScope ConnectWiseManageAPI {
            (Get-Command New-CWMProjectTicket).Parameters['project'].Attributes |
                Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] } |
                ForEach-Object { $_.Mandatory } | Should -Contain $true
        }
    }
}

Describe 'New-CWMDocument multipart body' {

    BeforeAll {
        $script:TestFile = Join-Path ([System.IO.Path]::GetTempPath()) ("StepC-{0}.bin" -f [guid]::NewGuid())
        [System.IO.File]::WriteAllBytes($script:TestFile, [byte[]](0x41, 0x89, 0xFF, 0x00))
    }

    AfterAll {
        Remove-Item $script:TestFile -Force -ErrorAction SilentlyContinue
    }

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Codebase = 'v4_6_release/'; BasePath = 'apis/3.0'; Headers = @{ ClientID = 'test' } }
            $script:CapturedBody = $null
            $script:CapturedType = $null
            Mock Invoke-WebRequest {
                $script:CapturedBody = $Body
                $script:CapturedType = $ContentType
                [pscustomobject]@{ StatusCode = 201; Headers = @{}; Content = '{"id":7}' }
            }
        }
    }

    It 'sends the exact file bytes between the part headers and the closing boundary' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Path = $script:TestFile } {
            param($Path)
            $Result = New-CWMDocument -recordType Ticket -recordId 123 -title 'T' -FilePath $Path -FileName 'a.bin' -Confirm:$false
            $Result.id | Should -Be 7

            Should -Invoke Invoke-WebRequest -Times 1 -Exactly
            $Body = $script:CapturedBody
            , $Body | Should -BeOfType [byte[]]

            $script:CapturedType | Should -Match '^multipart/form-data; boundary=[0-9a-f-]{36}$'
            $Boundary = ($script:CapturedType -split 'boundary=')[1]

            # Latin-1 maps every byte to one char, so indexes in the string equal indexes in the byte array
            $Text = [System.Text.Encoding]::GetEncoding(28591).GetString($Body)
            $Header = "Content-Type: application/octet-stream`r`n`r`n"
            $Start = $Text.IndexOf($Header) + $Header.Length
            $Start | Should -BeGreaterThan $Header.Length
            $Tail = "`r`n--$Boundary--`r`n"

            [byte[]]$Body[$Start..($Start + 3)] | Should -Be ([byte[]](0x41, 0x89, 0xFF, 0x00))
            $Text.Substring($Start + 4) | Should -BeExactly $Tail
            $Text | Should -Match 'filename="a\.bin"'
            $Text | Should -Match "name=`"recordId`"`r`n`r`n123`r`n"
        }
    }

    It 'still sends URL documents as a multipart byte body' {
        InModuleScope ConnectWiseManageAPI {
            New-CWMDocument -recordType Company -recordId 250 -title 'Runbook' -URL 'https://wiki.example.com/x' -Confirm:$false | Out-Null
            $Text = [System.Text.Encoding]::UTF8.GetString($script:CapturedBody)
            $Boundary = ($script:CapturedType -split 'boundary=')[1]
            $Text | Should -Match "name=`"url`"`r`n`r`nhttps://wiki\.example\.com/x`r`n--$Boundary--`r`n$"
        }
    }
}
