---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/b7f5ec
Module Name: PSTimers
PlatyPS schema version: 2024-05-01
---

# Stop-MyTimer

## SYNOPSIS

Stop your simple timer.

## SYNTAX

### Default (Default)

```yaml
Stop-MyTimer [-Name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases:

- `toff`

## DESCRIPTION

This command will stop any timer created with Start-MyTimer. When executed it which will calculate a final duration timespan, mark the timer as no longer running and remove the timer variable. Although you can still get the timer with Get-Timer.

## EXAMPLES

### Example 1

```powershell
PS C:\> Stop-MyTimer Timer2


Name        : timer2
Start       : 03/12/2025 11:09:25 AM
End         : 03/12/2025 11:17:34 AM
Duration    : 00:08:08.6042323
Description :
```

Stop a timer called Timer2.

### Example 2

```powershell
PS C:\> $report = Import-Xsv s:\company.csv | Foreach-Object -begin { Start-MyTimer T10; Write-Host "Starting the process" -foreground cyan } -process { Get-CimInstance win32_logicaldisk -computer $_.computername} -end { Write-Host "Finished! $((Stop-MyTimer T10).duration.toString())" -foreground cyan}

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
DefaultValue: False
SupportsWildcards: false
Aliases:
- cf
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

The name for your timer.

```yaml
Type: String
DefaultValue: MyTimer
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WhatIf

Using this parameter will display what the final value would be but not actually stop it.

```yaml
Type: SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- wi
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### MyTimer

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Start-MyTimer](Start-MyTimer.md)
- [Get-MyTimer](Get-MyTimer.md)
