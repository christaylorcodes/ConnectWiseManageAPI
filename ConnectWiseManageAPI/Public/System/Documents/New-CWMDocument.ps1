function New-CWMDocumentURL {
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
        
        [Parameter(
            Mandatory=$true, 
            ParameterSetName = 'File'
        )]
        [ValidateScript({
            if(-Not ($_ | Test-Path)){ throw "File or folder does not exist" }
            if(-Not ($_ | Test-Path -PathType Leaf)){
                throw "The Path argument must be a file. Folder paths are not allowed."
            }
            $true
        })]
        [System.IO.FileInfo]$FilePath,
        
        [Parameter(ParameterSetName = 'File')]
        [string]$FileName,
        
        [boolean]$Private = $true,
        
        [boolean]$ReadOnly = $false
        
    )
  
    $boundary = [System.Guid]::NewGuid().ToString();
    $LF = "`r`n";
   
    switch ($PSCmdlet.ParameterSetName){
        "File" {
            Write-Debug "This is the File ParameterSet"
            If(!$FileName){ 
                Write-Debug "Making default filename from `$Filepath"
                $Filename = Split-Path $FilePath -Leaf
            }

            # https://www.techcolumnist.com/2019/01/09/powershell-connectwise-documents-api-uploading-a-document-or-attachment-to-a-ticket/
            $fileBytes = [System.IO.File]::ReadAllBytes($FilePath);
            $fileEnc = [System.Text.Encoding]::GetEncoding(28591).GetString($fileBytes);
            $Body = (
                "--$boundary",
                "Content-Disposition: form-data; name=`"recordType`"$LF",
                "$recordType",
                "--$boundary",
                "Content-Disposition: form-data; name=`"recordId`"$LF",
                "$recordId",
                "--$boundary",
                "Content-Disposition: form-data; name=`"Title`"$LF",
                "$title",
                "--$boundary",
                "Content-Disposition: form-data; name=`"PrivateFlag`"$LF",
                "$Private",
                "--$boundary",
                "Content-Disposition: form-data; name=`"ReadOnlyFlag`"$LF",
                "$ReadOnly",
                "--$boundary",
                "Content-Disposition: form-data; name=`"file`"; filename=`"$FileName`"",
                "Content-Type: application/octet-stream$LF",
                $fileEnc,
                "--$boundary--$LF"
            ) -join $LF
        }
        "URL" {
            Write-Debug "This is the URL ParameterSet"
            $Body = (
                "--$boundary",
                "Content-Disposition: form-data; name=`"recordType`"$LF",
                "$recordType",
                "--$boundary",
                "Content-Disposition: form-data; name=`"recordId`"$LF",
                "$recordId",
                "--$boundary",
                "Content-Disposition: form-data; name=`"Title`"$LF",
                "$title",
                "--$boundary",
                "Content-Disposition: form-data; name=`"PrivateFlag`"$LF",
                "$Private",
                "--$boundary",
                "Content-Disposition: form-data; name=`"ReadOnlyFlag`"$LF",
                "$ReadOnly",
                "--$boundary",
                "Content-Disposition: form-data; name=`"url`"$LF",
                "$URL",
                "--$boundary",
                "Content-Disposition: form-data; name=`"urlFlag`"$LF",
                "$true",
                "--$boundary--$LF"
            ) -join $LF

        }
    }

    $PsBoundParameters.Body = $Body
    $PsBoundParameters.ContentType = "multipart/form-data; boundary=`"$boundary`""

    $Endpoint = '/system/documents'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
