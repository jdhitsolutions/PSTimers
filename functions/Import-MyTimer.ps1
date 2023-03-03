Function Import-MyTimer {

    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("MyTimer[]")]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the name and path of an XML file"
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
    Import-Clixml -Path $Path | foreach-object {
        if ($PSCmdlet.ShouldProcess($_.name)) {
            Write-Verbose "Importing $($_.name)"
            [void](New-Object -TypeName MyTimer -ArgumentList $_.name, $_.start, $_.end, $_.duration, $_.running, $_.description)
            Get-MyTimer -name $_.name
        }
    }

    Write-Verbose "Ending: $($MyInvocation.MyCommand)"
}
