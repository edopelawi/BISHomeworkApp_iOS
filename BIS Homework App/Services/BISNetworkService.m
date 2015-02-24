//
//  BISNetworkService.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/30/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkService.h"
#import "BISNetworkManagerFactory.h"

#import <AFNetworking.h>

@interface BISNetworkService ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation BISNetworkService

+ (BISNetworkService *)networkService
{
    AFHTTPRequestOperationManager *operationManager = [BISNetworkManagerFactory AFHTTPRequestOperationManager];
    
    return [[BISNetworkService alloc] initWithRequestOperationManager:operationManager];
}

- (instancetype)initWithRequestOperationManager:(AFHTTPRequestOperationManager *)manager
{
    NSParameterAssert(manager);
    
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
                    success:^(AFHTTPRequestOperation *operation, id requestObject) {
                        if (successBlock) successBlock(requestObject);
                    }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSInteger statusCode = operation.response.statusCode;
                        NSError *failureError = [[NSError alloc] initWithDomain:error.domain
                                                                           code:statusCode
                                                                       userInfo:error.userInfo];
                        
                        if (failureBlock) failureBlock(failureError);
                    }];
}

- (void)getFromPath:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(BISNetworkServiceSuccessBlock)successBlock
            failure:(BISNetworkServiceFailureBlock)failureBlock
{
    [_operationManager GET:path
                parameters:parameters
                   success:^(AFHTTPRequestOperation *operation, id requestObject) {
                       if (successBlock) successBlock(requestObject);
                   }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSInteger statusCode = operation.response.statusCode;
                       NSError *failureError = [[NSError alloc] initWithDomain:error.domain
                                                                          code:statusCode
                                                                      userInfo:error.userInfo];
                       
                       if (failureBlock) failureBlock(failureError);
                   }];
}

@end
