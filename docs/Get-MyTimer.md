---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: https://github.com/jdhitsolutions/PSTimers/blob/master/docs/Get-MyTimer.md
schema: 2.0.0
---

# Get-MyTimer

## SYNOPSIS

Get the current status of a simple timer.

## SYNTAX

### name (Default)

```yaml
Get-MyTimer [[-Name] <String[]>] [<CommonParameters>]
```

### status

```yaml
Get-MyTimer [-Status <String>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get the current status of a timer created with Start-MyTimer. It will display a current elapsed time but will not stop the timer.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-MyTimer

Name                Start                Stop                Duration     Status
----                -----                ----                --------     ------
ScriptWork 3/4/2023 7:37:36 PM                      00:00:00:10  Paused
Betty               3/5/2023 9:57:34 AM  3/5/2023 9:57:54 AM 00:00:00:00   Reset
Client1    3/5/2023 10:29:28 AM                     00:00:05:07 Running
Backup     3/5/2023 10:30:15 AM                     00:00:04:20 Running
```

Get the all timers

### EXAMPLE 2

```powershell
PS C:\> Get-MyTimer Client1

Name             Start                Stop Duration     Status Description
----             -----                ---- --------     ------ -----------
Client1 3/5/2023 10:29:28 AM      00:00:01:43 Running work for Client1

```

Get a single timer.

### EXAMPLE 3

```powershell
PS C:\> Get-Mytimer -Status Running

Name    Start                Stop Duration     Status Description
----    -----                ---- --------     ------ -----------
Client1 3/5/2023 10:29:28 AM      00:00:00:57 Running work for Client1
Backup  3/5/2023 10:30:15 AM      00:00:00:10 Running
```

Get timers based on status.

## PARAMETERS

### -Name

The name for your timer.

```yaml
Type: String[]
Parameter Sets: name
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Status

Filter timers based on status.

```yaml
Type: String
Parameter Sets: status
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

### [System.String[]]

## OUTPUTS

### MyTimer[]

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-MyTimer](Start-MyTimer.md)

[Stop-MyTimer](Stop-MyTimer.md)
