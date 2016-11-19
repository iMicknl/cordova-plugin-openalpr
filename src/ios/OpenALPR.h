#import <Cordova/CDVPlugin.h>
#import "PlateScanner.h"

@interface OpenALPR : CDVPlugin

@property PlateScanner *plateScanner;
@property (strong, nonatomic) NSMutableArray *plates;
@property NSFileManager *fileManager;

enum PluginError {
    CDV_UNKNOWN_ERROR = 0,
    CDV_FILE_NOT_FOUND = 1
};

/**
 * Returns array of license plates found from the given image
 *
 * options: "filePath" contains the path to the image
 */
- (void) scan:(CDVInvokedUrlCommand*)command;

@end