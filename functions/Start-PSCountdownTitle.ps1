Function Start-PSCountdownTitle {
    [cmdletbinding()]
    [OutputType('None')]
    [Alias('TitleCountdown')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'The number of seconds for the countdown.'
        )]
        [ValidateScript({ $_ -gt 0 })]
        [int32]$Seconds,

        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Specify the text to display before the countdown in 16 characters or less.'
        )]
        [ValidateLength(1, 16)]
        [string]$CountdownText,


        [Parameter(
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Specify the text to display after the countdown completes in 25 characters or less.'
        )]
        [ValidateLength(1, 25)]
        [string]$PostCountdownText,

        [Parameter(
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Specify the number of seconds to wait before restoring the original title. Set to -1 to leave the title as is after the countdown completes.'
        )]
        [ValidateNotNullOrEmpty()]
        [int32]$Wait = 10
    )

    Begin {
        _verbose  ($strings.starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.name)

        #define the script block to be run as a ThreadJob
        $sb = {
            Param($Seconds, $CountdownText, $PostCountdownText, $Wait)
            $save = [console]::Title

            do {
                [console]::Title = '{0} {1}' -f $CountdownText, [timespan]::new(0, 0, $Seconds).ToString()
                Start-Sleep -Seconds 1
                $Seconds--
            } while ($Seconds -gt 0)
            [console]::Title = [console]::Title = $PostCountdownText

            if ($Wait -gt 0) {
                Start-Sleep -Seconds $Wait
                [console]::Title = $save
            }
            else {
                #do nothing, just leave the title as is
            }
        }
    } #begin

    Process {
        if ($host.name -eq 'ConsoleHost') {
            _verbose ($strings.StartTitleCountdown -f (New-TimeSpan -Seconds $Seconds) )

            Write-Information -MessageData $myInvocation -Tags process
            Write-Information -MessageData $PSBoundParameters -Tags process
            $job = Start-ThreadJob $sb -ArgumentList $Seconds, $CountdownText, $PostCountdownText, $Wait
            Write-Information -MessageData $job -Tags process
            _verbose "Job ID: $($job.Id)"
        }
        else {
            Write-Warning $strings.InvalidHost
        }
    } #process

    End {
        _verbose  ($strings.Ending -f  $MyInvocation.MyCommand)
    } #end

} #close Start-PSCountdownTitle