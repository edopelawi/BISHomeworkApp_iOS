//
//  BISNetworkService.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/30/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkService.h"

#import <AFNetworking.h>


@interface BISNetworkService ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation BISNetworkService

- (instancetype)initWithRequestOperationManager:(AFHTTPRequestOperationManager *)manager
{
    self = [super init];
    
    if (self) {
        _operationManager = manager;
    }
    
    return self;
}

- (void)postToPath:(NSString *)path
        parameters:(NSDictionary *)parameters
           success:(BISNetworkServiceSuccessBlock)successBlock
           failure:(BISNetworkServiceFailureBlock)failureBlock
{
    [_operationManager POST:path
                 parameters:parameters
                    success:successBlock
                    failure:failureBlock];
}

- (void)getFromPath:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(BISNetworkServiceSuccessBlock)successBlock
            failure:(BISNetworkServiceFailureBlock)failureBlock
{
    [_operationManager GET:path
                parameters:parameters
                   success:successBlock
                   failure:failureBlock];
}

@end
