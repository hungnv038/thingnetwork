//
//  TTExampleNetwork.h
//  ThingNetwork_Example
//
//  Created by Michael on 5/19/19.
//  Copyright © 2019 hungnv038. All rights reserved.
//

#import "TTHttpClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTExampleNetwork : TTHttpClient
-(void)getExampleData:(NetworkManagerSuccess)successFuc failure:(NetworkManagerFailure)failureFunc;
@end

NS_ASSUME_NONNULL_END
