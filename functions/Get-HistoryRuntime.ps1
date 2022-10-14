Function Get-HistoryRuntime {

    [cmdletbinding(DefaultParameterSetName = "ID")]
    [OutputType([PSCustomObject])]
    [Alias("ghr")]

    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "Enter a history item ID",
            ParameterSetName = "ID"
        )]
        [int]$ID = (Get-History -count 1).ID,
        [Parameter(ValueFromPipeline, ParameterSetName = "History")]
        [Microsoft.PowerShell.Commands.HistoryInfo]$History,
        [Switch]$Detail
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
        Write-Verbose "[BEGIN  ] Using parameter set $($PSCmdlet.parameterSetName)"
    } #begin

    Process {

        Try {
            If ($PSCmdlet.ParameterSetName -eq "ID") {
                $History = Get-History -Id $ID -ErrorAction Stop
            }
            Write-Verbose "[PROCESS] Calculating runtime for id $($history.ID)"

            $propHash = [Ordered]@{
                ID      = $history.ID
                RunTime = $history.EndExecutionTime - $history.StartExecutionTime
            }

            if ($Detail) {
                Write-Verbose "[PROCESS] Adding history detail"
                $prophash.Add("Status", $History.ExecutionStatus)
                $propHash.Add("Command", $History.CommandLine)
            }
            #create an object
            New-Object -TypeName PSObject -Property $propHash

        } #Try
        Catch {
            Write-Warning "Failed to find history with an ID of $ID"
        }

    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end

}
