---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/706ba0
Locale: en-US
Module Name: PSTimers
ms.date: 09/30/2026
PlatyPS schema version: 2024-05-01
title: Start-ConsoleCountdown
---

# Start-ConsoleCountdown

## SYNOPSIS

Start a countdown timer in the console.

## SYNTAX

### __AllParameterSets

```yaml
Start-ConsoleCountdown [-Seconds] <int> [-PostCountdownText <string>] [-DisplayColor <string>]
 [-Border] [-BorderColor <string>] [-WhatIf] [-Confirm]
```

## ALIASES

This cmdlet has the following aliases:

- `stcd`

## DESCRIPTION

You can use this command to display a simple countdown timer in the upper-right corner of your console window. You can style the timer with a color and add a border. When the timer completes it will remain in the console until you clear the screen.

You should not run this command if you are still displaying a console timer.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-ConsoleCountdown -seconds 300
```

Start a five minute countdown timer in the upper-right corner of the console window using default style settings.

### Example 2

```powershell
PS C:\> Start-ConsoleCountdown -Seconds 600 -Border -BorderColor $PSStyle.Foreground.BrightGreen -PostCountdownText "I am ready".
```

This will display a 10-minute countdown timer in the upper-right corner of the console window. The timer will be displayed using the default style wrapped in a bright green border. At the end of the countdown the message will be displayed. Run Stop-ConsoleCountdown to end the countdown process. The message will remain until you run Clear-Host.

## PARAMETERS

### -Border

Add a line border to the display.

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

Specify an ANSI or console color for the border. This parameter has no effect unless used with -Border.

```yaml
Type: System.String
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

### -DisplayColor

Specify an ANSI style or console color for the clock display.

```yaml
Type: System.String
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

### -PostCountdownText

Specify the text to display after the countdown completes in 25 characters or less. Run Stop-ConsoleCountdown to end the countdown process. The message will remain until you run Clear-Host.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Seconds

The number of seconds for the countdown.

```yaml
Type: System.Int32
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: true
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

### System.Int32

The number of seconds for the countdown timer.

### System.String

A message to display when the timer completes.

## OUTPUTS

This command doesn't use the PowerShell pipeline.

## NOTES

This command has an alias of stcd

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Stop-ConsoleCountdown](Stop-ConsoleCountdown)
- [Start-ConsoleTimer](Start-ConsoleTimer)
- [Start-PSCountdownTitle](Start-PSCountdownTitle.md)
- [Start-PSCountdownTimer](Start-PSCountdownTimer.md)
