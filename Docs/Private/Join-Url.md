---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# Join-Url

## SYNOPSIS
Joins two URL segments.

## SYNTAX

```
Join-Url [-Path] <String> [-ChildPath] <String> [<CommonParameters>]
```

## DESCRIPTION
Joins two URL segments with exactly one slash between them: trailing slashes of -Path and leading
slashes of -ChildPath are removed first.
Internal helper; no API call is made.

## EXAMPLES

### EXAMPLE 1
```
Join-Url 'https://na.myconnectwise.net/' '/v4_6_release'
```

Returns https://na.myconnectwise.net/v4_6_release.

## PARAMETERS

### -Path
Root URL path to join to.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChildPath
The segment to append to -Path.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
