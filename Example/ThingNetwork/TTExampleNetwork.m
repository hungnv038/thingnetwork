//
//  TTExampleNetwork.m
//  ThingNetwork_Example
//
//  Created by Michael on 5/19/19.
//  Copyright © 2019 hungnv038. All rights reserved.
//

#import "TTExampleNetwork.h"

@implementation TTExampleNetwork

-(void)getExampleData:(NetworkManagerSuccess)successFuc failure:(NetworkManagerFailure)failureFunc {
    TTHttpClient *httpClient = [TTHttpClient sharedInstance];
    [httpClient get:@"users" progress:TRUE parameters:nil success:^(id  _Nonnull responseObject) {
        successFuc(responseObject);
    } failure:^(NSString * _Nonnull failureReason, NSInteger statusCode) {
        failureFunc(failureReason, statusCode);
    }];
}

@end
