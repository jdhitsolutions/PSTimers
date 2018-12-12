---
external help file: PSTimers-help.xml
Module Name: pstimers
online version:
schema: 2.0.0
---

# Get-MyTimer

## SYNOPSIS

Get the current status of a simple timer.

## SYNTAX

```
Get-MyTimer [[-Name] <String[]>] [-All] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get the current status of a timer created with Start-MyTimer. It will display a current elapsed time but will not stop the timer.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-MyTimer Timer2

Name            Start                  Stop                   Duration         Running Description
----            -----                  ----                   --------         ------- -----------
timer2          12/12/2018 11:09:25 AM                        00:02:31.7254040    True
```

Get the current status of a timer called timer2.

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

### -All

Get all timers.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [System.String[]]

## OUTPUTS

### [System.Management.Automation.PSObject[]]

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-MyTimer](Start-MyTimer.md)

[Stop-MyTimer](Stop-MyTimer.md)
