---
external help file: PSTimers-help.xml
Module Name: pstimers
online version: https://bit.ly/3fEjR8n
schema: 2.0.0
---

# Stop-MyTimer

## SYNOPSIS

Stop your simple timer.

## SYNTAX

```yaml
Stop-MyTimer [-Name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will stop any timer created with Start-MyTimer. When executed it which will calculate a final duration timespan, mark the timer as no longer running and remove the timer variable. Although you can still get the timer with Get-Timer.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Stop-MyTimer Timer2


Name        : timer2
Start       : 12/12/2022 11:09:25 AM
End         : 12/12/2022 11:17:34 AM
Duration    : 00:08:08.6042323
Description :
```

Stop a timer called Timer2.

### EXAMPLE 2

```powershell
PS C:\> $report = import-csv s:\company.csv | foreach -begin { Start-MyTimer T10; Write-Host "Starting the process" -foreground cyan } -process { Get-CimInstance win32_logicaldisk -computer $_.computername} -end { Write-Host "Finished! $((Stop-MyTimer T10).duration.toString())" -foreground cyan}

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### MyTimer

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-MyTimer](Start-MyTimer.md)

[Get-MyTimer](Get-MyTimer.md)
