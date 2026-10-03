---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/877801
Locale: en-US
Module Name: PSTimers
ms.date: 10/01/2026
PlatyPS schema version: 2024-05-01
title: Stop-ConsoleTimer
---

# Stop-ConsoleTimer

## SYNOPSIS

Stop a console timer

## SYNTAX

### __AllParameterSets

```yaml
Stop-ConsoleTimer [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases:

- none

## DESCRIPTION

This command will stop a running console timer. The timer will remain displayed in case you want to restart or reset it with Start-ConsoleTimer. Use Remove-ConsoleTimer to clear it from the session and console.

## EXAMPLES

### Example 1

```powershell
PS C:\> Stop-ConsoleTimer
```

This will stop the timer from running but not remove it from the screen.

## PARAMETERS

### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### none

## OUTPUTS

### none

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Start-ConsoleTimer](Start-ConsoleTimer.md)
- [Remove-ConsoleTimer](Remove-ConsoleTimer.md)
