---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMCompanyServiceTemplate

## SYNOPSIS
Creates a company service template.

## DESCRIPTION
Creates a service template under a company. The request uses the OpenAPI `ServiceTemplate` schema; `name`, `board`, `status`, and `summary` are required. Reference properties are supplied as hashtables. If `company` is not supplied, it defaults to the parent company (`@{ id = <companyId> }`); the API silently creates nothing without it.
## EXAMPLES

### EXAMPLE 1
```powershell
New-CWMCompanyServiceTemplate -companyId 123 -name 'Onboarding' -board @{ id = 1 } -status @{ id = 2 } -summary 'New customer onboarding'
```

Creates a template for company 123.

## PARAMETERS

### -parentId
The company ID. Alias: `companyId`.

### -name, -board, -status, -summary
Required properties from the `ServiceTemplate` request schema.

### Other schema properties
Optional properties follow the OpenAPI `ServiceTemplate` request schema, including service references, billing settings, estimates, and email flags.
