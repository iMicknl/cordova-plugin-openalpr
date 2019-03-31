# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## 2.1.0 - 2019-03-31
### Bugfix
- #12: Replace iOS opencv symlinks with the actual directories to prevent disappearing symlinks during installation.

### Added
- #26: Add support for Cordova Android@7.0.0+

## 2.0.1 - 2018-04-01
### Bugfix
- Fix Cordova camera file_uri support for Android.

## 2.0.0 - 2018-03-21
### Added
- Support for Base64 encoded image data
- Possibility to pass options to the scanner, like country and amount
- Better Ionic 3 support with `@ionic-native/openalpr`
- Updated documentation with examples

### Changed
- Add extra parameter for passing options in scan() (breaking change)

## 1.0.0 - 2016-11-19
### Added
- Initial release.
- Add basic iOS support.
- Add basic Android support.
- Add NPM registry support.
