---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version:
schema: 2.0.0
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

## DESCRIPTION

Use this command to see how long something took to run in PowerShell.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-HistoryRuntime

ID RunTime
-- -------
99 00:00:48.2156090
```

### EXAMPLE 2

```powershell
PS C:\> Get-HistoryRuntime 25

ID RunTime
-- -------
25 00:00:00.3127817
```

### EXAMPLE 3

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

### EXAMPLE 4

```powershell
Get-History -count 5 | Get-HistoryRuntime -detail

ID RunTime             Status Command
 -- -------             ------ -------
105 00:01:10.9210044 Completed get-service -comp chi-dc01,chi-dc02,chi-core01...
106 00:00:00.4872217 Completed get-service -comp chi-dc01,chi-dc02,chi-p50 | ...
107 00:00:03.2367861 Completed get-ciminstance -comp chi-dc01,chi-p50,chi-dc0...
108 00:00:00.3980214 Completed ps
109 00:00:00.1019850 Completed get-ciminstance -comp chi-dc01,chi-p50,chi-dc0...
```

## PARAMETERS

### -ID

Enter a history item ID. The default is the last command executed.

```yaml
Type: Int32
Parameter Sets: ID
Aliases:

Required: False
Position: 1
Default value: (Get-History -count 1).ID
Accept pipeline input: False
Accept wildcard characters: False
```

### -History

Pass a history object to this command.

```yaml
Type: HistoryInfo
Parameter Sets: History
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Detail

Include history detail in the result.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [Int] or [Microsoft.PowerShell.Commands.HistoryInfo]

## OUTPUTS

### [PSCustomObject}

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-History]()

