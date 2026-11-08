---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/Companies
schema: 2.0.0
---

# New-CWMCompany

## SYNOPSIS
Creates a new company record in ConnectWise Manage.

## SYNTAX

```
New-CWMCompany [[-id] <Int32>] [-identifier] <String> [-name] <String> [[-status] <Hashtable>]
 [[-addressLine1] <String>] [[-addressLine2] <String>] [[-city] <String>] [[-state] <String>] [[-zip] <String>]
 [[-country] <Hashtable>] [[-phoneNumber] <String>] [[-faxNumber] <String>] [[-website] <String>]
 [[-territory] <Hashtable>] [[-market] <Hashtable>] [[-accountNumber] <String>] [[-defaultContact] <Hashtable>]
 [[-dateAcquired] <String>] [[-sicCode] <Hashtable>] [[-parentCompany] <Hashtable>] [[-annualRevenue] <Double>]
 [[-numberOfEmployees] <Int32>] [[-yearEstablished] <Int32>] [[-revenueYear] <Int32>]
 [[-ownershipType] <Hashtable>] [[-timeZoneSetup] <Hashtable>] [[-leadSource] <String>] [[-leadFlag] <Boolean>]
 [[-unsubscribeFlag] <Boolean>] [[-calendar] <Hashtable>] [[-userDefinedField1] <String>]
 [[-userDefinedField2] <String>] [[-userDefinedField3] <String>] [[-userDefinedField4] <String>]
 [[-userDefinedField5] <String>] [[-userDefinedField6] <String>] [[-userDefinedField7] <String>]
 [[-userDefinedField8] <String>] [[-userDefinedField9] <String>] [[-userDefinedField10] <String>]
 [[-vendorIdentifier] <String>] [[-taxIdentifier] <String>] [[-taxCode] <Hashtable>]
 [[-billingTerms] <Hashtable>] [[-invoiceTemplate] <Hashtable>] [[-pricingSchedule] <Hashtable>]
 [[-companyEntityType] <Hashtable>] [[-billToCompany] <Hashtable>] [[-billingSite] <Hashtable>]
 [[-billingContact] <Hashtable>] [[-invoiceDeliveryMethod] <Hashtable>] [[-invoiceToEmailAddress] <String>]
 [[-invoiceCCEmailAddress] <String>] [[-deletedFlag] <Boolean>] [[-dateDeleted] <String>]
 [[-deletedBy] <String>] [[-mobileGuid] <String>] [[-facebookUrl] <String>] [[-twitterUrl] <String>]
 [[-linkedInUrl] <String>] [[-currency] <Hashtable>] [[-territoryManager] <Hashtable>]
 [[-resellerIdentifier] <String>] [[-isVendorFlag] <Boolean>] [[-types] <Array>] [[-site] <Hashtable>]
 [[-integratorTags] <Array>] [[-_info] <Hashtable>] [[-customFields] <Hashtable[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new company with specified properties.
Only identifier and name are required.
All other fields are optional and will use system defaults if not specified.

This function calls the ConnectWise Manage API endpoint: POST /company/companies

## EXAMPLES

### EXAMPLE 1
```
# Minimal company creation
$company = @{
    identifier = "ACME"
    name = "Acme Corporation"
}
New-CWMCompany @company
```

Creates a basic company with required fields only.

### EXAMPLE 2
```
# Company with address
$companyParams = @{
    identifier = "ACME"
    name = "Acme Corporation"
    addressLine1 = "123 Main St"
    city = "Seattle"
    state = "WA"
    zip = "98101"
    phoneNumber = "206-555-1234"
    website = "https://acme.com"
}
New-CWMCompany @companyParams
```

Creates a company with full address information.

### EXAMPLE 3
```
# Company with type
$companyParams = @{
    identifier = "NEWCUST"
    name = "New Customer LLC"
    types = @( @{id=1} )  # Customer type
    status = @{ id = 1 }  # Active status
}
New-CWMCompany @companyParams
```

Creates a company with specific type and status.

## PARAMETERS

### -id
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new
record.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -identifier
The company identifier/code (required).
Maximum 25 characters.
Must be unique across all companies.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
The company name (required).
Maximum 50 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Hashtable with status reference.
Format: @{ id = 1 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine1
First line of company address.
Maximum 50 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine2
Address line 2.
At least one address field is required -- addressLine1, addressLine2, city, state, zip
and/or country.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -city
City name.
Maximum 50 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -state
State/province.
Maximum 50 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zip
Postal/ZIP code.
Maximum 12 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -country
Country reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phoneNumber
Primary phone number.
Maximum 30 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -faxNumber
Fax number.
Max length 30.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -website
Company website URL.
Maximum 255 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -territory
Territory reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -market
Market reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -accountNumber
Account number.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultContact
Default contact reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateAcquired
Date acquired.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sicCode
SIC code reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentCompany
Parent company reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -annualRevenue
Annual revenue.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -numberOfEmployees
Number of employees.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -yearEstablished
Year established.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -revenueYear
Revenue year.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ownershipType
Ownership type reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeZoneSetup
Time zone setup reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -leadSource
Lead source.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -leadFlag
Lead flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -unsubscribeFlag
Unsubscribe flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -calendar
Calendar reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField1
User defined field 1.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField2
User defined field 2.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField3
User defined field 3.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField4
User defined field 4.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField5
User defined field 5.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField6
User defined field 6.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField7
User defined field 7.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField8
User defined field 8.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField9
User defined field 9.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -userDefinedField10
User defined field 10.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vendorIdentifier
Vendor identifier.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxIdentifier
Tax identifier.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxCode
Tax code reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingTerms
Billing terms reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceTemplate
Invoice template reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pricingSchedule
Pricing schedule reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -companyEntityType
Company entity type reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToCompany
Bill to company reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingSite
Billing site reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingContact
Billing contact reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceDeliveryMethod
Invoice delivery method reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceToEmailAddress
Invoice to email address.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceCCEmailAddress
Invoice CC email address.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deletedFlag
Deleted flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateDeleted
Date deleted.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deletedBy
Deleted by.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileGuid
Mobile GUID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -facebookUrl
Facebook URL.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -twitterUrl
Twitter URL.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -linkedInUrl
LinkedIn URL.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -currency
Currency reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -territoryManager
Territory manager reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resellerIdentifier
Reseller identifier.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isVendorFlag
Is vendor flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 64
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -types
Array of company type hashtables.
Example: @( @{id=1}, @{id=2} )
Common types: Customer, Vendor, Partner, Prospect

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -site
Site reference, for example @{ id = 5 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 66
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -integratorTags
Integrator tags.
An array of strings.

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 67
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
The _info metadata of the record, as returned by the API.
Usually left unset.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 68
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
Custom fields.
An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

```yaml
Type: System.Collections.Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 69
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor

Required Fields:
- identifier (string, max 25 chars, must be unique)
- name (string, max 50 chars)

Common Optional Fields:
- status, types, territory
- address fields (addressLine1, city, state, zip)
- phoneNumber, faxNumber, website
- defaultContact, parentCompany

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/Companies](https://developer.connectwise.com/manage/rest#/Companies)

[Get-CWMCompany]()

[Update-CWMCompany]()

[Remove-CWMCompany]()

