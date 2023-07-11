Function Export-MyTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter a MyTimer name.'
        )]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({$global:MyTimerCollection.values.Name.Foreach({ if ($_ -match "\s") {"'$_'"} else {$_}})})]
        [String]$Name,
        [Parameter(
            Mandatory,
            HelpMessage = 'Enter the name and path of an XML file'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('\.xml$')]
        [String]$Path
    )

    Begin {
        Write-Verbose "Starting: $($MyInvocation.MyCommand)"
        $found = [System.Collections.Generic.list[object]]::new()
    }
    Process {
        Write-Verbose "Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
        if ($Name) {
            Write-Verbose "Finding timer variable $Name"
            $found.Add($global:MyTimerCollection["$name"])
        }
        else {
            Write-Verbose 'Finding all timer variables'
            $found.AddRange([object[]]$global:MyTimerCollection.values)
        }
    } #process
    End {
        If ($found) {
            Try {
                Write-Verbose "Exporting $($found.count) timer(s) to $Path"
                $found | Export-Clixml -Path $path -ErrorAction Stop
            }
            Catch {
                Write-Error $_
            }
        }
        else {
            Write-Warning 'No matching timers found.'
        }
        Write-Verbose "Ending: $($MyInvocation.MyCommand)"
    }

}
