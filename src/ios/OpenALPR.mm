#import "OpenALPR.h"

#import "PlateScanner.h"
#import "Plate.h"

@implementation OpenALPR

-(void) scan:(CDVInvokedUrlCommand *)command {
    //NSArray *dataArray = @[@"AA12BB", @"Test"];

    self.plateScanner = [[PlateScanner alloc] init];
    //self.plateScanner = [PlateScanner new];
    self.plates = [NSMutableArray arrayWithCapacity:0];

    //Temporary use hardcoded filepath
    NSString *plateFilename = @"nl-optie2.jpg";
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:plateFilename ofType:nil];

    //Check if imagePath exists
    if (imagePath) {
        cv::Mat image = imread([imagePath UTF8String], CV_LOAD_IMAGE_COLOR);

        [self.plateScanner
         scanImage:image
         onSuccess:^(NSArray * results) {
             [self.plates addObjectsFromArray:results];

             NSLog(@"Success!" );
             NSLog(@"Number of items in my array is: %lu", (unsigned long)[results count]);
         }
         onFailure:^(NSError * error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 NSLog(@"Error: %@", [error localizedDescription]);
            });
         }];

    }
    else {
        NSLog(@"Error :(");
    }

    CDVPluginResult *pluginResult = [ CDVPluginResult
                                      resultWithStatus    : CDVCommandStatus_OK
                                      messageAsArray : self.plates];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
