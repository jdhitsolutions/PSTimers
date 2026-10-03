---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/c4eb00
Locale: en-US
Module Name: PSTimers
ms.date: 10/01/2026
PlatyPS schema version: 2024-05-01
title: Start-ConsoleTimer
---

# Start-ConsoleTimer

## SYNOPSIS

Start a timer in the console window.

## SYNTAX

### __AllParameterSets

```yaml
Start-ConsoleTimer [[-DisplayColor] <string>] [[-BorderColor] <string>] [-Border] [-Reset] [-WhatIf]
 [-Confirm]
```

## ALIASES

This cmdlet has the following aliases:

- `stc`

## DESCRIPTION

You can use this command to display a simple timer in the upper-right corner of your console window. You can style the timer with a color and add a border. The timer will continue to run until you stop or remove it. The Start-ConsoleCountdown will create a timer counting down to zero, this command starts a running timer beginning at 0. You might start this as reminder to do something in a certain time frame.

When you stop the timer, it will remain on the screen until you remove it. If you run this command again with a stopped timer, it will resume from where it stopped. Use -Reset to restart the timer from zero.

Style settings are only applied with the timer is initialized.

You should not run this command if you are still displaying a console countdown.

The timer will not update on the screen while you are running commands in the console.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-ConsoleTimer
```

Start a timer with the default style settings.

### Example 2

```powershell
PS C:\> Start-ConsoleTimer -Border -BorderColor $PSStyle.Foreground.Cyan -DisplayColor "`e[3;91m" -Verbose
```

Start a timer in a cyan colored border using red italicized text.

## PARAMETERS

### -Border

Add a line border to the display. This setting will have no effect if you are resuming a stopped timer.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
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

### -BorderColor

Specify an ANSI or console color for the border. This parameter has no effect unless used with -Border. This setting will have no effect if you are resuming a stopped timer.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DisplayColor

Specify an ANSI style or console color for the clock display. This setting will have no effect if you are resuming a stopped timer.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Reset

Reset and start the console timer beginning at 0 seconds.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
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

This command doesn't use the PowerShell pipeline.

## NOTES

This command has an alias of stc

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Stop-ConsoleTimer](Stop-ConsoleTimer.md)
- [Remove-ConsoleTimer](Remove-ConsoleTimer.md)
- [Start-ConsoleCountdown](Start-ConsoleCountdown.md)
