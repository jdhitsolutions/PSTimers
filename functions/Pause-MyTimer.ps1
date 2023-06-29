Function Suspend-MyTimer {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None','MyTimer')]
    [alias('Pause-MyTimer')]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Pause a MyTimer object.'
        )]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({$global:MyTimerCollection.values.where({$_.status -eq 'Running'}).Name.Foreach({ if ($_ -match "\s") {"'$_'"} else {$_}})})]
        [String]$Name,
        [Parameter(HelpMessage = 'Return the timer object after pausing it.')]
        [Switch]$PassThru
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
    } #begin

    Process {
        $timer = $global:MyTimerCollection[$Name]
        if ($timer.Status -eq 'Running') {
            if ($PSCmdlet.ShouldProcess($timer.name)) {
                $timer.PauseTimer()
                if ($PassThru) {
                    Get-MyTimer -Name $timer.name
                }
            } #WhatIf
        }
        else {
            Write-Warning "You can only pause a running timer. The timer '$($timer.name)' has a status of $($timer.Status)."
        }
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Pausing timer $Name"

    } #process

    End {

        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Suspend-MyTimer