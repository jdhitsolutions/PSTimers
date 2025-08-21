Function Start-MyTimer {
    [CmdletBinding()]
    [OutputType("MyTimer")]
    [Alias("ton")]

    Param(
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name = "MyTimer",
        [String]$Description
    )

    _verbose ($strings.Starting -f $MyInvocation.MyCommand)
    _verbose ($strings.Running -f $PSVersionTable.PSVersion)
    _verbose ($strings.Detected -f $host.Name)
    _verbose "Using PSBoundParameters: `n $(New-Object PSObject -Property $PSBoundParameters | Out-String)"
        foreach ($timer in $Name) {
        #Test if a timer with the same name already exists
        if (Get-MyTimer -Name $Name -WarningAction SilentlyContinue) {
            Write-Warning "A timer with the name $Name already exists. Try again with a different name."
        }
        else {
            Try {
                _verbose "Creating timer $timer"
                New-Object -TypeName MyTimer -ArgumentList $timer, $Description -ErrorAction stop
            }
            Catch {
                # Write-Warning "Failed to create timer $timer. $($_.exception.message)"
                Throw $_
            }
        }

    } #foreach

    _verbose ($strings.Ending -f $MyInvocation.MyCommand)

}
