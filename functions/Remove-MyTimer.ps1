Function Remove-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
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
        Write-Verbose "Starting: $($MyInvocation.MyCommand)"
    }   #begin
    Process {
        Write-Verbose "Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
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
                    if ($global:MyWatchCollection.ContainsKey("$timer")) {
                        $global:MyWatchCollection.remove("$timer")
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
