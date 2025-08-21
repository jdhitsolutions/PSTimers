Function Restart-MyTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None','MyTimer')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Restart a MyTimer object.'
        )]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({ $global:MyTimerCollection.values.where({ $_.status -eq 'Paused' }).Name.Foreach({ if ($_ -match '\s') { "'$_'" } else { $_ } }) })]
        [String]$Name,
        [Parameter(HelpMessage = 'Return the timer object after pausing it.')]
        [Switch]$PassThru
    )

    Begin {
        _verbose  ($strings.starting -f $MyInvocation.MyCommand)
        _verbose ($strings.Running -f $PSVersionTable.PSVersion)
        _verbose ($strings.Detected -f $host.Name)
    } #begin

    Process {
        $timer = $global:MyTimerCollection[$Name]
        if ($PSCmdlet.ShouldProcess($timer.name)) {
            $timer.RestartTimer()
            if ($PassThru) {
                Get-MyTimer -Name $timer.name
            }
        } #WhatIf
        _verbose "[$((Get-Date).TimeOfDay) PROCESS] Restarting timer $Name"
    } #process

    End {
        _verbose  ($strings.Ending -f  $MyInvocation.MyCommand)
    } #end

} #close Restart-MyTimer
