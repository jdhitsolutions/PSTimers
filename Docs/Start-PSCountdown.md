---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: 
schema: 2.0.0
---

# Start-PSCountdown

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### minutes (Default)
```
Start-PSCountdown [[-Minutes] <Int32>] [-Title <String>] [[-Message] <String>] [-ClearHost] [-Path <String>]
 [-ProgressStyle <String>] [<CommonParameters>]
```

### time
```
Start-PSCountdown [[-Time] <DateTime>] [-Title <String>] [[-Message] <String>] [-ClearHost] [-Path <String>]
 [-ProgressStyle <String>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

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
Enter the number of minutes to countdown (1-60).
The default is 5.

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
Select a progress bar style.
This only applies when using the PowerShell console or ISE.

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
[Start-PSTimer]()
