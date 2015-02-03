//
//  BISLoginService.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/31/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BISNetworkServiceDependant.h"

typedef void (^BISLoginServiceSuccessBlock) ();
typedef void (^BISLoginServiceFailureBlock) (NSString *errorMessage);

@class BISNetworkService;

@interface BISLoginService : NSObject <BISNetworkServiceDependant>

+ (BISLoginService *)loginService;

- (void)loginWithParameters:(NSDictionary *)parameters
                    success:(BISLoginServiceSuccessBlock)successBlock
                    failure:(BISLoginServiceFailureBlock)failureBlock;

@end
