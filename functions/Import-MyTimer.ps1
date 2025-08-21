Function Import-MyTimer {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('MyTimer')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'Enter the name and path of an XML file'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {
            if (Test-Path $_) {
                $True
            }
            else {
                Throw "Cannot validate path $_"
            }
        })]
        [String]$Path
    )

    _verbose ($strings.Starting -f $MyInvocation.MyCommand)
    _verbose ($strings.Running -f $PSVersionTable.PSVersion)
    _verbose ($strings.Detected -f $host.Name)

    $Imports = Import-Clixml -Path $Path
    _verbose ($strings.ImportingCount -f $imports.count)
    foreach ($Import in $Imports) {
        _verbose ($strings.Importing -f $Import.name)
        $import | Select-Object * | Out-String | _verbose
        $in = [MyTimer]::New()
        $in.Name = $Import.Name
        $in.Start = $Import.Start
        $in.End = $Import.End
        $in.Duration = $Import.Duration
        $in.Running = $Import.Running
        $in.Description = $Import.Description
        $in.ImportedDuration = $Import.Duration
        #previous exports might not have this property
        if ($Import.Status -ge 0) {
            _verbose "Setting status to $($import.status)"
            $in.Status = $Import.Status
        }
        if ($PSCmdlet.ShouldProcess($Import.name)) {
            _verbose $strings.Creating
            $in | Select-Object -Property * | Out-String | _verbose

            Try {
                [void](Get-Variable MyTimerCollection -Scope global -ErrorAction Stop)
            }
            Catch {
                New-Variable -Scope global -Name MyTimerCollection -Value @{}
            }
            #reuse existing timers if found
            if ($global:MyTimerCollection.ContainsKey($In.name)) {
                $global:MyTimerCollection[$in.name] = $in
            }
            else {
                $global:MyTimerCollection.add($in.name, $in)
            }
            #Recreate the stopwatch
            If (-Not $global:MyWatchCollection) {
                $global:MyWatchCollection = @{}
            }
            $global:MyWatchCollection[$in.Name] = [System.Diagnostics.Stopwatch]::New()
            If ($In.Status -eq 'Running') {
                $in.StartTimer()
            }
            Get-MyTimer $in.Name
        } #WhatIf
    }

    _verbose ($strings.Ending -f $MyInvocation.MyCommand)
}
