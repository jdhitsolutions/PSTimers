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
        [string]$Path
    )

    Write-Verbose "Starting: $($MyInvocation.MyCommand)"
    #display PSBoundParameters formatted nicely for Verbose output
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "PSBoundParameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

    Import-Clixml -Path $Path | foreach-object {
        if ($PSCmdlet.ShouldProcess($_.name)) {
            Write-Verbose "Importing $($_.name)"
            [void](New-Object -TypeName MyTimer -ArgumentList $_.name, $_.start, $_.end, $_.duration, $_.running, $_.description)
            Get-MyTimer -name $_.name
        }
    }

    Write-Verbose "Ending: $($MyInvocation.MyCommand)"
}
