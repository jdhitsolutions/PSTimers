---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: 
schema: 2.0.0
---

# Find-MyTimer

## SYNOPSIS
Find likely timer variables

## SYNTAX

```
Find-MyTimer [<CommonParameters>]
```

## DESCRIPTION
Use this command when you have forgotten the names of timers you created with Start-MyTimer. The command will search variables looking for any that have a datetime value and are Read-Only.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Find-MyTimer

Name
----
A   
B   
C   
T2
```

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Find-MyTimer | Get-MyTimer

Name Started             Elapsed         
---- -------             -------         
A    7/8/2017 9:11:21 AM 00:27:25.1536622
B    7/8/2017 9:11:21 AM 00:27:25.1806823
C    7/8/2017 9:11:21 AM 00:27:25.1886816
T2   7/8/2017 8:30:46 AM 01:08:00.5404410
```

Discover current timer variables and get their status.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### none

## OUTPUTS

### [System.String[]]

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Start-MyTimer]()

[Get-MyTimer]()

