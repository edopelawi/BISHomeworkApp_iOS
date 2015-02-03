//
//  BISLoginService.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/31/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BISLoginServiceSuccessBlock) ();
typedef void (^BISLoginServiceFailureBlock) (NSString *errorMessage);

@class BISNetworkService;

@interface BISLoginService : NSObject

+ (BISLoginService *)loginService;

/// Deprecated. Use @c initWithNetworkService: instead.
- (instancetype)init __deprecated;

/// Initialization method for BISLoginService object. You should use this method instead of the normal @p init.
- (instancetype)initWithNetworkService:(BISNetworkService *)networkService;

- (void)loginWithParameters:(NSDictionary *)parameters
                    success:(BISLoginServiceSuccessBlock)successBlock
                    failure:(BISLoginServiceFailureBlock)failureBlock;

@end
