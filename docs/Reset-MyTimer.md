---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: https://jdhitsolutions.com/yourls/c8ec02
schema: 2.0.0
---

# Reset-MyTimer

## SYNOPSIS

Reset a MyTimer object.

## SYNTAX

```yaml
Reset-MyTimer [[-Name] <String>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will reset a MyTimer object. The result is a stopped timer with a Reset status. If you want to start it again, use Restart-MyTimer.

## EXAMPLES

### Example 1

```powershell
PS C:\> Reset-MyTimer Client1 -PassThru

Name    Start                Stop                 Duration    Status Description
----    -----                ----                 --------    ------ -----------
Client1 3/5/2025 10:29:28 AM 3/5/2025 11:17:15 AM 00:00:00:00  Reset work for
                                                                     Client1
```

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

Reset a MyTimer object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Return the timer object after resetting it.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### None

### MyTimer

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Restart-MyTimer](Restart-MyTimer.md)
