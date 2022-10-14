---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: https://bit.ly/3ehUQ2D
schema: 2.0.0
---

# Get-MyTimer

## SYNOPSIS

Get the current status of a simple timer.

## SYNTAX

```yaml
Get-MyTimer [[-Name] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get the current status of a timer created with Start-MyTimer. It will display a current elapsed time but will not stop the timer.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-MyTimer

Name            Start                  Stop                   Duration         Running Description
----            -----                  ----                   --------         ------- -----------
foo             1/8/2019 10:03:05 AM   1/8/2019 10:03:46 AM   00:00:41.4660786   False something
test            1/8/2019 10:03:13 AM   1/8/2019 10:03:59 AM   00:00:46.9185655   False
test2           1/8/2019 10:03:13 AM                          00:01:07.5290466    True
```

Get the all timers

### EXAMPLE 2

```powershell
PS C:\> Get-MyTimer test2

Name            Start                  Stop                   Duration         Running Description
----            -----                  ----                   --------         ------- -----------
test2           1/8/2019 10:03:13 AM                          00:01:37.5283112    True
```

Get a single timer.

## PARAMETERS

### -Name

The name for your timer.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [System.String[]]

## OUTPUTS

### MyTimer[]

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-MyTimer](Start-MyTimer.md)

[Stop-MyTimer](Stop-MyTimer.md)
