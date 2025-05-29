# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Double-quoted `signal` set signals
- Context-less rules (e.g. required for abstraction files)
- Absolute ABI statements (`abi "/etc/apparmor.d/abi/...",`)
### Fixed
- Profile/Hat names containing `-` separator
- Permissive `mount` and `network` directives
- Unmatched anonymous profiles exec paths
- Unmatched end parenthesis in `dbus` peer name condition

## [0.1.1] - 2022-10-27
### Changed
- Exclude syntax test files from package

## [0.1.0] - 2022-10-26
### Added
- Initial version

[Unreleased]: https://github.com/HorlogeSkynet/AppArmor/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/HorlogeSkynet/AppArmor/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/HorlogeSkynet/AppArmor/releases/tag/v0.1.0
