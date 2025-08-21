---
external help file: PSTimers-help.xml
Module Name: PSTimers
online version: https://jdhitsolutions.com/yourls/b0617d
schema: 2.0.0
---

# Set-MyTimer

## SYNOPSIS

Modify a MyTimer object.

## SYNTAX

```yaml
Set-MyTimer [-Name] <String> [-NewName <String>] [-Start <DateTime>] [-Description <String>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to modify an existing timer. If you attempt to set a timer that doesn't exist, you will be prompted to create it.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-MyTimer T1 -description "updating module"
```

Modify the T1 timer with a new description

### Example 2

```powershell
PS C:\> Get-MyTimer foo | Set-MyTimer -newName Work1 -Start "12/17/22 9:00AM"
```

Get the timer called foo and give it a new name and start time.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Enter a new description for the timer object. If you want to clear the description use a value of " ".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Enter the name of the object to modify.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -NewName

Enter a new name for the timer object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Write the updated object to the pipeline.

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

### -Start

Update the start time for your timer object.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### MyTimer[]

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Get-MyTimer](Get-MyTimer.md)

[Start-MyTimer](Start-MyTimer.md)
