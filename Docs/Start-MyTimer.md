---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version:
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

This command starts a simple timer. You start it, which captures the current date and time, and stores the result in a global variable. You have the option of naming your timer which will allow you to have multiple timers running at the same time. You can also add a brief description.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Start-MyTimer
```

Start the timer with the default name of MyTimer.

### EXAMPLE 2

```powershell
PS C:\> Start-MyTimer Timer2

Name        : timer2
Start       : 7/17/2018 11:14:23 AM
Duration    : 00:00:00
Running     : True
Description :
```

Create a second timer called Timer2 and pass the object to the pipeline.

### EXAMPLE 3

```powershell 
PS C:\> start-mytimer Z -Description "work stuff"


Name        : Z
Start       : 7/17/2018 11:18:02 AM
Duration    : 00:00:00
Running     : True
Description : work stuff
```

Create a new timer with a description.

### EXAMPLE 4

```powershell
PS C:\> start-mytimer alpha,bravo,charlie

Name        : alpha
Start       : 7/17/2018 11:23:49 AM
Duration    : 00:00:00
Running     : True
Description :

Name        : bravo
Start       : 7/17/2018 11:23:49 AM
Duration    : 00:00:00
Running     : True
Description :

Name        : charlie
Start       : 7/17/2018 11:23:49 AM
Duration    : 00:00:00
Running     : True
Description :
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

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Stop-MyTimer](Stop-MyTimer.md)

[Get-MyTimer](Get-MyTimer.md)

