import { IonicNativePlugin } from '@ionic-native/core';
export interface OpenALPROptions {
    /** Country used for scanning the license plate */
    country?: string;
    /** Amount of results returned */
    amount?: number;
}
export interface OpenALPRResult {
    /** LicensePlate */
    number: string;
    /** Probability */
    confidence: number;
}
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
export declare class OpenALPR extends IonicNativePlugin {
    Country: {
        AU: string;
        BR: string;
        BR2: string;
        EU: string;
        IN: string;
        KR2: string;
        US: string;
        VN2: string;
    };
    /**
    * This function does something
    * @param imageData {any} Base64 encoding of the image data or the image file URI
    * @param options {OpenALPROptions} Options to pass to the OpenALPR scanner
    * @return {Promise<any>} Returns a promise that resolves when something happens
    */
    scan(imageData: any, options?: OpenALPROptions): Promise<any>;
}
