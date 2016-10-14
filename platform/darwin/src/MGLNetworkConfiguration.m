#import "MGLNetworkConfiguration_Private.h"
#import "NSProcessInfo+MGLAdditions.h"

@interface MGLNetworkConfiguration ()

@property (atomic) NSURL *apiBaseURL;

@end

@implementation MGLNetworkConfiguration

+ (void)load {
    // Read the initial configuration from Info.plist.
    NSString *apiBaseURL = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MGLMapboxAPIBaseURL"];
    if (apiBaseURL.length) {
        [self setAPIBaseURL:[NSURL URLWithString:apiBaseURL]];
    }
}

+ (instancetype)sharedManager {
    if (NSProcessInfo.processInfo.mgl_isInterfaceBuilderDesignablesAgent) {
        return nil;
    }
    static dispatch_once_t onceToken;
    static MGLNetworkConfiguration *_sharedManager;
    void (^setupBlock)() = ^{
        dispatch_once(&onceToken, ^{
            _sharedManager = [[self alloc] init];
        });
    };
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            setupBlock();
        });
    } else {
        setupBlock();
    }
    return _sharedManager;
}

+ (void)setAPIBaseURL:(NSURL *)apiBaseURL {
    [MGLNetworkConfiguration sharedManager].apiBaseURL = apiBaseURL;
}

+ (NSURL *)apiBaseURL {
    return [MGLNetworkConfiguration sharedManager].apiBaseURL;
}

@end
