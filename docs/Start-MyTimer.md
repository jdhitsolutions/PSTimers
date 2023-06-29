---
external help file: PSTimers-help.xml
Module Name: pstimers
online version: https://bit.ly/3CjFNNF
schema: 2.0.0
---

# Start-MyTimer

## SYNOPSIS

Start a simple timer.

## SYNTAX

```yaml
Start-MyTimer [[-Name] <String[]>] [-Description <String>] [<CommonParameters>]
```

## DESCRIPTION

This command starts a simple timer. You start it, which captures the current date and time, and stores the result in a global variable. You have the option of naming your timer which will allow you to have multiple timers running at the same time. Timer names must be unique. You can also add a brief description.

Timers are managed through two hashtables created as global variables, $MyTimerCollection and $MyWatchCollection. Do not delete these variables. The MyTimer commands will update these hashtables as needed.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Start-MyTimer
```

Start the timer with the default name of MyTimer.

### EXAMPLE 2

```powershell
PS C:\> Start-MyTimer Timer2

Name            Start                  Stop                   Duration         Running Description
----            -----                  ----                   --------         ------- -----------
timer2          12/12/2022 11:09:25 AM                        00:00:00            True
```

Create a second timer called Timer2.

### EXAMPLE 3

```powershell
PS C:\> Start-MyTimer Z -Description "work stuff"


Name            Start                  Stop                   Duration         Running Description
----            -----                  ----                   --------         ------- -----------
Z               12/12/2022 11:10:16 AM                        00:00:00            True work stuff
```

Create a new timer with a description.

### EXAMPLE 4

```powershell
PS C:\> Start-MyTimer alpha,bravo,charlie


Name            Start                  Stop                   Duration         Running Description
----            -----                  ----                   --------         ------- -----------
a               12/12/2022 11:11:10 AM                        00:00:00            True
b               12/12/2022 11:11:10 AM                        00:00:00            True
c               12/12/2022 11:11:10 AM                        00:00:00            True
```

Create multiple timers at once.

## PARAMETERS

### -Name

The name for your timer.
You can create multiple timers at the same time.
See examples.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: MyTimer
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Enter an optional description for this timer.

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

### [MyTimer]

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Stop-MyTimer](Stop-MyTimer.md)

[Get-MyTimer](Get-MyTimer.md)
