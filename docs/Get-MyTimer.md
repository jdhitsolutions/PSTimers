---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/ce9b5e
Locale: en-US
Module Name: PSTimers
PlatyPS schema version: 2024-05-01
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

## ALIASES

This cmdlet has the following aliases:

- none

## DESCRIPTION

Use this command to get the current status of a timer created with Start-MyTimer. It will display a current elapsed time but will not stop the timer.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-MyTimer

Name                Start                Stop                Duration     Status
----                -----                ----                --------     ------
ScriptWork          3/4/2026 7:37:36 PM                      00:00:00:10  Paused
Betty               3/5/2026 9:57:34 AM  3/5/2026 9:57:54 AM 00:00:00:00   Reset
Client1             3/5/2026 10:29:28 AM                     00:00:05:07 Running
Backup              3/5/2026 10:30:15 AM                     00:00:04:20 Running
```

Get the all MyTimer timers.

### Example 2

```powershell
PS C:\> Get-MyTimer Client1

Name             Start                Stop Duration     Status Description
----             -----                ---- --------     ------ -----------
Client1          3/5/2026 10:29:28 AM      00:00:01:43 Running work for Client1
```

Get a single timer.

### Example 3

```powershell
PS C:\> Get-MyTimer -Status Running

Name    Start                Stop Duration     Status Description
----    -----                ---- --------     ------ -----------
Client1 3/5/2026 10:29:28 AM      00:00:00:57 Running work for Client1
Backup  3/5/2026 10:30:15 AM      00:00:00:10 Running
```

Get timers based on status.

## PARAMETERS

### -Name

The name for your timer.

```yaml
Type: String[]
DefaultValue: None
SupportsWildcards: true
Aliases: []
ParameterSets:
- Name: name
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Status

Filter timers based on status.

```yaml
Type: String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: status
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

### [System.String[]]

## OUTPUTS

### MyTimer[]

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Start-MyTimer](Start-MyTimer.md)
- [Stop-MyTimer](Stop-MyTimer.md)
