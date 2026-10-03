---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/7a66b9
Locale: en-US
Module Name: PSTimers
PlatyPS schema version: 2024-05-01
---

# Start-PSCountdownTitle

## SYNOPSIS

Start a countdown timer in the console title bar.

## SYNTAX

### Default (Default)

```yaml
Start-PSCountdownTitle [-Seconds] <Int32> [[-CountdownText] <String>] [-PostCountdownText <String>]
 [-Wait <Int32>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases:

- `TitleCountdown`

## DESCRIPTION

This function sets the console title to a countdown timer. If you are using Windows Terminal, the countdown will appear in the tab title. You can also specify text to display while the countdown timer is running and text to display when the timer completes. By default the original title will be restored after 10 seconds unless you set a different value for Wait. Set the value to -1 to leave the title as is after the countdown completes.

Once you start a countdown timer there is no way to manage or stop it other than closing the console window.

This command will not run in the PowerShell ISE or VS Code.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSCountdownTitle -Seconds 90 -CountdownText "Waiting for job" -PostCountdownText "Job Complete" -Wait 30
```

This example starts a countdown timer for 90 seconds with the text "Waiting for job" and "Job Complete" after the countdown. The original title will be restored after 30 seconds.

## PARAMETERS

### -CountdownText

Specify the text to display before the countdown in 16 characters or less.

```yaml
Type: String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PostCountdownText

Specify the text to display after the countdown completes in 25 characters or less.

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
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Seconds

The number of seconds for the countdown.

```yaml
Type: Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Wait

Specify the number of seconds to wait before restoring the original title.
Set to -1 to leave the title as is after the countdown completes.

```yaml
Type: Int32
DefaultValue: 10
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Start-PSCountdown](Start-PSCountdown.md)
- [Start-PSCountdownTitle](Start-PSCountdownTitle.md)
- [Start-PSCountdownTimer](Start-PSCountdownTimer.md)
