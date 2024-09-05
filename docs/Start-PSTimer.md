---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: https://github.com/jdhitsolutions/PSTimers/blob/master/docs/Start-PSTimer.md
schema: 2.0.0
---

# Start-PSTimer

## SYNOPSIS

Initiates a countdown before running a command.

## SYNTAX

```yaml
Start-PSTimer [[-Seconds] <Int32>] [[-ScriptBlock] <ScriptBlock>] [-ProgressBar] [-Title <String>] [-Clear] [-Message <String>] [<CommonParameters>]
```

## DESCRIPTION

This is a variation on the Start-Countdown script from Josh Atwell (http://www.vtesseract.com/post/21414227113/start-countdown-function-a-visual-for-start-sleep). It can be used instead of Start-Sleep and provides a visual countdown progress during "sleep" times. At the end of the countdown, your command will execute. Press the ESC key any time during the countdown to abort.

USING START-COUNTDOWN IN THE POWERSHELL ISE

Results will vary slightly in the PowerShell ISE. If you use this in the ISE, it is recommended to use -Clear.  You also cannot use the ESC key to abort the script if using the console. You'll need to press Ctrl+C. If using the progress bar, there is a Stop button in the ISE. If you abort in the ISE, you won't get the warning message.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Start-PSTimer -Seconds 10 -clear
```

This method will clear the screen and display descending seconds.

### EXAMPLE 2

```powershell
PS C:\> Start-PSTimer -Seconds 30 -ProgressBar -ScriptBlock {get-service -computername (get-content computers.txt)}
```

This method will display a progress bar on screen. At the end of the countdown the ScriptBlock will execute.

## PARAMETERS

### -Seconds

The number of seconds to countdown.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock

A PowerShell ScriptBlock to execute at the end of the countdown.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: GlobalBlock, sb

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressBar

Use a progress bar instead of the console.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title

The activity title, normally displayed at the top of the progress bar.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Countdown
Accept pipeline input: False
Accept wildcard characters: False
```

### -Clear

Clear the screen. Other wise, the countdown will use the current location.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message

The message to be displayed at the end of the countdown before any ScriptBlock is executed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

### [PSObject]

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Write-Progress]()

[Start-PSCountdown](Start-PSCountdown.md)

[Start-PSCountdownTimer](Start-PSCountdownTimer.md)
