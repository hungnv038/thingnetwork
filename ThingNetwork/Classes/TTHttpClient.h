//
//  TTHttpClient.h
//  ThingNetwork
//
//  Created by Michael on 5/11/19.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {DEVELOPMENT, STAGING, PRODUCTION} ENV_MODES;

typedef void (^NetworkManagerSuccess)(id responseObject);
typedef void (^NetworkManagerFailure)(NSString *failureReason, NSInteger statusCode);

@interface TTHttpClient : AFHTTPSessionManager

+ (TTHttpClient *)sharedInstance;
+ (void)initDevUrl:(NSString *)dev StagingUrl:(NSString*)staging ProUrl:(NSString*)pro;
+ (void)setEnvMode:(ENV_MODES)mode;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

NS_ASSUME_NONNULL_END
