---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# Test-ParameterVersioning

## SYNOPSIS
This is used to determine the latest version based on parameters passed.

## SYNTAX

```
Test-ParameterVersioning [-VersionAutomatic] [-ParameterSetName] <String> [-DefaultParameterSetName] <String>
 [[-Version] <String>] [<CommonParameters>]
```

## DESCRIPTION
As the API changes and new versions are released the module will need to accept new parameter sets based on what is available for that version. This is used to see what version should be passed to the API based on the parameters used.

## EXAMPLES

### Example 1
```powershell
$TestVersion = @{
    VersionAutomatic = $VersionAutomatic
    ParameterSetName = $PSCmdlet.ParameterSetName
    DefaultParameterSetName = $PSCmdlet.MyInvocation.MyCommand.DefaultParameterSet
    Version = $Version
}
$PsBoundParameters.Version = Test-ParameterVersioning @TestVersion
```

Updates the version to the latest version possible based on parameters passed.

## PARAMETERS

### -DefaultParameterSetName
{{ Fill DefaultParameterSetName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParameterSetName
{{ Fill ParameterSetName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
{{ Fill Version Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VersionAutomatic
{{ Fill VersionAutomatic Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
