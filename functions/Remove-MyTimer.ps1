Function Remove-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("None")]
    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name
    )
    Begin {
        Write-Verbose "Starting: $($MyInvocation.MyCommand)"
    }   #begin
    Process {
        #display PSBoundParameters formatted nicely for Verbose output
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"
        foreach ($timer in $Name) {
            Try {
                if ($PSCmdlet.ShouldProcess($timer)) {
                    Write-Verbose "Removing timer $timer"
                    if ($global:MyTimerCollection.ContainsKey("$timer")) {
                        $global:MyTimerCollection.remove("$timer")
                    }
                    else {
                        Write-Warning "Can't find a timer with the name $timer"
                    }
                }
            }
            Catch {
                Write-Warning "Failed to remove timer $timer. $($_.exception.message)"
            }
        } #foreach
    } #process
    End {
        Write-Verbose "Ending: $($MyInvocation.MyCommand)"
    } #end
}
