---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/6b13bb
Module Name: PSTimers
PlatyPS schema version: 2024-05-01
---

# Start-PSTimer

## SYNOPSIS

Initiates a countdown before running a command.

## SYNTAX

### Default (Default)

```yaml
Start-PSTimer [[-Seconds] <Int32>] [[-ScriptBlock] <ScriptBlock>] [-ProgressBar] [-Title <String>]
 [-Clear] [-Message <String>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases:

- `spst`

## DESCRIPTION

This is a variation on the Start-Countdown script from Josh Atwell. It can be used instead of Start-Sleep and provides a visual countdown progress during "sleep" times. At the end of the countdown, your command will execute. Press the ESC key any time during the countdown to abort.

USING START-COUNTDOWN IN THE POWERSHELL ISE

Results will vary slightly in the PowerShell ISE. If you use this in the ISE, it is recommended to use -Clear.  You also cannot use the ESC key to abort the script if using the console. You'll need to press Ctrl+C. If using the progress bar, there is a Stop button in the ISE. If you abort in the ISE, you won't get the warning message.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSTimer -Seconds 10 -clear
```

This method will clear the screen and display descending seconds.

### Example 2

```powershell
PS C:\> Start-PSTimer -Seconds 30 -ProgressBar -ScriptBlock {Get-Service -computername (Get-Content computers.txt)}
```

This method will display a progress bar on screen. At the end of the countdown the ScriptBlock will execute.

## PARAMETERS

### -Clear

Clear the screen. Other wise, the countdown will use the current location.

```yaml
Type: SwitchParameter
DefaultValue: False
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

### -Message

The message to be displayed at the end of the countdown before any ScriptBlock is executed.

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

### -ProgressBar

Use a progress bar instead of the console.

```yaml
Type: SwitchParameter
DefaultValue: False
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

### -ScriptBlock

A PowerShell ScriptBlock to execute at the end of the countdown.

```yaml
Type: ScriptBlock
DefaultValue: None
SupportsWildcards: false
Aliases:
- GlobalBlock
- sb
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Seconds

The number of seconds to countdown.

```yaml
Type: Int32
DefaultValue: 10
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

### -Title

The activity title, normally displayed at the top of the progress bar.

```yaml
Type: String
DefaultValue: Countdown
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

### [PSObject]

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Write-Progress]()
- [Start-PSCountdown](Start-PSCountdown.md)
- [Start-PSCountdownTimer](Start-PSCountdownTimer.md)
