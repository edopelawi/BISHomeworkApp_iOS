//
//  BISNetworkService.h
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/30/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^BISNetworkServiceSuccessBlock) (id response);
typedef void (^BISNetworkServiceFailureBlock) (NSError *error);

@class AFHTTPRequestOperationManager;

@interface BISNetworkService : NSObject

+ (BISNetworkService *)networkService;

- (instancetype)initWithRequestOperationManager:(AFHTTPRequestOperationManager *)manager;

- (void)postToPath:(NSString *)path
        parameters:(NSDictionary *)parameters
           success:(BISNetworkServiceSuccessBlock)successBlock
           failure:(BISNetworkServiceFailureBlock)failureBlock;

- (void)getFromPath:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(BISNetworkServiceSuccessBlock)successBlock
            failure:(BISNetworkServiceFailureBlock)failureBlock;

@end
