# This is the URL to your manage server.
$Server = 'server.example.com'

# This is the company entered at login
$Company = 'My Company ID'

# Your ClientID found at https://developer.connectwise.com/ClientID
$ClientID = 'Go generate your own ClientID'

# Create a credential object
$Credentials = Get-Credential

# Load the module into memory
Invoke-WebRequest 'https://raw.githubusercontent.com/christaylorcodes/ConnectWise-Manage-Powershell/master/CWManage.psm1' | Invoke-Expression

# Connect to your Manage server
Connect-CWM -Server $Server -Company $Company -Credentials $Credentials -ClientID $ClientID

# Now that you are connected you can issue any of the available commands
# In the following example we are using a condition to find all of the cool people in your contacts.
$Chrises = Get-CWMContact -condition 'firstName="chris"' -all

$Chrises | Out-GridView

# To clear your connection information from memory you can terminate the session or issue the disconnect command.
Disconnect-CWM