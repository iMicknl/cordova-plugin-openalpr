#import "OpenALPR.h"

#import "PlateScanner.h"
#import "Plate.h"

@implementation OpenALPR

-(void) scan:(CDVInvokedUrlCommand *)command {
    NSArray *dataArray = @[@"AA12BB", @"Test"];

    //move to constructor?
    self.plateScanner = [[PlateScanner alloc] init];
    //self.plates = [NSMutableArray arrayWithCapacity:0];


    CDVPluginResult *pluginResult = [ CDVPluginResult
                                      resultWithStatus    : CDVCommandStatus_OK
                                      messageAsArray : dataArray];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end