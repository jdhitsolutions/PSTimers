# Changelog for PSTimers

## v2.0.1

### Changed

- Added missing online help links for new functions.
- Updated external help.
  Updated `README.md`.

## v2.0.0

### Changed

- Merged [PR#12](https://github.com/jdhitsolutions/PSTimers/pull/12) from @joshua-russell to update `Set-MyTimer`. His change was refined further.
- Revised how PSBoundParameters are displayed in Verbose output.
- Updates to the `PSCountdownTasks.txt` file.
- Added `-PassThru` parameter to `Stop-MyTimer` to return the timer object. The default now is to not write anything to the pipeline. **This is a breaking change**.
- Moved the import-related constructor code from the `MyTimer` class to `Import-MyTimer`. **This is a breaking change**.
- Revised `Remove-MyTimer` to remove the associated stopwatch object from `$MyWatchCollection`.
- Modified `Export-MyTimer` to export multiple timers to the same file
- Updated auto completers to wrap timer names with spaces in single quotes.
- Modified `mytimer.format.ps1xml` to highlight `MyTask` names using ANSI depending on the task status.
- Modified `mytimer.format.ps1xml` to format duration value without milliseconds.
- Modified `Get-MyTimer` to support getting timers based on status. [Issue #14](https://github.com/jdhitsolutions/PSTimers/issues/14)
- Help updates.
- Updated `README.md`.
- Moved module to version `2.0.0` due to the number of breaking changes and addition of many commands.

### Added

- Rewrote the `MyTimer` class to allow for pausing, resuming, and restarting. The class keeps an associated `[System.Diagnostics.StopWatch]` object in a separate hash table, `$MyWatchCollection`. **This is a potential breaking change**.
- Added function `Suspend-MyTimer` with an alias of `Pause-MyTimer`, and functions `Resume-MyTimer`,`Reset-MyTimer`, and `Restart-MyTimer`. [Issue #13](https://github.com/jdhitsolutions/PSTimers/issues/13)

### Fixed

- Fixed bug in `Set-MyTimer` to update the relevant hash table entries.

## v1.1.0

### Added

- Restored missing class definition for `MyTask`.

### Fixed

- Revised `Start-MyTimer` and `Get-MyTimer` to fix error with invalid output type. [Issue #11](https://github.com/jdhitsolutions/PSTimers/issues/11)

### Changed

- Modified `mytimer.format.ps1xml` to use auto sizing.
- Revised `Start-MyTimer` to display a warning if a timer with the same name has already been created.
- Updated help documentation.
- Update `README.md

## v1.0.1

- Added missing online help links.
- Help updates
- reorganized module layout.
- Modified `Start-PSCountdownTimer` to let the user specify the alert and warning time intervals and corresponding color.

## v1.0.0

- Merged [Pull Request #7](https://github.com/jdhitsolutions/PSTimers/pull/7) and [Pull Request #8](https://github.com/jdhitsolutions/PSTimers/pull/8). Thank you @joshua-russell
- Added online help links.
- Updated PSCountdown tasks.
- Reorganized module layout.
- Changed `-ProgressStyle` parameter in `Start-PSCountdown` from a dynamic parameter to a standard parameter since the original blocker on non-Windows platforms has been resolved.
- Updated `Start-PSCountdown` to use `$PSStyle` settings if detected.  [Issue #10](https://github.com/jdhitsolutions/PSTimers/issues/10)
- Added `Start-PSCountdownTimer`. [Issue #1](https://github.com/jdhitsolutions/PSTimers/issues/1)
- Added `Stop-PSCountdownTimer`.
- Updated help.
- Updated `README.md`.

## v0.9.0

- Removed -All parameter from `Get-MyTimer` (Issue #6). **This is a breaking change**.
- Updated warning messages in `Get-MyTimer` (Issue #5)
- help updates

## v0.8.0

- Added property set called `History` for MyTimer object to display End value (Issue #4)
- Updated `MyTimer.format.ps1xml` to include `End` value
- Modified `Stop-MyTimer` to write result to pipeline. Removed `-PassThru` (Issue #3)
- Modified MyTimer class to not hide `End` property.
- Modified `Get-MyTimer` to take pipeline input for Name by property name
- help and documentation updates

## v0.7.1

- fixed bug with `-ProgressStyle` parameter on `Start-PSCountdown`
- added additional tasks to `PScountdowntask.txt`
- added an alias of `cls` for the `-ClearHost` parameter on `Start-PSCountdown`
- Minor help updates

## v0.7.0

- fixed bug piping a MyTimer to `Stop-MyTimer` (Issue #2)
- Added `-PassThru` parameter to `Stop-MyTimer`
- Made `-Name` parameter mandatory for `Stop-MyTimer`
- MyTimer names must be unique
- Updated about_MyTimer help documentation
- Added auto completers for MyTimer commands
- added additional entries to `PSCountdowntasks.txt`
- Renamed `-GlobalBlock` parameter in `Start-PSTimer` to `-Scriptblock` but kept original name as a parameter alias.

## v0.6.1

- file cleanup for the PowerShell Gallery
- updated license
- added additional entries to `PSCountdowntasks.txt`

## v0.6.0

- Added alias definitions to functions
- Updated manifest
- Updated help
- Renamed about help topic
- Updated README

## v0.5.1

- Added format type extension for MyTimer

## v0.5.0

- Added Description property to MyTimer
- Added `Set-MyTimer` to modify a timer object
- Added -PassThru to `Set-MyTimer`
- Modified `Get-MyTimer` to default to only running timers
- Added -All parameter to Get-MyTimer
- Updated `Import-MyTimer` to support description
- Fixed bug in `Start-MyTimer` creating multiple timers
- Updated help

## v0.4.0

- corrected markdown in about_MyTimer
- moved functions to separate file
- converted MyTimer functions to using a class-based object
- Added Get-HistoryRuntime command

## v0.3.0

- Added MyTimer commands
- Created markdown help
- Created external help

## v0.2.0

- Modified `Start-PSCountdown` take a datetime as a countdown target
- Modified `Start-PSTimer` to include title in text countdown
- Updated manifest

## v0.1.0

- initial files and functions