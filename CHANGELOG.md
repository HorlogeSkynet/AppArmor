# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2025-06-04
### Added
- `network` "raw" domain
- Single `signal` in signals set
- Double-quoted `signal` set signals
- `dbus` "accessibility" and "fcitx" bus names
- Context-less rules (e.g. required for abstraction files)
- Absolute ABI statements (`abi "/etc/apparmor.d/abi/...",`)
- Profile concatenation in regular expressions (`...//profile`)
- Profile concatenation stacking in regular expressions (`...//&profile`)
### Fixed
- Build command error parsing
- `file` rule with a file glob "exec target"
- Profile/Hat names containing `-` separator
- Permissive `mount` and `network` directives
- Regular expressions containing anonymous inodes
- Unmatched anonymous profiles exec paths
- Unmatched end parenthesis in `dbus` peer name condition

## [0.1.1] - 2022-10-27
### Changed
- Exclude syntax test files from package

## [0.1.0] - 2022-10-26
### Added
- Initial version

[Unreleased]: https://github.com/HorlogeSkynet/AppArmor/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/HorlogeSkynet/AppArmor/compare/v0.1.1...v1.0.0
[0.1.1]: https://github.com/HorlogeSkynet/AppArmor/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/HorlogeSkynet/AppArmor/releases/tag/v0.1.0
