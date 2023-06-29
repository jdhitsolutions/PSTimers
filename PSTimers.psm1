#a class definition for the MyTimer commands

enum MyTimerStatus {
    Stopped
    Running
    Paused
    Reset
}

Class MyTimer {
    [String]$Name
    [DateTime]$Start
    [DateTime]$End
    [TimeSpan]$Duration
    [Boolean]$Running
    [String]$Description
    [MyTimerStatus]$Status
    #this property is used when importing timers
    hidden [TimeSpan]$ImportedDuration

    [void]StopTimer() {
        $global:MyWatchCollection[$this.name].Stop()
        $this.End = Get-Date
        $this.Duration = $this.ImportedDuration + $global:MyWatchCollection[$this.name].Elapsed
        $this.Running = $False
        $this.Status = [MyTimerStatus]::Stopped
        $global:MyTimerCollection["$($this.name)"] = $this
    }

    [void]StartTimer() {
        $this.Start = Get-Date
        $this.end = [DateTime]::MinValue
        $this.Running = $True
        $this.Status = [MyTimerStatus]::Running
        $global:MyWatchCollection[$this.name].Start()
        $global:MyTimerCollection[$this.name] = $this
    }

    [void]ResetTimer() {
        $this.ImportedDuration = [TimeSpan]::Zero
        $this.Duration = [TimeSpan]::Zero
        $this.End = Get-Date
        $this.Running = $False
        $this.Status = [MyTimerStatus]::Reset
        $global:MyWatchCollection[$this.name].Reset()
        $global:MyTimerCollection[$this.name] = $this
    }

    [void]PauseTimer() {
        $global:MyWatchCollection[$this.name].Stop()
        $this.Duration = $this.ImportedDuration + $global:MyWatchCollection[$this.name].Elapsed
        $this.Running = $False
        $this.Status = [MyTimerStatus]::Paused
        $global:MyTimerCollection[$this.name] = $this
    }

    [void]RestartTimer() {
        $this.ResetTimer()
        $this.StartTimer()
    }

    [void]ResumeTimer() {
        #resume a paused timer
        $global:MyWatchCollection[$this.name].Start()
        $this.Running = $True
        $this.Status = [MyTimerStatus]::Running
        $global:MyTimerCollection[$this.name] = $this
    }

    [TimeSpan]GetStatus() {
        $current = $this.ImportedDuration + $global:MyWatchCollection[$this.name].Elapsed
        $this.Duration = $current
        return $current
    }
    [void]Refresh() {
        #Refresh the timer without writing an object to the pipeline
        $this.duration = $this.ImportedDuration + $global:MyWatchCollection[$this.name].Elapsed
        $global:MyTimerCollection["$($this.name)"] = $this
    }

    [MyTimer]GetCurrentTimer() {
        $this.duration = $this.ImportedDuration + $global:MyWatchCollection[$this.name].Elapsed
        $global:MyTimerCollection["$($this.name)"] = $this
        return $this
    }

    MyTimer([String]$Name, [String]$Description) {
        Try {
            [void](Get-Variable MyTimerCollection -Scope global -ErrorAction Stop)
        }
        Catch {
            Write-Verbose 'Creating MyTimerCollection hashtable'
            New-Variable -Scope global -Name MyTimerCollection -Value @{}
        }

        Try {
            [void](Get-Variable MyWatchCollection -Scope global -ErrorAction Stop)
        }
        Catch {
            Write-Verbose 'Creating MyWatchCollection hashtable'
            New-Variable -Scope global -Name MyWatchCollection -Value @{}
        }

        #timer names must be unique
        if ($global:MyTimerCollection.ContainsKey($Name)) {
            Throw "A timer with the name $name already exists. Please remove it first or create a timer with a new name."
        }
        else {
            Write-Verbose "Creating a MyTimer object by name: $name"
            $this.Name = $Name
            $this.Start = Get-Date
            $this.Running = $True
            $this.Description = $Description
            $this.Status = [MyTimerStatus]::Running

            Write-Verbose "Adding new timer $($this.name)"
            $global:MyTimerCollection.add($this.name, $this)
            $global:MyWatchCollection.add($this.name, [System.Diagnostics.StopWatch]::StartNew())
        }

    } #standard constructor

    #this generic constructor is used for importing timers
    MyTimer() {
        $this
    } #generic constructor
} #close class definition

#dot source file with function definitions
Get-ChildItem $PSScriptRoot\Functions |
ForEach-Object {
    . $_.FullName
}

#add AutoCompleter for MyTimer functions
$cmds = 'Get-MyTimer', 'Set-MyTimer', 'Remove-MyTimer','Restart-MyTimer','Reset-MyTimer'
Register-ArgumentCompleter -CommandName $cmds -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete = '*', $commandAst, $fakeBoundParameter)

    $global:MyTimerCollection.keys |
    Where-Object { $_ -match $wordToComplete } |
    Sort-Object |
    ForEach-Object {
        if ($_ -match "\s") {
            $k = "'$_'"
        }
        else {
            $k = $_
        }
        [System.Management.Automation.CompletionResult]::new($k, $k, 'ParameterValue', $k)
    }
}

Register-ArgumentCompleter -CommandName Stop-MyTimer -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete = '*', $commandAst, $fakeBoundParameter)

    $global:MyTimerCollection.values.where({ $_.running }) |
    Where-Object { $_ -match $wordToComplete } |
    Sort-Object -Property Name |
    ForEach-Object {
        if ($_.name -match "\s") {
            $k = "'$($_.name)'"
        }
        else {
            $k = $_.name
        }
        [System.Management.Automation.CompletionResult]::new($k, $k, 'ParameterValue', $k)
    }
}