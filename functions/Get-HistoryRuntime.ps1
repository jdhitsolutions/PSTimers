Function Get-HistoryRuntime {
    [CmdletBinding(DefaultParameterSetName = "ID")]
    [OutputType([PSCustomObject])]
    [Alias("ghr")]

    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "Enter a history item ID",
            ParameterSetName = "ID"
        )]
        [Int]$ID = (Get-History -count 1).ID,
        [Parameter(ValueFromPipeline, ParameterSetName = "History")]
        [Microsoft.PowerShell.Commands.HistoryInfo]$History,
        [Switch]$Detail
    )

    Begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.Name)
    } #begin

    Process {
        Write-Debug $strings.UsingParams
        (New-Object PSObject -Property $PSBoundParameters | Out-String) | Write-Debug
        Try {
            If ($PSCmdlet.ParameterSetName -eq "ID") {
                $History = Get-History -Id $ID -ErrorAction Stop
            }
            _verbose ($strings.Calculating -f $history.ID)

            $propHash = [Ordered]@{
                ID      = $history.ID
                RunTime = $history.EndExecutionTime - $history.StartExecutionTime
            }

            if ($Detail) {
                _verbose $strings.AddingDetail
                $propHash.Add("Status", $History.ExecutionStatus)
                $propHash.Add("Command", $History.CommandLine)
            }
            #create an object
            New-Object -TypeName PSObject -Property $propHash

        } #Try
        Catch {
            Write-Warning ($strings.FailedFindHistory -f $ID)
        }

    } #process

    End {
        _verbose ($strings.Ending -f $MyInvocation.MyCommand)
    } #end

}
