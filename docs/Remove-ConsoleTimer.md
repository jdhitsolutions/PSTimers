---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/ddc8c5
Locale: en-US
Module Name: PSTimers
ms.date: 10/01/2026
PlatyPS schema version: 2024-05-01
title: Remove-ConsoleTimer
---

# Remove-ConsoleTimer

## SYNOPSIS

Remove a console timer from your session. If it is running, it will be stopped. The timer will remain in its final form in your console window. Eventually it will scroll out of view. You can manually run Clear-Host or use the -ClearHost parameter to remove it and clear the host with a single command.

## SYNTAX

### __AllParameterSets

```yaml
Remove-ConsoleTimer [-ClearHost]
```

## ALIASES

This cmdlet has the following aliases:

- none

## DESCRIPTION

Use this command to remove a console timer from your session.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-ConsoleTimer
```

This will stop the timer and remove it from the session. The timer will remain in its final form. Eventually it will scroll out of view. You can manually run Clear-Host or use the -ClearHost parameter to remove it and clear the host with a single command.

## PARAMETERS

### -ClearHost

Clear the console host after removing the console timer.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cls
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
- [Stop-ConsoleTimer](Stop-ConsoleTimer.md)
