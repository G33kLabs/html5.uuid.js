#import "UUID.h"

@implementation UUID
 
static UUID *sharedInstance = nil;
 
// Get the shared instance and create it if necessary.
+ (UUID *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}
 
// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
     // Create a UUID and store it to defaults
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:UUID_USER_DEFAULTS_KEY] == nil) {
            [defaults setObject:[self createUUID] forKey:UUID_USER_DEFAULTS_KEY];
            [defaults synchronize];
        }
        self->value = [defaults objectForKey:UUID_USER_DEFAULTS_KEY] ;
    }
    
    // Output UUID
    //NSLog(@"UUID : %@", self->value) ;
    return self;
}

// Send uuid to webview
- (void) sendToWebview: (UIWebView*) webView {
    NSMutableString *result = [[NSMutableString alloc] initWithFormat:@"try { window.navigator = window.navigator || {}; window.navigator.uuid = '%@'; } catch(e) { }; ", self->value];
    //NSLog(@"UUID -> JS : %@", result) ;
    [webView stringByEvaluatingJavaScriptFromString: result];
    [result release];
}

// Generate a random UUID
-(NSString*) createUUID {
    NSString *uuidString = nil;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
        uuidString = (NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    return [uuidString autorelease];
}
 
// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).
-(void)dealloc
{
    // I'm never called!
    [super dealloc];
}
 
// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [[self sharedInstance] retain];
}
 
// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
 
// Once again - do nothing, as we don't have a retain counter for this object.
- (id)retain {
    return self;
}
 
// Replace the retain counter so we can never release this object.
- (NSUInteger)retainCount {
    return NSUIntegerMax;
}
 
// This function is empty, as we don't want to let the user release this object.
- (oneway void)release {
 
}
 
//Do nothing, other than return the shared instance - as this is expected from autorelease.
- (id)autorelease {
    return self;
}
 
@end