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

- (void)showProgressHUD {
    [self hideProgressHUD];
     self.progressHUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] delegate].window animated:YES];
    [self.progressHUD removeFromSuperViewOnHide];
    self.progressHUD.bezelView.color = [UIColor colorWithWhite:0.0 alpha:1.0];
    self.progressHUD.contentColor = [UIColor whiteColor];
}

- (void)hideProgressHUD {
    if (self.progressHUD != nil) {
        [self.progressHUD hideAnimated:YES];
        [self.progressHUD removeFromSuperview];
        self.progressHUD = nil;
    }
}

- (NSString*)getError:(NSError*)error {
    if (error != nil) {
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        if (responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"message"] != nil && [[responseObject objectForKey:@"message"] length] > 0) {
            return [responseObject objectForKey:@"message"];
        }
    }
    return @"Server Error. Please try again later";
}

-(void)onSuccess:(id  _Nullable)responseObject progress:(BOOL)showProgress success:(NetworkManagerSuccess)successFunc {
    if(showProgress) {
        [self hideProgressHUD];
    }
    NSLog( @"%@", responseObject);
    if(successFunc != nil) {
        successFunc(responseObject);
    }
}

-(void)onFailure:(NSURLSessionDataTask * _Nullable)task error:(NSError * _Nonnull)error progress:(BOOL)showProgress failure:(NetworkManagerFailure)failureFunc {
    if(showProgress) {
        [self hideProgressHUD];
    }
    NSString *errorMessage = [self getError:error];
    if (failureFunc != nil) {
        NSLog( @"%@", errorMessage );
        failureFunc(errorMessage, ((NSHTTPURLResponse*)task.response).statusCode);
    }
}


-(void)get:(nonnull NSString *)api progress:(BOOL)showProgress parameters:(nullable id)params success:(NetworkManagerSuccess)successFunc failure:(NetworkManagerFailure)failureFunc {
    
    if(showProgress) {
        [self showProgressHUD];
    }
    
    [self GET:api parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self onSuccess:responseObject progress:showProgress success:successFunc];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self onFailure:task error:error progress:showProgress failure:failureFunc];
        
    }];
}

-(void)post:(nonnull NSString *)api progress:(BOOL)showProgress parameters:(nullable id)params success:(NetworkManagerSuccess)successFunc failure:(NetworkManagerFailure)failureFunc {
    
    if(showProgress) {
        [self showProgressHUD];
    }
    
    [self POST:api parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self onSuccess:responseObject progress:showProgress success:successFunc];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [self onFailure:task error:error progress:showProgress failure:failureFunc];
        
    }];
}

-(void)put:(nonnull NSString *)api progress:(BOOL)showProgress parameters:(nullable id)params success:(NetworkManagerSuccess)successFunc failure:(NetworkManagerFailure)failureFunc {
    
    if(showProgress) {
        [self showProgressHUD];
    }
    
    [self PUT:api parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self onSuccess:responseObject progress:showProgress success:successFunc];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self onFailure:task error:error progress:showProgress failure:failureFunc];
        
    }];
}

-(void)del:(nonnull NSString *)api progress:(BOOL)showProgress parameters:(nullable id)params success:(NetworkManagerSuccess)successFunc failure:(NetworkManagerFailure)failureFunc {
    
    if(showProgress) {
        [self showProgressHUD];
    }
    
    [self DELETE:api parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self onSuccess:responseObject progress:showProgress success:successFunc];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self onFailure:task error:error progress:showProgress failure:failureFunc];
        
    }];
}


@end
