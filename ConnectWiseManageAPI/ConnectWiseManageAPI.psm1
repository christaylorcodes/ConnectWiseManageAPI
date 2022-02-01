#Get public and private function definition files.
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue -Recurse )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue -Recurse )

#Dot source the files
foreach ($import in @($Public + $Private)) {
    Try {
        . $import.fullName
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.fullName): $_"
    }
}

# Read in or create an initial config file and variable
# Export Public functions ($Public.BaseName) for WIP modules
# Set variables visible to the module and its functions only
Add-Type -AssemblyName System.Web

Export-ModuleMember -Function $Public.Basename -Alias *