# Cordova OpenALPR plugin
This plugin is a iOS wrapper for the OpenALPR (Automatic License Plate Recognition) library, which provides support for retrieving the license plate from a picture.  

## Supported platforms
The current master branch supports the following platforms:
- iOS (>= 8)

## Installation

_The plugin isn't publised on NPM or the Cordova Plugin Library yet, so only manual installs are possible._

`cordova plugin add https://github.com/iMicknl/cordova-plugin-openalpr.git`

## How to use
This plugin defines a global cordova.plugins.OpenALPR object, which provides an API for scanning license plates.

## Credits
- License plate scanning based on [OpenALPR](https://github.com/openalpr/openalpr) in combination with [OpenALPR iOS](https://github.com/twelve17/openalpr-ios).