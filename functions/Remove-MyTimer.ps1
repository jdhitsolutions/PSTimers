Function Remove-MyTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("None")]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name
    )
    Begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.Name)
    }   #begin
    Process {
        _verbose "$($strings.UsingParams) `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
        foreach ($timer in $Name) {
            Try {
                if ($PSCmdlet.ShouldProcess($timer)) {
                    _verbose ($status.RemovingTimer -f $timer)
                    if ($global:MyTimerCollection.ContainsKey("$timer")) {
                        $global:MyTimerCollection.remove("$timer")
                    }
                    else {
                        Write-Warning ($strings.WarnNoNamedTimer -f $timer)
                    }
                    if ($global:MyWatchCollection.ContainsKey("$timer")) {
                        $global:MyWatchCollection.remove("$timer")
                    }
                }
            }
            Catch {
                Write-Warning ($strings.FailedRemoveTimer -f $timer,$_.exception.message)
            }
        } #foreach
    } #process
    End {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end
}
