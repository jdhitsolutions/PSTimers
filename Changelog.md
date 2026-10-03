# Changelog for PSTimers

## [Unreleased]

## [2.4.0] - 2026-10-03

### Added

- Added commands `Start-ConsoleCountdown` and `Stop-ConsoleCountdown` to manage a console-based countdown timer. This is a timer that __counts down__ to 0.
- Added commands `Start-ConsoleTimer`, `Stop-ConsoleTimer`, and `Remove-ConsoleTimer` to manage a console based timer. This is a timer that starts at 0 and __counts up__.
- Added an event subscription on module remove to clean up variables and related event subscriptions. This is a failsafe.

### Changed

- Cleaned up unused localized strings.
- Updated `README`.
- Migrated help documentation to the new Microsoft.PowerShell.Platyps model and schema.
- Updated license

### Fixed

- Fixed typo bug in `Start-PSCountdown` [Issue #15](https://github.com/jdhitsolutions/PSTimers/issues/15).

## [2.3.0] - 2025-08-21

### Added

- Added `Start-PSCountdownTitle` and its alias `TitleCountdown`. This command lets you run a countdown timer in the console title or tab, if using Windows Terminal.

### Changed

- Updated verbose messaging to provide runtime metadata.
- Updated `Start-PSCountdownTimer` to run in VS Code.
- Updated `README.md`.
- Revised online help links and refreshed help files.
- Added `Microsoft.Powershell.ThreadJob` as a dependency.
- Moved primary git branch from `master` to `main`.

## [2.2.0] - 2024-09-05

### Changed

- Updated `README`.
- Updated code in `Start-PSCountdownTimer`.
- Updated countdown tasks.

### Fixed

- Fixed broken online help links.

## [2.1.0] - 2023-07-10

### Changed

- General code cleanup

### Fixed

- Fixed default path reference in `Start-PSCountDown`.
- Fixed `about_PSTimers` help topic.

## [2.0.1] - 2023-06-29

### Changed

- Added missing online help links for new functions.
- Updated external help.
  Updated `README.md`.

[Unreleased]: https://github.com/jdhitsolutions/PSTimers/compare/v2.4.0..HEAD
[2.4.0]: https://github.com/jdhitsolutions/PSTimers/compare/v2.3.0..v2.4.0
[2.3.0]: https://github.com/jdhitsolutions/PSTimers/compare/v2.2.0..v2.3.0
[2.2.0]: https://github.com/jdhitsolutions/PSTimers/compare/v2.1.0..v2.2.0
[2.1.0]: https://github.com/jdhitsolutions/pstimers/compare/v2.0.1..v2.1.0
[2.0.1]: https://github.com/jdhitsolutions/pstimers/compare/v2.0.0..v2.0.1