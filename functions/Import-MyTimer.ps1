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

    Write-Verbose "Starting: $($MyInvocation.MyCommand)"
    Write-Verbose "Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"

    $Imports = Import-Clixml -Path $Path
    Write-Verbose "Importing $($Imports.count) timer(s)"
    foreach ($Import in $Imports) {
        Write-Verbose "Importing $($Import.name)"
        $import | Select-Object * | Out-String | Write-Verbose
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
            Write-Verbose "Setting status to $($import.status)"
            $in.Status = $Import.Status
        }
        if ($PSCmdlet.ShouldProcess($Import.name)) {
            Write-Verbose 'Creating:'
            $in | Select-Object -Property * | Out-String | Write-Verbose

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

    Write-Verbose "Ending: $($MyInvocation.MyCommand)"
}
