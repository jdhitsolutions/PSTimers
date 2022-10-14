---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version:
schema: 2.0.0
---

# Stop-PSCountdownTimer

## SYNOPSIS

Stop a Countdown Timer

## SYNTAX

```yaml
Stop-PSCountdownTimer [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

When you start a PSCountdownTimer, you can control it from your command prompt with the $PSCountdownClock synchronized hashtable. You can set the Running property to $False to terminate it. Or you can run this command. This command will terminate the clock, remove the synchronized hashtable, and clean up the runspace.

## EXAMPLES

### Example 1

```powershell
PS C:\> Stop-PSCountdownTimer
```

This command supports -Whatif.

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

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Start-PSCountdownTimer](Start-PSCountdownTimer.md)
