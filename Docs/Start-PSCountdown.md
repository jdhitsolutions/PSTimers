---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version:
schema: 2.0.0
---

# Start-PSCountdown

## SYNOPSIS

Start a graphical countdown display.

## SYNTAX

### minutes (Default)

```yaml
Start-PSCountdown [[-Minutes] <Int32>] [-Title <String>] [[-Message] <String>] [-ClearHost] [-Path <String>]
 [-ProgressStyle <String>] [<CommonParameters>]
```

### time

```yaml
Start-PSCountdown [[-Time] <DateTime>] [-Title <String>] [[-Message] <String>] [-ClearHost] [-Path <String>]
 [-ProgressStyle <String>] [<CommonParameters>]
```

## DESCRIPTION

This command will display countdown progress bar using Write-Progress. You can set the timer for a specific time or number of minutes. The countdown includes humorous items to indicate time passing. These items are drawn from an included list but you can specify a path to custom items.

Start-PSCountdown is inspired from code originally published at: 
https://github.com/Windos/powershell-depot/blob/master/livecoding.tv/StreamCountdown/StreamCountdown.psm1

This command should work in Windows PowerShell and PowerShell Core, although not in VS Code.
The ProgressStyle parameter is dynamic and only appears if you are running the command in a Windows console.

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-PSCountdown -minutes 5
```

Start a countdown display set to expire in 5 minutes.

### Example 2

```powershell
PS C:\> Start-PSCountdown -time 9:00AM -title "Welcome Back" -message "Review your class notes and have questions ready" -clearhost -progressStyle random
```

Start a countdown timer to 9:00AM. The screen will be cleared and the progress bar color will cycle through a random set of colors.

## PARAMETERS

### -ClearHost

Use this parameter to clear the screen prior to starting the countdown.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

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

The path to a text list of pseudo-tasks

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

Select a progress bar style. This only applies when using the Windows PowerShell console or ISE.

Default - use the current value of $host.PrivateData.ProgressBarBackgroundColor

Transparent - set the progress bar background color to the same as the console

Random - randomly cycle through a list of console colors

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-PSTimer](Start-PSTimer.md)
