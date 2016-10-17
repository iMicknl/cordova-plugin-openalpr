#import "OpenALPR.h"

#import "PlateScanner.h"
#import "Plate.h"

@implementation OpenALPR

-(void) scan:(CDVInvokedUrlCommand *)command {

    //TODO Move to subthread
    self.plateScanner = [[PlateScanner alloc] init];
    self.plates = [NSMutableArray arrayWithCapacity:0];
    self.fileManager = [[NSFileManager alloc] init];

    NSString* imagePath = [command.arguments objectAtIndex:0];
    CDVPluginResult* pluginResult = nil;

    // Strip file:// from imagePath where applicable
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"file://" withString:@""];

    //Check if imagePath if available and if image exists
    if (imagePath && [self.fileManager fileExistsAtPath:imagePath]) {
        cv::Mat image = imread([imagePath UTF8String], CV_LOAD_IMAGE_COLOR);

        [self.plateScanner
         scanImage:image
         onSuccess:^(NSArray * results) {
             for(Plate* plate in results) {
                 NSDictionary *dic = @{
                                       @"number" : plate.number,
                                       @"confidence" : [NSNumber numberWithFloat:plate.confidence]
                                       };
                 [self.plates addObject:dic];
             }
         }
         onFailure:^(NSError * error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 NSMutableDictionary* pluginError = [NSMutableDictionary dictionaryWithCapacity:2];
                 [pluginError setValue:[NSNumber numberWithInt:CDV_UNKNOWN_ERROR] forKey:@"code"];
                 [pluginError setValue:[error localizedDescription] forKey:@"message"];

                 CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:pluginError];

                 [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            });
         }];

        //TODO Move this variable to onSuccess
        pluginResult = [ CDVPluginResult
                                         resultWithStatus    : CDVCommandStatus_OK
                                         messageAsArray: self.plates];
    }
    else {
        NSMutableDictionary* pluginError = [NSMutableDictionary dictionaryWithCapacity:3];
        [pluginError setValue:[NSNumber numberWithInt:CDV_FILE_NOT_FOUND] forKey:@"code"];
        [pluginError setValue:@"Image can't be found for given path." forKey:@"message"];
        [pluginError setValue:imagePath forKey:@"path"];

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:pluginError];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
