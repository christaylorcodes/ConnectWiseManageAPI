---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMTicketChildren

## SYNOPSIS
This function will add a child or children to the ticket $ID.

## SYNTAX

### 2023.9 (Default)
```
New-CWMTicketChildren [[-id] <Int32>] [[-ChildTicketIds] <int32>] | [[-ChildTicketIds] <array>]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
New-CWMTicketChildren -id 123456 -childTicketIds 987654
```

This will add 987654 as a child ticket to 123456

### EXAMPLE 2
```powershell
New-CWMTicketChildren -id 123456 -childTicketIds [987654,765432]
```

This will add 987654 AND 765432 as child tickets to 123456

## PARAMETERS

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Ben Craigs
Date: 28/09/2023

## RELATED LINKS

[https://developer.connectwise.com/Products/ConnectWise_PSA/REST#/Tickets/postServiceTicketsByParentIdAttachChildren](https://developer.connectwise.com/Products/ConnectWise_PSA/REST#/Tickets/postServiceTicketsByParentIdAttachChildren)
