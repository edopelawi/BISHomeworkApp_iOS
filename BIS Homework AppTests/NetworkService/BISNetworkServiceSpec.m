//
//  BISNetworkServiceSpec.m
//  BIS Homework App
//
//  Created by Ricardo Pramana Suranta on 1/30/15.
//  Copyright (c) 2015 Ice House-Internship. All rights reserved.
//

#import "BISNetworkService.h"
#import <AFNetworking.h>

SpecBegin(NetworkService)

__block BISNetworkService *networkService;
__block id manager;
__block id serializer;

__block NSString *path;
__block NSDictionary *parameters;
__block BISNetworkServiceSuccessBlock successBlock;
__block BISNetworkServiceFailureBlock failureBlock;

beforeEach(^{
    NSURL *baseURL = [[NSURL alloc] initWithString:@"http://example.com"];
    
    manager = OCMPartialMock([[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL]);
    serializer = OCMPartialMock([AFHTTPRequestSerializer serializer]);
    OCMStub([manager requestSerializer]).andReturn(serializer);
    
    networkService = [[BISNetworkService alloc] initWithRequestOperationManager:manager];
    
    path = @"/dummy";
    parameters = @{@"param" : @"hello"};
    successBlock = ^(AFHTTPRequestOperation *operation, id response){};
    failureBlock = ^(AFHTTPRequestOperation *operation, NSError *error){};
});

describe(@"on postToPath:parameters:success:failure:", ^{
    
    beforeEach(^{
        [networkService postToPath:path
                        parameters:parameters
                           success:successBlock
                           failure:failureBlock];
    });
    
    it(@"should call operation manager's POST:parameters:success:failure method", ^{
        OCMVerify([manager POST:[OCMArg any]
                     parameters:[OCMArg any]
                        success:[OCMArg any]
                        failure:[OCMArg any]]);
    });
    
    it(@"should pass corresponding parameters to operation manager's method", ^{
        
        OCMVerify([manager POST:path
                     parameters:parameters
                        success:successBlock
                        failure:failureBlock]);
        
    });

});

describe(@"on getFromPath:parameters:success:failure:", ^{
    
    beforeEach(^{
        [networkService getFromPath:path
                         parameters:parameters
                            success:successBlock
                            failure:failureBlock];
    });
    
    it(@"should call operation manager's GET:parameters:success:failure method", ^{
        OCMVerify([manager GET:[OCMArg any]
                    parameters:[OCMArg any]
                       success:[OCMArg any]
                       failure:[OCMArg any]]);
    });
    
    it(@"should pass corresponding parameters to operation manager's method", ^{
        
        OCMVerify([manager GET:path
                    parameters:parameters
                       success:successBlock
                       failure:failureBlock]);
        
    });
    
});


SpecEnd