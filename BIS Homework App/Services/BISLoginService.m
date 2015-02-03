//
//  BISLoginService.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/31/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISLoginService.h"
#import "BISNetworkService.h"
#import "BISURLConstants.h"

#import <AFNetworking.h>

@interface BISLoginService ()

@property (nonatomic, strong) BISNetworkService *networkService;

@end

@implementation BISLoginService

+ (BISLoginService *)loginService
{
    BISNetworkService *networkService = [BISNetworkService networkService];
    return [[BISLoginService alloc] initWithNetworkService:networkService];
}

- (instancetype)initWithNetworkService:(BISNetworkService *)networkService
{
    NSParameterAssert(networkService);
    
    self = [super init];
    
    if (self) {
        _networkService = networkService;
    }
    
    return self;
}

- (void)loginWithParameters:(NSDictionary *)parameters
                    success:(BISLoginServiceSuccessBlock)successBlock
                    failure:(BISLoginServiceFailureBlock)failureBlock
{
    [_networkService postToPath:[BISURLConstantLoginPath copy]
                     parameters:parameters
                        success:^(id response) {
                            
                            if (successBlock) successBlock();
                        }
                        failure:^(NSError *error) {
                            NSString *message = [NSString stringWithFormat:@"Login failed. Error code : %@",@(error.code)];
                            
                            if (failureBlock) failureBlock(message);
                        }];
}

@end
