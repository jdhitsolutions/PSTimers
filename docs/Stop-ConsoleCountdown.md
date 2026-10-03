---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/a6662a
Locale: en-US
Module Name: PSTimers
ms.date: 09/30/2026
PlatyPS schema version: 2024-05-01
title: Stop-ConsoleCountdown
---

# Stop-ConsoleCountdown

## SYNOPSIS

Stop a console countdown.

## SYNTAX

### __AllParameterSets

```yaml
Stop-ConsoleCountdown [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases:

- none

## DESCRIPTION

This command will stop a console countdown and clear all related settings. You should only need to invoke this command manually to clear a countdown clock that is displaying post-countdown text or if you want to abort a running countdown.

The countdown display will remain on the screen until it scrolls out of view. Or you can manually run Clear-Host.

## EXAMPLES

### Example 1

```powershell
PS C:\> Stop-ConsoleCountdown
```

This command doesn't write anything to the pipeline. The countdown display will remain on the screen until it scrolls out of view. Or you can manually run Clear-Host.

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

## OUTPUTS

### none

This command doesn't write anything to the pipeline.

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Start-ConsoleCountdown](Start-ConsoleCountdown.md)
