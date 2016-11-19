# Cordova OpenALPR plugin
This Cordova plugin adds support for the OpenALPR (Automatic License Plate Recognition) library, which provides support for retrieving the license plate from a picture.

## Supported platforms
The current master branch supports the following platforms:
- iOS (>= 8)
- Android (>= SDK 21)

## Installation

_The plugin isn't published on NPM or the Cordova Plugin Library yet, so only manual installs are possible._

`cordova plugin add https://github.com/iMicknl/cordova-plugin-openalpr.git`

## How to use
This plugin defines a global `cordova.plugins.OpenALPR` object, which provides an API for scanning license plates. It is possible to use the output of [cordova-plugin-camera](https://cordova.apache.org/docs/en/latest/reference/cordova-plugin-camera/) and pass it to the scan function of this plugin.

### Example
```
cordova.plugins.OpenALPR.scan(filepath, function (data) {
     //Results
     console.log(data);
 }, function (error) {
     console.log(error.code + ': ' + error.message)
 });
 ```
## Notes
- This project includes prebuilt OpenALPR libraries for iOS and Android, because the compilation of the OpenALPR framework requires a lot of effort and dependencies.

## Credits
- License plate scanning based on [OpenALPR](https://github.com/openalpr/openalpr).
- iOS platform support based on [OpenALPR iOS](https://github.com/twelve17/openalpr-ios).
- Android platform support based on [OpenALPR Java bindings](https://github.com/openalpr/openalpr/tree/master/src/bindings/java)