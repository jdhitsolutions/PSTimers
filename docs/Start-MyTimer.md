---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/62a7a4
Locale: en-US
Module Name: PSTimers
PlatyPS schema version: 2024-05-01
---

# Start-MyTimer

## SYNOPSIS

Start a simple timer.

## SYNTAX

### Default (Default)

```yaml
Start-MyTimer [[-Name] <String[]>] [-Description <String>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases:

- `ton`

## DESCRIPTION

This command starts a simple timer. You start it, which captures the current date and time, and stores the result in a global variable. You have the option of naming your timer which will allow you to have multiple timers running at the same time. Timer names must be unique. You can also add a brief description.

Timers are managed through two hashtables created as global variables, $MyTimerCollection and $MyWatchCollection. Do not delete these variables. The MyTimer commands will update these hashtables as needed.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-MyTimer
```

Start the timer with the default name of MyTimer.

### Example 2

```powershell
PS C:\> Start-MyTimer Timer2

Name            Start                  Stop         Duration         Running Description
----            -----                  ----         --------         ------- -----------
timer2          03/12/2026 11:09:25 AM              00:00:00            True
```

Create a second timer called Timer2.

### Example 3

```powershell
PS C:\> Start-MyTimer Z -Description "work stuff"


Name            Start                  Stop        Duration         Running Description
----            -----                  ----        --------         ------- -----------
Z               03/12/2026 11:10:16 AM             00:00:00            True work stuff
```

Create a new timer with a description.

### Example 4

```powershell
PS C:\> Start-MyTimer alpha,bravo,charlie


Name            Start                  Stop         Duration         Running Description
----            -----                  ----         --------         ------- -----------
a               03/12/2026 11:11:10 AM              00:00:00            True
b               03/12/2026 11:11:10 AM              00:00:00            True
c               03/12/2026 11:11:10 AM              00:00:00            True
```

Create multiple timers at once.

## PARAMETERS

### -Description

Enter an optional description for this timer.

```yaml
Type: String
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

### -Name

The name for your timer.
You can create multiple timers at the same time.
See examples.

```yaml
Type: String[]
DefaultValue: MyTimer
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### [MyTimer]

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Stop-MyTimer](Stop-MyTimer.md)
- [Get-MyTimer](Get-MyTimer.md)
