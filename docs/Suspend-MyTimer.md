---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: https://bit.ly/3ZwN1sl
schema: 2.0.0
---

# Suspend-MyTimer

## SYNOPSIS

Pause a MyTimer object.

## SYNTAX

```yaml
Suspend-MyTimer [[-Name] <String>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to pause or suspend a running MyTask object. The command has an alias of Pause-MyTimer.

## EXAMPLES

### Example 1

```powershell
PS C:\> Suspend-MyTimer Client1 -PassThru

Name             Start                Stop Duration    Status Description
----             -----                ---- --------    ------ -----------
Client1 3/5/2023 10:29:28 AM      00:00:42:31 Paused work for Client1
```

he command does not write anything to the pipeline unless you use -Passthru.

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

Pause a MyTimer object. The timer must be running.

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

Return the timer object after pausing it.

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

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Resume-MyTimer](Resume-MyTimer.md)
