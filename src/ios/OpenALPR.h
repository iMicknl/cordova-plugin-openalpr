#import <Cordova/CDVPlugin.h>
#import "PlateScanner.h"

@interface OpenALPR : CDVPlugin

@property PlateScanner *plateScanner;
@property (strong, nonatomic) NSMutableArray *plates;

- (void) scan:(CDVInvokedUrlCommand*)command;

@end