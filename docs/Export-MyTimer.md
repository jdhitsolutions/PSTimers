---
document type: cmdlet
external help file: PSTimers-help.xml
HelpUri: https://jdhitsolutions.com/yourls/f68c52
Locale: en-US
Module Name: PSTimers
PlatyPS schema version: 2024-05-01
---

# Export-MyTimer

## SYNOPSIS

Export a timer object to an XML file.

## SYNTAX

### Default (Default)

```yaml
Export-MyTimer [[-Name] <String>] -Path <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases:

- none

## DESCRIPTION

Use this command to export timer objects to a file. You might want to do this if the "timer" is still running and you will use it in a later PowerShell session.

The default behavior is to export all timer variables or you can select specific ones by name.

## EXAMPLES

### Example 1

```powershell
PS C:\> Export-MyTimer -path c:\work\MyTimers.xml
```

Export all timers to the specified file.

### Example 2

```powershell
PS C:\> Export-MyTimer T1 -path c:\work\T1.xml
```

Export a single timer.

## PARAMETERS

### -Confirm



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

The name of a timer to export. The default is to export all timers.

```yaml
Type: String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Path

The file name for the XML file to create.

```yaml
Type: String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WhatIf



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

### [String]

## OUTPUTS

### [None]

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

- [Get-MyTimer](Get-MyTimer.md)
- [Import-MyTimer](Import-MyTimer.md)
