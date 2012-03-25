#import <Foundation/Foundation.h>
#define UUID_USER_DEFAULTS_KEY @"UUID"

@interface UUID : NSObject {
    
    @public
        NSString *value;
}

+ (id)sharedInstance;
@end