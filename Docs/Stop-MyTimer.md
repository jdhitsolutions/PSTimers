---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version:
schema: 2.0.0
---

# Stop-MyTimer

## SYNOPSIS

Stop your simple timer.

## SYNTAX

```yaml
Stop-MyTimer [[-Name] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will stop any timer created with Start-MyTimer. When executed it which will calculate a timespan and remove the timer variable. You can also opt to get the timespan as a string.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Stop-MyTimer Timer2

Days              : 0
Hours             : 0
Minutes           : 6
Seconds           : 10
Milliseconds      : 559
Ticks             : 3705590189
TotalDays         : 0.00428887753356481
TotalHours        : 0.102933060805556
TotalMinutes      : 6.17598364833333
TotalSeconds      : 370.5590189
TotalMilliseconds : 370559.0189
```

Stop a timer called Timer2

### EXAMPLE 2

```powershell
PS C:\> Stop-MyTimer -asString

00:01:34.0002109
```

Stop the timer using the default name of MyTimer and display the result as a string.

### EXAMPLE 3

```powershell
PS C:\> $report = import-csv s:\computers.csv | foreach -begin { Start-MyTimer T1 ; Write-Host "Starting the process" -foreground cyan } -process { Get-CimInstance win32_logicaldisk -computer $_.computername} -end { Write-Host "Finished! $(Stop-MyTimer T1 -asString)" -foreground cyan}

Starting the process
Finished!
00:00:29.1625955
```

Import a list of computers and get disk information for each one. The command uses a timer to measure how long the process took.

## PARAMETERS

### -Confirm

Prompt for confirmation before stopping the timer and removing the variable.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

The name for your timer.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: MyTimer
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf

Using this parameter will display what the final value would be but not actually stop it.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### [System.Timespan]

### [System.String]

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-MyTimer](Start-MyTimer.md)

[Get-MyTimer](Get-MyTimer.md)
