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

@interface BISLoginService ()

@property (nonatomic, strong) BISNetworkService *networkService;
@end

@implementation BISLoginService

- (instancetype)initWithNetworkService:(BISNetworkService *)networkService
{
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
                        success:^(AFHTTPRequestOperation *operation, id response) {
                            
                            if (successBlock) successBlock();
                        }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSString *message = [NSString stringWithFormat:@"Login failed. Error code : %@",@(error.code)];
                            
                            if (failureBlock) failureBlock(message);
                        }];
}

@end
