---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/0df0c8
Locale: en-US
Module Name: PSTimers
PlatyPS schema version: 2024-05-01
---

# Start-PSCountdown

## SYNOPSIS

Start a graphical countdown display using Write-Progress.

## SYNTAX

### minutes (Default)

```yaml
Start-PSCountdown [[-Minutes] <Int32>] [[-Message] <String>] [-Title <String>] [-ClearHost]
 [-ProgressStyle <String>] [-Path <String>] [<CommonParameters>]
```

### time

```yaml
Start-PSCountdown [[-Time] <DateTime>] [[-Message] <String>] [-Title <String>] [-ClearHost]
 [-ProgressStyle <String>] [-Path <String>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases:

- `spsc`

## DESCRIPTION

This command will display countdown progress bar using Write-Progress. You can set the timer for a specific time or number of minutes. The countdown includes humorous items to indicate time passing. These items are drawn from an included list but you can specify a path to custom items.

Start-PSCountdown is inspired from code originally published at: https://github.com/Windos/powershell-depot/blob/master/livecoding.tv/StreamCountdown/StreamCountdown.psm1

This command should work in Windows PowerShell and PowerShell 7, but not in the PowerShell ISE. Support in VS Code is not guaranteed. If you are running this on a non-Windows platform, you should be running at least PowerShell 7.2.

Use Ctrl+C to abort the countdown.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSCountdown -minutes 5
```

Start a countdown display set to expire in 5 minutes. This will use the default values for Title and Message. Use Ctrl+C to abort the countdown.

### Example 2

```powershell
PS C:\> Start-PSCountdown -time 9:00AM -title "Welcome Back" -message "Review your class notes and have questions ready" -ClearHost -progressStyle random
```

Start a countdown timer to 9:00AM. The screen will be cleared and the progress bar color will cycle through a random set of colors.

### Example 3

```powershell
PS C:\> $PSStyle.progress.view = "Classic"
PS C:\> $host.PrivateData.ProgressForegroundColor = "yellow"
PS C:\> Start-PSCountdown -minutes 1 -title "Bathroom break" -Message "Hurry Back" -progressStyle Random
PS C:\> $PSStyle.progress.view = "Minimal"
```

In PowerShell 7 using the $PSStyle feature, if you want to revert back to the classic progress view, you can set the view style to Classic. When this is set, then the $host.PrivateData values are used. You might need to change the foreground color, especially when using a random or transparent style.

## PARAMETERS

### -ClearHost

Use this parameter to clear the screen prior to starting the countdown. The parameter has an alias of cls.

```yaml
Type: SwitchParameter
DefaultValue: None
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

### -Message

Enter a primary message to display in the parent window.

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
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Minutes

Enter the number of minutes to countdown (1-60). The default is 5.

```yaml
Type: Int32
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: minutes
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Path

The path to a text list of pseudo-tasks. By default the command will use the list provided with the module but you can specify your own list. One item per list. Prefix a line with a # to comment it out.

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

### -ProgressStyle

Select a progress bar style.

Default - use the current value of $host.PrivateData.ProgressBarBackgroundColor

Transparent - set the progress bar background color to the same as the console. This has no effect in PowerShell 7 when using PSStyle settings unless you switch the view to Classic.

Random - randomly cycle through a list of console colors. This has no practical effect on Linux platforms when the $PSStyle.Progress.View is set to Classic, depending on the PowerShell version.

The parameter has an alias of style. Note that the final effect may depend on a combination of your platform and console. Running this in a traditional console vs Windows Terminal may yield different results. Running on non-Windows may add another factor.

```yaml
Type: String
DefaultValue: None
SupportsWildcards: false
Aliases:
- style
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues:
- Default
- Random
- Transparent
HelpMessage: ''
```

### -Time

Enter a datetime value as the countdown target.

```yaml
Type: DateTime
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: time
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Title

Enter the text for the progress bar title.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Start-PSCountdownTitle](Start-PSCountdownTitle.md)
- [Start-PSCountdownTimer](Start-PSCountdownTimer.md)
- [Start-ConsoleCountdown](Start-ConsoleCountDown.md)
