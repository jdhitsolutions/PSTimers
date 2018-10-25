---
external help file: PSTimers-help.xml
Module Name: pstimers
online version:
schema: 2.0.0
---

# Stop-MyTimer

## SYNOPSIS

Stop your simple timer.

## SYNTAX

```yaml
Stop-MyTimer [-Name] <String> [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will stop any timer created with Start-MyTimer. When executed it which will calculate a timespan and remove the timer variable. You can also opt to get the timespan as a string.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Stop-MyTimer Timer2 -passthru

Name            Start                  Duration         Running Description
----            -----                  --------         ------- -----------
t2              10/25/2018 9:37:18 AM  00:20:19.0345972   False
```

Stop a timer called Timer2

### EXAMPLE 2

```powershell
PS C:\> $report = import-csv s:\computers.csv | foreach -begin { Start-MyTimer T1; Write-Host "Starting the process" -foreground cyan } -process { Get-CimInstance win32_logicaldisk -computer $_.computername} -end { Write-Host "Finished! $((Stop-MyTimer T1 -passthru).duration)" -foreground cyan}

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

Required: True
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

### -Passthru

By default, the command does not write an object to the pipeline. Use -Passthru to force an object through.

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

### None

## OUTPUTS

### None

### MyTimer

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-MyTimer](Start-MyTimer.md)

[Get-MyTimer](Get-MyTimer.md)
