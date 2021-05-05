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
    $boundary = [System.Guid]::NewGuid().ToString()

    $Body = (
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
        'Content-Disposition: form-data; name="PrivateFlag',
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

    switch ($PSCmdlet.ParameterSetName){
        'File' {
            if(!$FileName){ $FileName = Split-Path $FilePath -Leaf }

            $fileBytes = [System.IO.File]::ReadAllBytes($FilePath)
            $fileEnc = [System.Text.Encoding]::GetEncoding(28591).GetString($fileBytes)

            $Body += (
                "Content-Disposition: form-data; name=`"file`"; filename=`"$FileName`"",
                'Content-Type: application/octet-stream',
                '',
                $fileEnc,
                "--$boundary--"
            )
        }
        'URL' {
            $Body += (
                'Content-Disposition: form-data; name="url"',
                '',
                $URL,
                "--$boundary--"
            )
        }
    }

    $PsBoundParameters.Body = $Body | Out-String
    $PsBoundParameters.ContentType = "multipart/form-data; boundary=`"$boundary`""

    $Endpoint = '/system/documents'

    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
