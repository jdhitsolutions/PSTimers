Function Resume-MyTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None','MyTimer')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Resume a MyTimer object.'
        )]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({$global:MyTimerCollection.values.where({$_.status -eq 'Paused'}).Name.Foreach({ if ($_ -match "\s") {"'$_'"} else {$_}})})]
        [String]$Name,
        [Parameter(HelpMessage = 'Return the timer object after pausing it.')]
        [Switch]$PassThru
    )

    Begin {
        _verbose ($strings.Starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.Name)
    } #begin

    Process {
        $timer = $global:MyTimerCollection[$Name]
        if ($timer.Status -eq 'Paused') {
            if ($PSCmdlet.ShouldProcess($timer.name)) {
                $timer.ResumeTimer()
                if ($PassThru) {
                    Get-MyTimer -Name $timer.name
                }
            } #WhatIf
        }
        else {
            Write-Warning ($strings.WarnResume -f $timer.name,$timer.Status)
        }
        _verbose ($strings.Pausing -f $Name)

    } #process

    End {
        _verbose ($strings.Ending -f  $MyInvocation.MyCommand)
    } #end

} #close Resume-MyTimer
