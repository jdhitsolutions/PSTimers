---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/89096a
Module Name: PSTimers
ms.date: 09/30/2026
PlatyPS schema version: 2024-05-01
---

# Suspend-MyTimer

## SYNOPSIS

Pause a MyTimer object.

## SYNTAX

### Default (Default)

```yaml
Suspend-MyTimer [[-Name] <String>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### __AllParameterSets

```yaml
Suspend-MyTimer [-Name] <string> [-PassThru] [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases:

- `Pause-MyTimer`

## DESCRIPTION

Use this command to pause or suspend a running MyTask object. The command has an alias of Pause-MyTimer.

## EXAMPLES

### Example 1

```powershell
PS C:\> Suspend-MyTimer Client1 -PassThru

Name             Start                Stop Duration    Status Description
----             -----                ---- --------    ------ -----------
Client1          3/5/2026 10:29:28 AM      00:00:42:31 Paused work for Client1
```

he command does not write anything to the pipeline unless you use -Passthru.

## PARAMETERS

### -Name

Pause a MyTimer object.
The timer must be running.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases:
- Timer
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PassThru

Return the timer object after pausing it.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: None
SupportsWildcards: false
Aliases: []
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

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: None
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
DefaultValue: None
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

### System.String

## OUTPUTS

### None

### MyTimer

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Resume-MyTimer](Resume-MyTimer.md)
