function New-CWMDocument {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('Ticket','Agreement','Company','Configuration','Contact','Expense','Opportunity','PurchaseOrder','Project','SalesOrder','ServiceTemplate','Rma')]
        [string]$recordType,
        [Parameter(Mandatory=$true)]
        [int]$recordId,
        [Parameter(Mandatory=$true)]
        [string]$title,
        [Parameter(Mandatory=$true)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "File or folder does not exist"
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "The Path argument must be a file. Folder paths are not allowed."
            }
            return $true
        })]
        [System.IO.FileInfo]$FilePath,
        [string]$FileName = (Split-Path $FilePath -Leaf),
        [boolean]$Private = $true,
        [boolean]$ReadOnly = $false
    )

    # https://www.techcolumnist.com/2019/01/09/powershell-connectwise-documents-api-uploading-a-document-or-attachment-to-a-ticket/
    $fileBytes = [System.IO.File]::ReadAllBytes($FilePath);
    $fileEnc = [System.Text.Encoding]::GetEncoding(28591).GetString($fileBytes);
    $boundary = [System.Guid]::NewGuid().ToString();
    $LF = "`r`n";

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

    $PsBoundParameters.Body = $Body
    $PsBoundParameters.ContentType = "multipart/form-data; boundary=`"$boundary`""

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/documents"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
