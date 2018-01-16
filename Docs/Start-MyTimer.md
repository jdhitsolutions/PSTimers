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

```
Start-MyTimer [[-Name] <String[]>] [-Passthru] [<CommonParameters>]
```

## DESCRIPTION
This command starts a simple timer.
You start it, which captures the current date and time, and stores the result in a global variable. You have the option of naming your timer which will allow you to have multiple timers running at the same time.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Start-MyTimer
```

Start the timer with the default name of MyTimer.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Start-MyTimer Timer2 -passthru

Name                           Value
----                           -----
Timer2                         7/8/2016 8:44:35 AM
```

Create a second timer called Timer2 and pass the object to the pipeline.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\> Start-MyTimer A,B,C -Passthru

Name                           Value
----                           -----
A                              7/8/2016 9:11:21 AM
B                              7/8/2016 9:11:21 AM
C                              7/8/2016 9:11:21 AM
```

Create 3 timers at once.
They can be stopped separately.

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

### -Passthru
Pass the timer variable to the pipeline.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: none
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### [System.Management.Automation.PSVariable] when using -Passthru

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Stop-MyTimer]()

[Get-MyTimer]()

