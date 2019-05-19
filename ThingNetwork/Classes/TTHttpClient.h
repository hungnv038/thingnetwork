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

-(void)get:(nonnull NSString *)api progress:(BOOL)showProgress parameters:(nullable id)params success:(NetworkManagerSuccess)successFunc failure:(NetworkManagerFailure)failureFunc;

-(void)post:(nonnull NSString *)api progress:(BOOL)showProgress parameters:(nullable id)params success:(NetworkManagerSuccess)successFunc failure:(NetworkManagerFailure)failureFunc;

-(void)put:(nonnull NSString *)api progress:(BOOL)showProgress parameters:(nullable id)params success:(NetworkManagerSuccess)successFunc failure:(NetworkManagerFailure)failureFunc;

-(void)del:(nonnull NSString *)api progress:(BOOL)showProgress parameters:(nullable id)params success:(NetworkManagerSuccess)successFunc failure:(NetworkManagerFailure)failureFunc;

@property (nonatomic, strong, nullable) MBProgressHUD *progressHUD;

@end

NS_ASSUME_NONNULL_END
