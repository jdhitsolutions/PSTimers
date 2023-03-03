---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: https://bit.ly/3T5ntz1
schema: 2.0.0
---

# Start-PSCountdownTimer

## SYNOPSIS

Start a WPF-based countdown timer.

## SYNTAX

```yaml
Start-PSCountdownTimer [[-Seconds] <Int32>] [-Message <String>] [-FontSize <Int32>] [-FontStyle <String>] [-FontWeight <String>] [-Color <String>] [-FontFamily <String>] [-OnTop] [-Position <Int32[]>] [-Alert <Int32>] [-AlertColor <String>] [-Warning <Int32>] [-WarningColor <String>] [<CommonParameters>]
```

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
PS C:\> $psCountDownClock.Color="darkgreen"
```

The first command starts a 10 minute countdown with a message prefix. The display will always be on top of other windows. The second command uses the synchronized hashtable to change the font color.

## PARAMETERS

### -Color

Specify a font color like Green or an HTML code like '#FF1257EA'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: White
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontFamily

Specify a font family.

```yaml
Type: String
Parameter Sets: (All)
Aliases: family

Required: False
Position: Named
Default value: Segoi UI
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontSize

Specify a font size.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: size

Required: False
Position: Named
Default value: 48
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontStyle

Specify a font style.

```yaml
Type: String
Parameter Sets: (All)
Aliases: style
Accepted values: Normal, Italic, Oblique

Required: False
Position: Named
Default value: Normal
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FontWeight

Specify a font weight.

```yaml
Type: String
Parameter Sets: (All)
Aliases: weight
Accepted values: Normal, Bold, Light

Required: False
Position: Named
Default value: Normal
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Message

Specify a short message prefix like 'Starting in: '

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

### -OnTop

Do you want the clock to always be on top?

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Position

Specify the clock position as an array of left and top values.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Seconds

Enter the number of seconds to countdown from.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Alert

Specify the number of seconds remaining to switch to alert coloring.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertColor

Specify alert coloring.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Yellow
Accept pipeline input: False
Accept wildcard characters: False
```

### -Warning

Specify the number of seconds remaining to switch to warning coloring.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -WarningColor

Specify warning coloring.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Red
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Int32

### System.Management.Automation.SwitchParameter

### System.Int32[]

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-PSCountdownTimer](Start-PSCountdownTimer.md)

[Start-PSCountdown](Start-PSCountdown.md)

[Start-PSTimer](Start-PSTimer.md)
