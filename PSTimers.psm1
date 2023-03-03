#a class definition for the MyTimer commands
Class MyTimer {
    [String]$Name
    [DateTime]$Start
    [DateTime]$End
    [TimeSpan]$Duration
    [boolean]$Running
    [String]$Description

    [void]StopTimer() {
        $this.End = Get-Date
        $this.Duration = $this.end - $this.start
        $this.Running = $False
        $global:MyTimerCollection["$($this.name)"] = $this
    }

    [TimeSpan]GetStatus () {
        #temporarily set duration
        $current = (Get-Date) - $this.Start
        return $current
    }

    MyTimer([String]$Name, [String]$Description) {

        Try {
            [void](Get-Variable MyTimerCollection -Scope global -ErrorAction Stop)
        }
        Catch {
            Write-Verbose 'Creating MyTimerCollection hashtable'
            New-Variable -Scope global -Name MyTimerCollection -Value @{}
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

            Write-Verbose "Adding new timer $($this.name)"
            $global:MyTimerCollection.add($this.name, $this)
        }
    }

    #used for importing
    MyTimer([String]$Name, [DateTime]$Start, [DateTime]$End, [TimeSpan]$Duration, [boolean]$Running, [String]$Description) {
        $this.Name = $Name
        $this.start = $Start
        $this.end = $End
        $this.Duration = $Duration
        $this.running = $Running
        $this.Description = $Description

        Try {
            [void](Get-Variable MyTimerCollection -Scope global -ErrorAction Stop)
        }
        Catch {
            New-Variable -Scope global -Name MyTimerCollection -Value @{}
        }
        #reuse existing timers if found
        if ($global:MyTimerCollection.ContainsKey($this.name)) {
            $global:MyTimerCollection[$this.name] = $this
        }
        else {
            $global:MyTimerCollection.add($this.name, $this)
        }
    }
}

#dot source file with function definitions
Get-ChildItem $PSScriptRoot\Functions |
ForEach-Object {
    . $_.FullName
}

#add autocompleter for MyTimer functions
$cmds = 'Get-MyTimer', 'Set-MyTimer', 'Remove-MyTimer'
Register-ArgumentCompleter -CommandName $cmds -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete = '*', $commandAst, $fakeBoundParameter)

    $global:MyTimerCollection.keys |
    Where-Object { $_ -match $wordToComplete } |
    Sort-Object |
    ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

Register-ArgumentCompleter -CommandName Stop-MyTimer -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete = '*', $commandAst, $fakeBoundParameter)

    $global:MyTimerCollection.values.where({ $_.running }) |
    Where-Object { $_ -match $wordToComplete } |
    Sort-Object -Property Name |
    ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_.name, $_.name, 'ParameterValue', $_.name)
    }
}