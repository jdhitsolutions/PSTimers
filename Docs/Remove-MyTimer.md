---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version:
schema: 2.0.0
---

# Remove-MyTimer

## SYNOPSIS

Remove a myTimer object.

## SYNTAX

```yaml
Remove-MyTimer [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

MyTimer objects remain even after they have been stopped. Used this command to remove the timer object. It doesn't matter if the timer is running or not.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-MyTimer alpha
```

Remove the alpha timer.

### Example 2

```powershell
PS C:\> get-mytimer -all | where {-not $_.running} | remove-mytimer
```

Remove all stopped timers.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

The name of your timer object.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### None

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Stop-MyTimer](Stop-MyTimer.md)

[Get-MyTimer](Get-MyTimer.md)