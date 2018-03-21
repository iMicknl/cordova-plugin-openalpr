var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
import { Injectable } from '@angular/core';
import { Plugin, Cordova, IonicNativePlugin } from '@ionic-native/core';
/**
 * @name OpenALPR
 * @description
 * This Cordova plugin adds support for the OpenALPR (Automatic License Plate Recognition) library, which provides support for retrieving the license plate from a picture.
 *
 * @usage
 * ```typescript
 * import { OpenALPR, OpenALPROptions, OpenALPRResult } from '@ionic-native/openalpr';
 *
 *
 * constructor(private openALPR: OpenALPR) { }
 *
 * const scanOptions: OpenALPROptions = {
 *    country: this.openALPR.Country.EU,
 *    amount: 3
 * }
 *
 * // To get imageData, you can use the @ionic-native/camera module for example. It works with DestinationType.FILE_URI and DATA_URL
 *
 * this.openALPR.scan(imageData, scanOptions)
 *   .then((res: [OpenALPRResult]) => console.log(res))
 *   .catch((error: Error) => console.error(error));
 *
 * ```
 */
var OpenALPR = (function (_super) {
    __extends(OpenALPR, _super);
    function OpenALPR() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.Country = {
            AU: 'au',
            BR: 'br',
            BR2: 'br2',
            EU: 'eu',
            IN: 'in',
            KR2: 'kr2',
            US: 'us',
            VN2: 'vn2'
        };
        return _this;
    }
    /**
    * This function does something
    * @param imageData {any} Base64 encoding of the image data or the image file URI
    * @param options {OpenALPROptions} Options to pass to the OpenALPR scanner
    * @return {Promise<any>} Returns a promise that resolves when something happens
    */
    OpenALPR.prototype.scan = function (imageData, options) { return; };
    OpenALPR.decorators = [
        { type: Injectable },
    ];
    /** @nocollapse */
    OpenALPR.ctorParameters = function () { return []; };
    __decorate([
        Cordova(),
        __metadata("design:type", Function),
        __metadata("design:paramtypes", [Object, Object]),
        __metadata("design:returntype", Promise)
    ], OpenALPR.prototype, "scan", null);
    OpenALPR = __decorate([
        Plugin({
            pluginName: 'OpenALPR',
            plugin: 'cordova-plugin-openalpr',
            pluginRef: 'cordova.plugins.OpenALPR',
            repo: 'https://github.com/iMicknl/cordova-plugin-openalpr',
            platforms: ['Android', 'iOS']
        })
    ], OpenALPR);
    return OpenALPR;
}(IonicNativePlugin));
export { OpenALPR };
//# sourceMappingURL=index.js.map