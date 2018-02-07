#import "OpenALPR.h"

#import "PlateScanner.h"
#import "Plate.h"

#include <vector>
#include <string>
using namespace std;
using namespace cv;


static const std::string base64_chars =
"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
"abcdefghijklmnopqrstuvwxyz"
"0123456789+/";


@implementation OpenALPR

-(void) scan:(CDVInvokedUrlCommand *)command {

    [self.commandDelegate runInBackground:^{
        self.plateScanner = [[PlateScanner alloc] init];
        self.plates = [NSMutableArray arrayWithCapacity:0];
        self.fileManager = [[NSFileManager alloc] init];

        NSString* imagePath = [command.arguments objectAtIndex:0];
        CDVPluginResult* pluginResult = nil;
        cv:Mat image;
        if ([imagePath containsString:@"file://"]) {
        
        // Strip file:// from imagePath where applicable
            imagePath = [imagePath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
            if (imagePath && [self.fileManager fileExistsAtPath:imagePath]) {
                image = imread([imagePath UTF8String], CV_LOAD_IMAGE_COLOR);
            }
            else {
                NSMutableDictionary* pluginError = [NSMutableDictionary dictionaryWithCapacity:3];
                [pluginError setValue:[NSNumber numberWithInt:CDV_FILE_NOT_FOUND] forKey:@"code"];
                [pluginError setValue:@"Image can't be found for given path." forKey:@"message"];
                [pluginError setValue:imagePath forKey:@"path"];
                
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:pluginError];
            }
        }
        //try base64
        else{
            string strpath = std::string([imagePath UTF8String]);
            string decoded_string = base64_decode(strpath);
            vector<uchar> data(decoded_string.begin(), decoded_string.end());
            
            image = imdecode(data, IMREAD_UNCHANGED);
        }

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
     

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }];
}

// Code from: http://www.adp-gmbh.ch/cpp/common/base64.html



static inline bool is_base64(unsigned char c) {
    return (isalnum(c) || (c == '+') || (c == '/'));
}

std::string base64_decode(std::string const& encoded_string) {
    int in_len = encoded_string.size();
    int i = 0;
    int j = 0;
    int in_ = 0;
    unsigned char char_array_4[4], char_array_3[3];
    std::string ret;
    
    while (in_len-- && (encoded_string[in_] != '=') && is_base64(encoded_string[in_])) {
        char_array_4[i++] = encoded_string[in_]; in_++;
        if (i == 4) {
            for (i = 0; i < 4; i++)
                char_array_4[i] = base64_chars.find(char_array_4[i]);
            
            char_array_3[0] = (char_array_4[0] << 2) + ((char_array_4[1] & 0x30) >> 4);
            char_array_3[1] = ((char_array_4[1] & 0xf) << 4) + ((char_array_4[2] & 0x3c) >> 2);
            char_array_3[2] = ((char_array_4[2] & 0x3) << 6) + char_array_4[3];
            
            for (i = 0; (i < 3); i++)
                ret += char_array_3[i];
            i = 0;
        }
    }
    
    if (i) {
        for (j = i; j < 4; j++)
            char_array_4[j] = 0;
        
        for (j = 0; j < 4; j++)
            char_array_4[j] = base64_chars.find(char_array_4[j]);
        
        char_array_3[0] = (char_array_4[0] << 2) + ((char_array_4[1] & 0x30) >> 4);
        char_array_3[1] = ((char_array_4[1] & 0xf) << 4) + ((char_array_4[2] & 0x3c) >> 2);
        char_array_3[2] = ((char_array_4[2] & 0x3) << 6) + char_array_4[3];
        
        for (j = 0; (j < i - 1); j++) ret += char_array_3[j];
    }
    
    return ret;
}


@end
