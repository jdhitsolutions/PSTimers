---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version:
schema: 2.0.0
---

# Get-MyTimer

## SYNOPSIS

Get the current status of a simple timer.

## SYNTAX

```yaml
Get-MyTimer [[-Name] <String>] [-All] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get the current status of a timer created with Start-MyTimer. It will display a current elapsed time but will not stop the timer.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-MyTimer T2

Name Started             Elapsed 
---- -------             ------- 
T2   7/8/2017 8:30:46 AM 00:30:15.3344369
```

Get the current status of a timer called T2.

## PARAMETERS

### -Name

The name for your timer.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
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
