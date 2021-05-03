$PSScriptRoot
Set-Location -Path $PSScriptRoot
Get-Date
$DevScripts = '..\ConnectWiseManageAPI\ConnectWiseManageAPI.psm1'
Import-Module -Name $DevScripts -Verbose
