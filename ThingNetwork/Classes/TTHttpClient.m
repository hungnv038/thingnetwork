//
//  TTHttpClient.m
//  ThingNetwork
//
//  Created by Michael on 5/11/19.
//

#import "TTHttpClient.h"


@implementation TTHttpClient

static NSString *baseDevUrl;
static NSString *baseProUrl;
static NSString *baseStagingUrl;
static ENV_MODES envMode;

+ (TTHttpClient *)sharedInstance {
    
    static TTHttpClient *_devTTHttpClient = nil;
    static TTHttpClient *_stagingTTHttpClient = nil;
    static TTHttpClient *_proTTHttpClient = nil;
    
    static dispatch_once_t onceDevToken;
    static dispatch_once_t onceProToken;
    static dispatch_once_t onceStagingToken;
    
    dispatch_once(&onceDevToken, ^
                  {
                      NSURL *URL = [NSURL URLWithString:baseDevUrl];
                      _devTTHttpClient = [[self alloc] initWithBaseURL:URL];
                  });
    
    dispatch_once(&onceStagingToken, ^
                  {
                      NSURL *URL = [NSURL URLWithString:baseStagingUrl];
                      _stagingTTHttpClient = [[self alloc] initWithBaseURL:URL];
                  });
    
    dispatch_once(&onceProToken, ^
                  {
                      NSURL *URL = [NSURL URLWithString:baseProUrl];
                      _proTTHttpClient = [[self alloc] initWithBaseURL:URL];
                  });
    
    switch (envMode) {
        case DEVELOPMENT:
            return _devTTHttpClient;
            break;
        case STAGING:
            return _stagingTTHttpClient;
            break;
        case PRODUCTION:
            return _proTTHttpClient;
            break;
        default:
            return _devTTHttpClient;
            break;
    }
}

+ (void)initDevUrl:(NSString *)dev StagingUrl:(NSString *)staging ProUrl:(NSString *)pro {
    baseProUrl = pro;
    baseStagingUrl = staging;
    baseDevUrl = dev;
}

+ (void)setEnvMode:(ENV_MODES)mode {
    envMode = mode;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self)
    {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

@end
