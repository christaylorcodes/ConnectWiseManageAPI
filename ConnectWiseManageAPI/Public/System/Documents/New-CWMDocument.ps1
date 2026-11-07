<#
.SYNOPSIS
    Uploads a document or links a URL to a ConnectWise Manage record.

.DESCRIPTION
    Creates a document attached to a record (ticket, company, project, ...). Either uploads a
    local file (-FilePath) or links a URL (-URL).

    The request is sent as multipart/form-data. The body is built as a byte array: the form
    fields and part headers are UTF-8 text and the file content is copied byte for byte, so
    binary files upload unchanged on both Windows PowerShell 5.1 and PowerShell 7.

    This function calls the ConnectWise Manage API endpoint: POST /system/documents

.PARAMETER recordType
    The type of record to attach the document to, e.g. 'Ticket', 'Company' or 'Project'.

.PARAMETER recordId
    The ID of the record to attach the document to.

.PARAMETER title
    The title of the document. Line breaks are replaced with a space.

.PARAMETER URL
    A URL to link instead of uploading a file.

.PARAMETER FilePath
    Path to the local file to upload. Must be a file, not a folder.

.PARAMETER FileName
    The file name to send to ConnectWise Manage. Defaults to the name of -FilePath.
    Double quotes, carriage returns and line feeds are replaced with '_'.

.PARAMETER Private
    Whether the document is private. Default: $true

.PARAMETER ReadOnly
    Whether the document is read-only. Default: $false

.PARAMETER isAvatar
    Whether the document is an avatar image. Default: $false

.EXAMPLE
    New-CWMDocument -recordType Ticket -recordId 12345 -title 'Screenshot' -FilePath 'C:\Temp\error.png'

    Uploads error.png to ticket 12345.

.EXAMPLE
    New-CWMDocument -recordType Company -recordId 250 -title 'Runbook' -URL 'https://wiki.example.com/runbook'

    Links a URL to company 250.

.LINK
    Get-CWMDocument

.LINK
    Remove-CWMDocument

.LINK
    https://developer.connectwise.com/Products/ConnectWise_PSA/REST
#>
function New-CWMDocument {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet(
            'Ticket',
            'Agreement',
            'Company',
            'Configuration',
            'Contact',
            'Expense',
            'Opportunity',
            'PurchaseOrder',
            'Project',
            'SalesOrder',
            'ServiceTemplate',
            'Rma'
        )]
        [string]$recordType,
        [Parameter(Mandatory=$true)]
        [int]$recordId,
        [Parameter(Mandatory=$true)]
        [string]$title,
        [Parameter(Mandatory=$true, ParameterSetName = 'URL')]
        [string]$URL,
        [Parameter(Mandatory=$true, ParameterSetName = 'File')]
        [ValidateScript({
            if(-Not ($_ | Test-Path)){ throw 'File or folder does not exist' }
            if(-Not ($_ | Test-Path -PathType Leaf)){
                throw 'The Path argument must be a file. Folder paths are not allowed.'
            }
            $true
        })]
        [System.IO.FileInfo]$FilePath,
        [Parameter(ParameterSetName = 'File')]
        [string]$FileName,
        [boolean]$Private = $true,
        [boolean]$ReadOnly = $false,
        [boolean]$isAvatar = $false
    )

    # https://www.techcolumnist.com/2019/01/09/powershell-connectwise-documents-api-uploading-a-document-or-attachment-to-a-ticket
    # The body is built as byte[] so file bytes are never re-encoded (a string body is re-encoded as UTF-8 on PS 7.4+).
    # CR/LF would start a new line inside the multipart body and a double quote would end the quoted filename=""
    # header value, so they are replaced. Quotes stay in the title: it is a part body, not a header.
    $title = $title -replace '[\r\n]+', ' '

    $boundary = [System.Guid]::NewGuid().ToString()
    $CRLF = "`r`n"

    $Head = (
        "--$boundary",
        'Content-Disposition: form-data; name="recordType"',
        '',
        $recordType,
        "--$boundary",
        'Content-Disposition: form-data; name="recordId"',
        '',
        $recordId,
        "--$boundary",
        'Content-Disposition: form-data; name="Title"',
        '',
        $title,
        "--$boundary",
        'Content-Disposition: form-data; name="PrivateFlag"',
        '',
        $Private,
        "--$boundary",
        'Content-Disposition: form-data; name="ReadOnlyFlag"',
        '',
        $ReadOnly,
        "--$boundary",
        'Content-Disposition: form-data; name="isAvatar"',
        '',
        $isAvatar,
        "--$boundary"
    )

    $fileBytes = $null
    switch ($PSCmdlet.ParameterSetName){
        'File' {
            if(!$FileName){ $FileName = Split-Path $FilePath -Leaf }
            $FileName = $FileName -replace '["\r\n]', '_'

            $fileBytes = [System.IO.File]::ReadAllBytes($FilePath.FullName)

            $Head += (
                "Content-Disposition: form-data; name=`"file`"; filename=`"$FileName`"",
                'Content-Type: application/octet-stream',
                ''
            )
        }
        'URL' {
            $Head += (
                'Content-Disposition: form-data; name="url"',
                '',
                $URL
            )
        }
    }

    $Utf8 = New-Object System.Text.UTF8Encoding($false)
    $Stream = New-Object System.IO.MemoryStream
    try {
        $HeadBytes = $Utf8.GetBytes((($Head | ForEach-Object { "$_" }) -join $CRLF) + $CRLF)
        $Stream.Write($HeadBytes, 0, $HeadBytes.Length)

        if ($null -ne $fileBytes) {
            $Stream.Write($fileBytes, 0, $fileBytes.Length)
            $TailBytes = $Utf8.GetBytes("$CRLF--$boundary--$CRLF")
        }
        else {
            $TailBytes = $Utf8.GetBytes("--$boundary--$CRLF")
        }
        $Stream.Write($TailBytes, 0, $TailBytes.Length)

        [byte[]]$BodyBytes = $Stream.ToArray()
    }
    finally {
        $Stream.Dispose()
    }

    $Arguments = @{
        Body        = $BodyBytes
        ContentType = "multipart/form-data; boundary=$boundary"
    }
    Invoke-CWMNewMaster -Arguments $Arguments -Endpoint '/system/documents'
}
