---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: https://bit.ly/3T0C3HO
schema: 2.0.0
---

# Import-MyTimer

## SYNOPSIS

Import a timer variable from an XML file.

## SYNTAX

```yaml
Import-MyTimer [-Path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

If you exported a timer variable with Export-MyTimer you can use this command to import it into your current session. Any existing variables with the same name will be overwritten.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Import-MyTimer -path c:\work\mytimers.xml
```

## PARAMETERS

### -Confirm

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

The file name for the XML file.

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

### -WhatIf

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [System.String]

## OUTPUTS

### MyTimer[]

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Export-MyTimer](Export-MyTimer.md)
