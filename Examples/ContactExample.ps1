$CWMConnectionInfo = @{
    # This is the URL to your manage server.
    Server      = 'server.example.com'
    # This is the company entered at login
    Company     = 'My Company ID'
    # Public key created for this integration
    pubKey      = '1234'
    # Private key created for this integration
    privateKey  = 'abcd'
    # Your ClientID found at https://developer.connectwise.com/ClientID
    clientId    = 'Go generate your own ClientID'
}
# ^This information is sensitive, take precautions to secure it.^

# Install/Update/Load the module
if(Get-InstalledModule 'ConnectWiseManageAPI' -ErrorAction SilentlyContinue) { Update-Module 'ConnectWiseManageAPI' -Verbose }
else { Install-Module 'ConnectWiseManageAPI' -Verbose }
Import-Module 'ConnectWiseManageAPI'

# Connect to your Manage server
Connect-CWM @CWMConnectionInfo

# Now that you are connected you can issue any of the available commands
# In the following example we are using a condition to find all of the cool people in your contacts.
$Condition = 'firstName="chris"'
$Chrises = Get-CWMContact $Condition

# Lets check those chris's out.
$Chrises | Select-Object firstName, lastName, addressLine1, city, title | Out-GridView

# You might notice that you only received 25 Chris's. That is because the default pageSize is 25.
# You can change the pageSize or return all results.
$LessChris = Get-CWMContact $Condition -pageSize 11
$MoreChrises = Get-CWMContact $Condition -all

# Lets make a new contact
$AnotherChris = @{
    firstName       = 'Chris'
    lastName        = 'Taylor'
    addressLine1    = '1234 AnyStreet'
    city            = 'TownsVille'
}
$New = New-CWMContact @AnotherChris

# The newly created object should be returned to you in $New
Write-Output $New

# We forgot his title, lets add that
Update-CWMContact -id $New.id -Operation add -Path 'title' -Value 'Janitor'
# You will be returned the updated user object

# Now lets clean him up
Remove-CWMContact -id $New.id -Verbose
# A successful removal will have no output, so wo look at the verbose.

# To clear your connection information from memory you can terminate the session or issue the disconnect command.
Disconnect-CWM