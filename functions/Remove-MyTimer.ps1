Function Remove-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("None")]
    Param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullorEmpty()]
        [string[]]$Name
    )
    Begin {
        Write-Verbose "Starting: $($MyInvocation.Mycommand)"
    }   #begin
    Process {
        #display PSBoundparameters formatted nicely for Verbose output
        [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
        Write-Verbose "PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"
        foreach ($timer in $Name) {
            Try {
                if ($PSCmdlet.ShouldProcess($timer)) {
                    Write-Verbose "Removing timer $timer"
                    if ($global:mytimercollection.ContainsKey("$timer")) {
                        $global:mytimercollection.remove("$timer")
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
        Write-Verbose "Ending: $($MyInvocation.Mycommand)"
    } #end
}
