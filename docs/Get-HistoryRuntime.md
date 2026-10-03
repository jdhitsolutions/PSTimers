---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/e09388
Locale: en-US
Module Name: PSTimers
PlatyPS schema version: 2024-05-01
---

# Get-HistoryRuntime

## SYNOPSIS

Get a history runtime object.

## SYNTAX

### ID (Default)

```yaml
Get-HistoryRuntime [[-ID] <Int32>] [-Detail] [<CommonParameters>]
```

### History

```yaml
Get-HistoryRuntime [-History <HistoryInfo>] [-Detail] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases:

- `ghr`

## DESCRIPTION

Use this command to see how long something took to run in Windows PowerShell. Command history in PowerShell 7 includes the run time.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-HistoryRuntime

ID RunTime
-- -------
99 00:00:48.2156090
```

### Example 2

```powershell
PS C:\> Get-HistoryRuntime 25

ID RunTime
-- -------
25 00:00:00.3127817
```

### Example 3

```powershell
PS C:\> Get-History -count 10 | Get-HistoryRuntime

ID RunTime
 -- -------
 91 00:00:00.0380001
 92 00:00:00.0079856
 93 00:00:00.0839858
 94 00:00:00.0469834
 95 00:00:00.0539842
 96 00:00:00.0390021
 97 00:00:00.1570075
 98 00:00:00.0279998
 99 00:00:48.2156090
100 00:00:00.0280011
```

### Example 4

```powershell
PS C:\> Get-History -count 5 | Get-HistoryRuntime -detail

ID RunTime             Status Command
 -- -------             ------ -------
105 00:01:10.9210044 Completed Get-Service -comp chi-dc01,chi-dc02,chi-core01...
106 00:00:00.4872217 Completed Get-Service -comp chi-dc01,chi-dc02,chi-p50 | ...
107 00:00:03.2367861 Completed Get-CimInstance -comp chi-dc01,chi-p50,chi-dc0...
108 00:00:00.3980214 Completed ps
109 00:00:00.1019850 Completed Get-CimInstance -comp chi-dc01,chi-p50,chi-dc0...
```

## PARAMETERS

### -Detail

Include history detail in the result.

```yaml
Type: SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
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

### -History

Pass a history object to this command.

```yaml
Type: HistoryInfo
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: History
  Position: Named
  IsRequired: false
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ID

Enter a history item ID. The default is the last command executed.

```yaml
Type: Int32
DefaultValue: (Get-History -count 1).ID
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ID
  Position: 1
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

### [Int]

### [Microsoft.PowerShell.Commands.HistoryInfo]

## OUTPUTS

### PSCustomObject

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Get-History]()
