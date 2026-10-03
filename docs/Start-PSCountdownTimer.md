---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/9f666f
Locale: en-US
Module Name: PSTimers
PlatyPS schema version: 2024-05-01
---

# Start-PSCountdownTimer

## SYNOPSIS

Start a WPF-based countdown timer.

## SYNTAX

### seconds (Default)

```yaml
Start-PSCountdownTimer [[-Seconds] <Int32>] [-Message <String>] [-FontSize <Int32>]
 [-FontStyle <String>] [-FontWeight <String>] [-Color <String>] [-FontFamily <String>] [-OnTop]
 [-Position <Int32[]>] [-Alert <Int32>] [-AlertColor <String>] [-Warning <Int32>]
 [-WarningColor <String>] [-Action <ScriptBlock>] [<CommonParameters>]
```

### time

```yaml
Start-PSCountdownTimer -Time <DateTime> [-Message <String>] [-FontSize <Int32>]
 [-FontStyle <String>] [-FontWeight <String>] [-Color <String>] [-FontFamily <String>] [-OnTop]
 [-Position <Int32[]>] [-Alert <Int32>] [-AlertColor <String>] [-Warning <Int32>]
 [-WarningColor <String>] [-Action <ScriptBlock>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases:

- none

## DESCRIPTION

Use this command to display a WPF-based countdown timer, running in a background runspace.  The timer will be displayed in the center of the screen. You can click and drag the timer to reposition using the left mouse button. You might have to try a few times to "grab" the timer. You can close the clock with a right-click of the mouse, or run Stop-PSCountdownTimer in the same session where you started the timer.

The timer has alert and warning settings. At the alert level of 50, the font color will change to yellow at and at 30 seconds, the warning level, it will turn to red. You can customize this behavior with parameters.

The countdown timer runs in a separate runspace launched from your PowerShell session. If you close the session, the countdown timer will also be closed. The timer uses a synchronized hashtable. You can modify settings in $PSCountdownClock and they will be reflected in the timer. Set $PSCountdownClock.Running to $False to cancel the timer.

This command requires a Windows platform.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSCountdownTimer -seconds 300 -color Black
```

Start a 5 minute countdown.

### Example 2

```powershell
PS C:\> Start-PSCountdownTimer -seconds 600 -message "We are resuming in:" -OnTop
PS C:\> $PSCountdownClock.Color="darkgreen"
```

The first command starts a 10 minute countdown with a message prefix. The display will always be on top of other windows. The second command uses the synchronized hashtable to change the font color.

### Example 3

```powershell
PS C:\> Start-PSCountdownTimer -seconds 600 -Action { New-BurntToastNotification -Text "Time is up!" }
```

Start a 10 minute countdown. When the countdown expires, a toast notification will be displayed using the BurntToast module.

## PARAMETERS

### -Action

Define a ScriptBlock to execute when the clock expires

```yaml
Type: ScriptBlock
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

### -Alert

Specify the number of seconds remaining to switch to alert coloring.

```yaml
Type: Int32
DefaultValue: 50
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

### -AlertColor

Specify alert coloring.

```yaml
Type: String
DefaultValue: Yellow
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

### -Color

Specify a font color like Green or an HTML code like '#FF1257EA'

```yaml
Type: String
DefaultValue: White
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

### -FontFamily

Specify a font family.

```yaml
Type: String
DefaultValue: Segoi UI
SupportsWildcards: false
Aliases:
- family
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

### -FontSize

Specify a font size.

```yaml
Type: Int32
DefaultValue: 48
SupportsWildcards: false
Aliases:
- size
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

### -FontStyle

Specify a font style.

```yaml
Type: String
DefaultValue: Normal
SupportsWildcards: false
Aliases:
- style
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues:
- Normal
- Italic
- Oblique
HelpMessage: ''
```

### -FontWeight

Specify a font weight.

```yaml
Type: String
DefaultValue: Normal
SupportsWildcards: false
Aliases:
- weight
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues:
- Normal
- Bold
- Light
HelpMessage: ''
```

### -Message

Specify a short message prefix like 'Starting in: '

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

### -OnTop

Do you want the clock to always be on top? You can modify this setting in the synchronized hashtable with $PSCountdownClock.OnTop. Set the value to $True or $False.

```yaml
Type: SwitchParameter
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

### -Position

Specify the clock position as an array of left and top values.

```yaml
Type: Int32[]
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

Enter the number of seconds to countdown from.

```yaml
Type: Int32
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: seconds
  Position: 60
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Time

Enter a DateTime value as the countdown target.

```yaml
Type: DateTime
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: time
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Warning

Specify the number of seconds remaining to switch to warning coloring.

```yaml
Type: Int32
DefaultValue: 30
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

### -WarningColor

Specify warning coloring.

```yaml
Type: String
DefaultValue: Red
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

### System.String

### System.Int32

### System.Management.Automation.SwitchParameter

### System.Int32[]

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Start-PSCountdownTimer](Start-PSCountdownTimer.md)
- [Start-PSCountdown](Start-PSCountdown.md)
- [Start-PSCountdownTitle](Start-PSCountdownTitle.md)
