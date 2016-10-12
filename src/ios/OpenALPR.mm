#import "OpenALPR.h"

#import "PlateScanner.h"
#import "Plate.h"

@implementation OpenALPR

-(void) scan:(CDVInvokedUrlCommand *)command {
    //NSArray *dataArray = @[@"AA12BB", @"Test"];

    self.plateScanner = [[PlateScanner alloc] init];
    self.plates = [NSMutableArray arrayWithCapacity:0];

    //Temporary use hardcoded filepath
    NSString *plateFilename = @"nl-optie2.jpg";
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:plateFilename ofType:nil];
    CDVPluginResult* pluginResult = nil;

    //Check if imagePath exists
    if (imagePath) {
        cv::Mat image = imread([imagePath UTF8String], CV_LOAD_IMAGE_COLOR);

        [self.plateScanner
         scanImage:image
         onSuccess:^(NSArray * results) {

             for(Plate* plate in results) {
                 NSDictionary *dic = @{
                                       @"number" : plate.number,
                                       @"confidence" : [NSNumber numberWithInt:plate.confidence]
                                       };
                 [self.plates addObject:dic];
             }

             NSLog(@"Success!" );
             NSLog(@"%@", self.plates);
         }
         onFailure:^(NSError * error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 NSLog(@"Error: %@", [error localizedDescription]);
            });
         }];

        pluginResult = [ CDVPluginResult
                                         resultWithStatus    : CDVCommandStatus_OK
                                         messageAsArray: self.plates];
    }
    else {
        NSLog(@"Error :(");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error in reading filepath"];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end