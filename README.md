# Cordova OpenALPR plugin 
This Cordova plugin adds support for the OpenALPR (Automatic License Plate Recognition) library, which provides support for retrieving the license plate from a picture.

## Supported platforms
The current master branch supports the following platforms:
- iOS (>= 8)
- Android (>= SDK 21)

## Installation
This plugin requires Cordova 5.0+ and can be installed from the [Cordova Plugin Registry](https://cordova.apache.org/plugins/). 

`cordova plugin add cordova-plugin-openalpr`

## How to use
This plugin defines a global `cordova.plugins.OpenALPR` object, which provides an API for scanning license plates. It is possible to use the output of [cordova-plugin-camera](https://cordova.apache.org/docs/en/latest/reference/cordova-plugin-camera/) and pass it to the scan function of this plugin.

### Example
```javascript
cordova.plugins.OpenALPR.scan(filepath, (data) => {
     //Results
     console.log(data);
 }, function (error) {
     console.log(error.code + ': ' + error.message)
 });
 ```

## Known Issues 
### opencv2/highgui/highgui.hpp' file not found when compiling iOS app
This Cordova plugin uses custom framework files for iOS which make use of symlinks on MacOS. Symlinks can break when the plugin is either downloaded on Windows and then moved to an MacOS machine or when the plugin is pulled from the Cordova plugin repo / npm without the symlinks being present in the archive [as described in this Cordova bug](https://issues.apache.org/jira/browse/CB-6092). You can solve this by [using a hook](https://docs.microsoft.com/en-us/visualstudio/cross-platform/tools-for-cordova/tips-workarounds/ios-plugin-symlink-fix-readme?view=toolsforcordova-2015) which fixes the issue before compiling. If you don't want to use a hook, you can also manually fix the files as described [here](https://github.com/iMicknl/cordova-plugin-openalpr/issues/12) or clone the repository from Github and add it to your project.

## Notes
- This project includes prebuilt OpenALPR libraries for iOS and Android, because the compilation of the OpenALPR framework requires a lot of effort and dependencies.
- This project is not used in production anymyore and won't be maintained actively. We can't guarantee that we can respond quickly to issues / pull requests, however we will keep an eye on the repository. [![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

## License
MIT, but keep in mind that OpenALPR itself is licensed under AGPL-3.0.

## Credits
- License plate scanning based on [OpenALPR](https://github.com/openalpr/openalpr).
- iOS platform support based on [OpenALPR iOS](https://github.com/twelve17/openalpr-ios).
- Android platform support based on [OpenALPR Java bindings](https://github.com/openalpr/openalpr/tree/master/src/bindings/java)
