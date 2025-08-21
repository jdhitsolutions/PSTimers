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
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.Name)
        $found = [System.Collections.Generic.list[object]]::new()
    }
    Process {
        if ($Name) {
            _verbose ($strings.FindingVar -f $Name)
            $found.Add($global:MyTimerCollection["$name"])
        }
        else {
            _verbose $strings.FindingAllVar
            $found.AddRange([object[]]$global:MyTimerCollection.values)
        }
    } #process
    End {
        If ($found) {
            Try {
                _verbose ($strings.ExportingTimerCount -f $found.count,$Path)
                $found | Export-Clixml -Path $path -ErrorAction Stop
            }
            Catch {
                Write-Error $_
            }
        }
        else {
            Write-Warning $strings.WarnNoTimers
        }
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    }
}
