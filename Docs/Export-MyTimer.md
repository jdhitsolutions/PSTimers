---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version:
schema: 2.0.0
---

# Export-MyTimer

## SYNOPSIS

Export a timer object to an XML file.

## SYNTAX

```yaml
Export-MyTimer [[-Name] <String>] -Path <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to export timer objects to a file. You might want to do this if the "timer" is still running and you will use it in a later PowerShell session.

The default behavior is to export all timer variables or you can select specific ones by name.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Export-MyTimer -path c:\work\mytimers.xml
```

Export all timers to the specified file.

### EXAMPLE 2

```powershell
PS C:\> Export-MyTimer T1 -path c:\work\T1.xml
```

Export a single timer.

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

### -Name

The name of a timer to export. The default is to export all timers.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

The file name for the XML file to create.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

### [string]

## OUTPUTS

### [None]

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-MyTimer](Get-MyTimer.md)

[Import-MyTimer](Import-MyTimer.md)

