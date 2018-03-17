# Cordova OpenALPR plugin
This Cordova plugin adds support for the [OpenALPR (Automatic License Plate Recognition) library](https://github.com/openalpr/openalpr), which provides support for retrieving the license plate from a picture.

## Supported platforms
The current master branch supports the following platforms:
- iOS (>= 8)
- Android (>= SDK 21)

## Installation
This plugin requires Cordova 5.0+ and can be installed from the [Cordova Plugin Registry](https://cordova.apache.org/plugins/). If you use Ionic 3, you should also install the `@ionic-native` binding.

`cordova plugin add cordova-plugin-openalpr`

`npm install @ionic-native/openalpr`

## Examples

### Ionic 1 / PhoneGap
This plugin defines a global `cordova.plugins.OpenALPR` object which provides an API for scanning license plates. It is possible to use the output of [cordova-plugin-camera](https://cordova.apache.org/docs/en/latest/reference/cordova-plugin-camera/) and pass it to the scan function of this plugin.

```javascript
cordova.plugins.OpenALPR.scan(filepath, { country: 'eu', amount: 3 }, function (results) {
     console.log(results);
 }, function (error) {
     console.log(error.code + ': ' + error.message)
 });
 ```

### Ionic 3
This plugin has a `@ionic-native/openalpr` binding available, which makes it easy to include it in your Ionic 3 project. You can use the output of `@ionic-native/camera` and pass it to the scan function of this plugin.

```typescript
import { Camera, CameraOptions } from '@ionic-native/camera';
import { OpenALPR, OpenALPROptions, OpenALPRResult } from '@ionic-native/openalpr';

constructor(private camera: Camera, private openALPR: OpenALPR) {

}

const cameraOptions: CameraOptions = {
    quality: 100,
    destinationType: this.camera.DestinationType.FILE_URI,
    encodingType: this.camera.EncodingType.JPEG,
    mediaType: this.camera.MediaType.PICTURE,
    sourceType: this.camera.PictureSourceType.CAMERA,
    allowEdit: false
}

const scanOptions: OpenALPROptions = {
    country: this.openalpr.Country.EU
    amount: 3
}

this.camera.getPicture(cameraOptions).then((imageData) => {
    this.openALPR.scan(imageData)
        .then((result: [OpenALPRResult]) => console.log(result.number))
        .catch((error: Error) => console.error(error));
});
 ```

 This plugin is only supported on iOS / Android, however in order to speed up development you can make use of [mocking and browser development](https://github.com/ionic-team/ionic-native#mocking-and-browser-development).

## Known Issues 
### opencv2/highgui/highgui.hpp' file not found when compiling iOS app
This Cordova plugin uses custom framework files for iOS which make use of symlinks on MacOS. Symlinks can break when the plugin is either downloaded on Windows and then moved to an MacOS machine or when the plugin is pulled from the Cordova plugin repo / npm without the symlinks being present in the archive [as described in this Cordova bug](https://issues.apache.org/jira/browse/CB-6092). You can solve this by [using a hook](https://docs.microsoft.com/en-us/visualstudio/cross-platform/tools-for-cordova/tips-workarounds/ios-plugin-symlink-fix-readme?view=toolsforcordova-2015) which fixes the issue before compiling. If you don't want to use a hook, you can also manually fix the files as described [here](https://github.com/iMicknl/cordova-plugin-openalpr/issues/12) or clone the repository from Github and add it to your project.

## Notes
- This project includes prebuilt OpenALPR libraries for iOS and Android, because the compilation of the OpenALPR framework requires a lot of effort and dependencies.
- This project is not used in production anymyore and won't be maintained actively. We can't guarantee that we can respond quickly to issues / pull requests, however we will keep an eye on the repository. 

## License
MIT, but keep in mind that OpenALPR itself is licensed under AGPL-3.0.

## Credits
- License plate scanning based on [OpenALPR](https://github.com/openalpr/openalpr).
- iOS platform support based on [OpenALPR iOS](https://github.com/twelve17/openalpr-ios).
- Android platform support based on [OpenALPR Java bindings](https://github.com/openalpr/openalpr/tree/master/src/bindings/java)
- iOS Base64 implementation by [@baukeroo](https://github.com/baukeroo)
