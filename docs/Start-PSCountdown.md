---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: https://github.com/jdhitsolutions/PSTimers/blob/master/docs/Start-PSCountdown.md
schema: 2.0.0
---

# Start-PSCountdown

## SYNOPSIS

Start a graphical countdown display using Write-Progress

## SYNTAX

### minutes (Default)

```yaml
Start-PSCountdown [[-Minutes] <Int32>] [-Title <String>] [[-Message] <String>] [-ClearHost]  [-ProgressStyle <String>] [-Path <String>] [<CommonParameters>]
```

### time

```yaml
Start-PSCountdown [[-Time] <DateTime>] [-Title <String>] [[-Message] <String>] [-ClearHost] [-ProgressStyle <String>] [-Path <String>] [<CommonParameters>]
```

## DESCRIPTION

This command will display countdown progress bar using Write-Progress. You can set the timer for a specific time or number of minutes. The countdown includes humorous items to indicate time passing. These items are drawn from an included list but you can specify a path to custom items.

Start-PSCountdown is inspired from code originally published at: https://github.com/Windos/powershell-depot/blob/master/livecoding.tv/StreamCountdown/StreamCountdown.psm1

This command should work in Windows PowerShell and PowerShell Core, although not in VS Code. If you are running this on a non-Windows platform, you should be running at least PowerShell 7.2.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSCountdown -minutes 5
```

Start a countdown display set to expire in 5 minutes. This will use the default values for Title and Message.

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
Parameter Sets: (All)
Aliases: cls

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message

Enter a primary message to display in the parent window.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minutes

Enter the number of minutes to countdown (1-60). The default is 5.

```yaml
Type: Int32
Parameter Sets: minutes
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

The path to a text list of pseudo-tasks. By default the command will use the list provided with the module but you can specify your own list. One item per list. Prefix a line with a # to comment it out.

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

### -ProgressStyle

Select a progress bar style.

Default - use the current value of $host.PrivateData.ProgressBarBackgroundColor

Transparent - set the progress bar background color to the same as the console. This has no effect in PowerShell 7 when using PSStyle settings unless you switch the view to Classic.

Random - randomly cycle through a list of console colors. This has no practical effect on Linux platforms when the $PSStyle.Progress.View is set to Classic, depending on the PowerShell version.

The parameter has an alias of style. Note that the final effect may depend on a combination of your platform and console. Running this in a traditional console vs Windows Terminal may yield different results. Running on non-Windows may add another factor.

```yaml
Type: String
Parameter Sets: (All)
Aliases: style
Accepted values: Default, Random, Transparent

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Time

Enter a datetime value as the countdown target.

```yaml
Type: DateTime
Parameter Sets: time
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title

Enter the text for the progress bar title.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-PSTimer](Start-PSTimer.md)

[Start-PSCountdownTimer](Start-PSCountdownTimer.md)
