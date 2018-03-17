# Cordova OpenALPR plugin
This Cordova plugin adds support for the OpenALPR (Automatic License Plate Recognition) library, which provides support for retrieving the license plate from a picture.

## Supported platforms
The current master branch supports the following platforms:
- iOS (>= 8)
- Android (>= SDK 21)

## Installation
This plugin requires Cordova 5.0+ and can be installed from the [Cordova Plugin Registry](https://cordova.apache.org/plugins/). 
`cordova plugin add cordova-plugin-openalpr`

If you use Ionic 3, you should also install the `@ionic-native` binding.
`npm install @ionic-native/openalpr`


## How to use

### Ionic 1 / PhoneGap
This plugin defines a global `cordova.plugins.OpenALPR` object, which provides an API for scanning license plates. It is possible to use the output of [cordova-plugin-camera](https://cordova.apache.org/docs/en/latest/reference/cordova-plugin-camera/) and pass it to the scan function of this plugin.

```
cordova.plugins.OpenALPR.scan(filepath, { country: 'eu', amount: 3 }, function (data) {
     //Results
     console.log(data);
 }, function (error) {
     console.log(error.code + ': ' + error.message)
 });
 ```
### Ionic 3
This plugin has a `@ionic-native/openalpr` binding available, which makes it easy to include it in your Ionic 3 project. You can use the output of `@ionic-native/camera` and pass it to the scan function of this plugin.

```
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
        .then((result: [string]) => console.log(result))
        .catch((error: Error) => console.error(error));
    });
 ```

## Notes
- This project includes prebuilt OpenALPR libraries for iOS and Android, because the compilation of the OpenALPR framework requires a lot of effort and dependencies.

## Credits
- License plate scanning based on [OpenALPR](https://github.com/openalpr/openalpr).
- iOS platform support based on [OpenALPR iOS](https://github.com/twelve17/openalpr-ios).
- Android platform support based on [OpenALPR Java bindings](https://github.com/openalpr/openalpr/tree/master/src/bindings/java)
- iOS Base64 implementation by [@baukeroo](https://github.com/baukeroo)
